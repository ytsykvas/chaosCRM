# frozen_string_literal: true

class Customer::Operation::Show < Operation::Base
  require 'will_paginate/array'

  def perform!(user:, params:)
    authorize!(:customers, :show?)

    customer = User.find(params[:id])
    visits = customer.visits_as_customer.includes(:employee).order(created_at: :desc).paginate(page: params[:page], per_page: 10)

    self.model = {
      user: user,
      customer: customer,
      visits: visits
    }
  end
end
