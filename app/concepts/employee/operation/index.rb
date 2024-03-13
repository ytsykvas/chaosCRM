# frozen_string_literal: true

class Employee::Operation::Index < Operation::Base
  require 'will_paginate/array'

  def perform!(user:, params:)
    authorize!(:employees, :index?)

    filtered_data = SearchEmployeeService.new(User.employees).search(params.dig(:search, :query) || ' ')
    employees = filtered_data.paginate(page: params[:page], per_page: 10)

    self.model = {
      user: user,
      employees: employees
    }
  end
end
