# frozen_string_literal: true

class ProfilesController < ApplicationController
  require 'will_paginate/array'

  def customers
    @customers = User.visitors
    filtered_data = SearchService.new(@customers).search(params.dig(:search, :query) || ' ')
    @customers = filtered_data.paginate(page: params[:page], per_page: 10)
  end
end
