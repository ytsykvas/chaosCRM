# frozen_string_literal: true

module Operation
  class Base
    attr_accessor :result

    def self.call(**args)
      ops = new(**args).tap(&:call)
      ops.result
    end

    def initialize(**attrs)
      @attrs = attrs
      @result = Operation::Result.new
    end

    def call
      perform!(**@attrs)
    rescue ActiveRecord::RecordInvalid => e
      add_errors e.record&.errors
    ensure
      copy_errors_from_result_to_model
      copy_custom_attributes
    end

    private

    def copy_errors_from_result_to_model
      return if model.nil? || !model.respond_to?(:errors)

      result.errors[:base].each do |message|
        model.errors.add(:base, message) unless model.errors[:base].include?(message)
      end
    end

    def copy_custom_attributes
      # This method can be overriden by subclasses to add custom copy for
      # attributes, e.g. associated models.
    end

    def notice(text, level: :notice)
      @result[:notice] = {
        text:,
        level:
      }
    end

    def model=(model)
      @result[:model] = model
    end

    def model
      @result[:model]
    end

    def add_error(key, message)
      @result.errors.add :base, key, message:
    end

    def add_errors(from)
      return if from.nil?

      from.each do |error|
        from[error.attribute].each do |error_msg|
          @result.errors.add(error.attribute, error_msg)
        end
      end
    end

    ### form_object methods ###

    def validate!(form_object, params)
      return if form_object.validate params

      @result[:model] = form_object.model
      form_object.errors.messages.each do |attr, messages|
        messages.each do |message|
          result.errors.add(attr, message)

          *path, attribute = attr.to_s.split('.')
          target_model = model

          target_model = target_model.public_send(path.shift) while path.present?

          next if target_model.errors.nil?

          target_model.errors.add(attribute, message)
        end
      end
      raise ActiveRecord::RecordInvalid
    end

    ### Run sub operations ###

    def run_operation(operation_class, parameters)
      manually_handle_errors = parameters[:manually_handle_errors].to_b
      parameters.except!(:manually_handle_errors)
      run_result = operation_class.new(**parameters).tap(&:call).result
      result.sub_results << run_result
      if !manually_handle_errors && run_result.present? && run_result.failure?
        add_errors run_result.errors
        raise ActiveRecord::RecordInvalid
      end
      run_result
    end

    ### Authorization methods ###

    # def authorize!(record, query, policy: Pundit.policy!(@attrs[:user_context], record), fail_message: nil)
    def authorize!(record, query, policy: Pundit.policy!(@attrs[:user], record), fail_message: nil)
      if policy.public_send(query)
        @result[:pundit] = true
        return
      end

      raise Pundit::NotAuthorizedError, fail_message if fail_message.present?

      raise Pundit::NotAuthorizedError, query:, record:, policy:
    end

    def policy_scope(scope)
      @result[:pundit_scope] = true
      Pundit.policy_scope!(@attrs[:user_context], scope)
    end

    def skip_authorize
      @result[:pundit] = true
    end

    def skip_policy_scope
      @result[:pundit_scope] = true
    end

    ### Form Object methods ###

    def validate_form_object(form_object)
      return if form_object.valid?

      add_errors form_object.errors

      # We need to invalid the form object explicitly in case there are errors
      # on subforms that aren't reported at the form level.
      result.invalid!

      raise ActiveRecord::RecordInvalid
    end

    def parse_validate_sync(form_object, model = self.model)
      # Store the valid state, some places we do checks against the model and if we call 'valid?' mulitple times
      # the validation can fail the 2nd time as we have then synced the form object with the model.
      from_is_valid = form_object.valid?
      if form_object != model
        form_object.sync_to model

        # We only check model validation if the form object is valid
        # This is since when we call model.validate, the form object validations
        # will be overwritten
        model.validate if from_is_valid
      end

      create_attachment!(form_object) if form_object.attachments? && model.errors.empty?

      return if model.errors.empty?

      add_errors model.errors
      raise ActiveRecord::RecordInvalid
    end

    def transfer_errors(from:, to:)
      from.errors.messages.each do |key, msgs|
        msgs.each { |msg| to.errors.add(key, msg) }
      end
    end

    def create_attachment!(form_object)
      # Needs to be put transaction, since attaching file will create records in the database
      raise 'Implementation error. Create attachment needs to be in a database transaction.' if transaction_closed?

      form_object.validate
      form_object.errors.each do |error|
        model.errors.add(error.attribute, error.message)
      end
      unless model.errors.empty?
        add_errors model.errors
        result.invalid!
        raise ActiveRecord::RecordInvalid
      end
      form_object.attachment_properties.each do |param_name|
        model.public_send("#{param_name}=", form_object.public_send(param_name.to_s))
      end
      model.validate
    end

    def toggle_reminder(source:, user_context:)
      return unless source.respond_to?(:remindable?)

      run_operation(Reminder::Operation::ToggleReminder,
                    model: source,
                    user_context:,
                    due_on: source.due_date,
                    enable: !source.settled?)
    end

    def authorize_and_save!(auth_method = nil)
      auth_method ||= model.new_record? ? :create? : :update?
      authorize! model, auth_method
      model.save!
    end

    def transaction_closed?
      ActiveRecord::Base.connection.open_transactions.zero?
    end
  end
end
