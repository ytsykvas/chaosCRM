# frozen_string_literal: true

class Employee::Component::Table::VisitsTable < ViewComponent::Base
  def initialize(visits, type)
    @visits = visits
    @type = type
  end
end
