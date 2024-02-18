# frozen_string_literal: true

class Customer::Operation::Index < Operation::Base
  require 'will_paginate/array'

  def perform!(user:, params:)
    authorize!(:customers, :index?)

    filtered_data = SearchService.new(User.visitors, params['visit_filter']).search(params.dig(:search, :query) || ' ')
    customers = filtered_data.paginate(page: params[:page], per_page: 10)
    customers_ids = SearchService.new(filtered_data).get_filtered_ids

    self.model = {
      user: user,
      customers: customers,
      customers_ids: customers_ids
    }
  end
end
