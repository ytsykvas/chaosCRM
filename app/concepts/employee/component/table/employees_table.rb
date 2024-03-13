# frozen_string_literal: true

class Employee::Component::Table::EmployeesTable < ViewComponent::Base
  def initialize(employees)
    @employees = employees
  end
end
