# frozen_string_literal: true

class Customer::Component::Block < ViewComponent::Base
  def initialize(model:)
    @setting = model[:setting]
  end
end
