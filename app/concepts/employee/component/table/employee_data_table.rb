# frozen_string_literal: true

class Employee::Component::Table::EmployeeDataTable < ViewComponent::Base
  def initialize(employee, total_visits)
    @employee = employee
  end
end
