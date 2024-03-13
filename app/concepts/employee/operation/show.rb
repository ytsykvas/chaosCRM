# frozen_string_literal: true

class Employee::Operation::Show < Operation::Base
  require 'will_paginate/array'

  def perform!(user:, params:)
    authorize!(:Employees, :show?)

    employee = User.find(params[:id])

    self.model = {
      user: user,
      employee: employee
    }
  end
end
