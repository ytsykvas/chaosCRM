class EmployeesController < ApplicationController
  def index
    endpoint Employee::Operation::Index, Employee::Component::Index
  end

  def show
    endpoint Employee::Operation::Show, Employee::Component::Show
  end

  # def edit
  #   endpoint Employee::Operation::Edit, Employee::Component::Edit
  # end
end
