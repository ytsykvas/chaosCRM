# frozen_string_literal: true

class Customer::Component::Table::CustomerDataTable < ViewComponent::Base
  def initialize(customer, visits)
    @customer = customer
    @visits = visits
  end
end
