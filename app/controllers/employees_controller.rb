class EmployeesController < ApplicationController
  def index
    endpoint Employee::Operation::Index, Employee::Component::Index
  end

  def show
    endpoint Employee::Operation::Show, Employee::Component::Show
  end

  def edit
    endpoint Employee::Operation::Edit, Employee::Component::Edit
  end

  def update
    endpoint Employee::Operation::Update do |result|
      if result.errors.present?
        redirect_to employee_path(params[:id]), alert: t('employees.edit.error_update')
      else
        redirect_to employee_path(params[:id]), notice: t('employees.edit.success_update')
      end
    end
  end
end
