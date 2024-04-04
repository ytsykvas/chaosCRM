# frozen_string_literal: true

class Employee::Operation::Edit < Operation::Base
  def perform!(user:, params:)
    authorize!(:employees, :edit?)
    employee = User.find(params[:id])

    self.model = {
      employee: employee
    }
  end
end
