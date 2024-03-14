# frozen_string_literal: true

class Employee::Component::Table::TodayVisitsTable < ViewComponent::Base
  def initialize(visits)
    @visits = visits
  end
end
