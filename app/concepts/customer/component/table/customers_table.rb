# frozen_string_literal: true

class Customer::Component::Table::CustomersTable < ViewComponent::Base
  def initialize(customers)
    @customers = customers
  end
end
