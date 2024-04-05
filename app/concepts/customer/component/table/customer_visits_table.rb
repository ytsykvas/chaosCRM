# frozen_string_literal: true

class Customer::Component::Table::CustomerVisitsTable < ViewComponent::Base
  def initialize(visits, title = nil)
    @visits = visits
    @title = title
  end
end
