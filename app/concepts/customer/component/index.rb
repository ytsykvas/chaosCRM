# frozen_string_literal: true

class Customer::Component::Index < ViewComponent::Base
  def initialize(model:)
    @customers = model[:customers]
    @customers_ids = model[:customers_ids]
  end
end
