# frozen_string_literal: true

class User::Operation::Update < Operation::Base
  def perform!(user:, params:)
    authorize!(:users, :update?)

    update_user(params)
  end

  private

  def update_user(params)
    User.find(params[:id]).update!(params_to_update(params))
  end

  def params_to_update(params)
    update_params = {}
    update_params[:first_name] = params['user']['first_name'] if params['user']['first_name'].present?
    update_params[:last_name] = params['user']['last_name'] if params['user']['last_name'].present?
    update_params[:phone] = params['user']['phone'] if params['user']['phone'].present?
    update_params[:email] = params['user']['email'] if params['user']['email'].present?
    update_params[:account_type] = params['user']['account_type'].presence if params['user']['account_type'].present?

    update_params
  end
end
