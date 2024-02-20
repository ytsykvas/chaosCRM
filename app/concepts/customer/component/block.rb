# frozen_string_literal: true

class Customer::Component::Block < ViewComponent::Base
  def initialize(model:)
    # binding.irb
    @setting = model[:setting]
  end
end
