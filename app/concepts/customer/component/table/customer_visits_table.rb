# frozen_string_literal: true

class Customer::Component::Table::CustomerVisitsTable < ViewComponent::Base
  def initialize(visits)
    @visits = visits
  end
end
