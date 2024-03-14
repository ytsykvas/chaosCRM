# frozen_string_literal: true

class Employee::Component::Table::EmployeeDataTable < ViewComponent::Base
  def initialize(employee, total_visits)
    @employee = employee
    @total_visits = total_visits
  end
end
