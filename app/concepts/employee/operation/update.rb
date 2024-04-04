# frozen_string_literal: true

class Employee::Operation::Update < Operation::Base
  def perform!(user:, params:)
    authorize!(:employees, :update?)

    update_employee(params)
  end

  def update_employee(params)
    user = User.find(params[:id])
    user.update!(
                  first_name: params[:user][:first_name],
                  last_name: params[:user][:last_name],
                  phone: params[:user][:phone],
                  email: params[:user][:email]
    )
  end
end
