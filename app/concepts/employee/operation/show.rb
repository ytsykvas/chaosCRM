# frozen_string_literal: true

class Employee::Operation::Show < Operation::Base
  require 'will_paginate/array'

  def perform!(user:, params:)
    authorize!(:Employees, :show?)

    employee = User.find(params[:id])
    all_visits = employee.visits_as_employee
    today_visits = all_visits.where('DATE(visit_date) = ?', Date.today)

    self.model = {
      user: user,
      employee: employee,
      visits: {
        today_visits: today_visits,
        total_visits: all_visits.reject { |visit| visit.conclusion.blank? }.count
      }
    }
  end
end
