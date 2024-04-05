# frozen_string_literal: true

class Employee::Component::Table::VisitsTable < ViewComponent::Base
  def initialize(visits, type, title = nil)
    @visits = visits
    @type = type
    @title = title
  end
end
