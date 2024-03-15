# frozen_string_literal: true

class Employee::Operation::Show < Operation::Base
  require 'will_paginate/array'

  def perform!(user:, params:)
    authorize!(:Employees, :show?)

    employee = User.find(params[:id])
    all_visits = employee.visits_as_employee.includes([:visitor])
    today_visits = all_visits.where('DATE(visit_date) = ?', Date.today)
    without_conclusion = all_visits.where(conclusion: nil).paginate(page: params[:page], per_page: 5)

    self.model = {
      user: user,
      employee: employee,
      visits: {
        today_visits: today_visits,
        without_conclusion: without_conclusion
      }
    }
  end
end
