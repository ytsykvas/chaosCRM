# frozen_string_literal: true

class ProfilesController < ApplicationController
  require 'will_paginate/array'

  def customers
    @customers = User.visitors
    filtered_data = SearchService.new(@customers, params['visit_filter']).search(params.dig(:search, :query) || ' ')
    @customers = filtered_data.paginate(page: params[:page], per_page: 10)
  end

  # def download_xls
  #   excel_generator = Customers::ExportExcel.new(@customers)
  #   send_file excel_generator.generate_excel, type: 'application/vnd.ms-excel', filename: 'AllCustomers.xls'
  # end

  def no_last_visit
    query = { visit_filter: 'NoLastVisit' }
    redirect_to customers_profiles_path(query)
  end

  def old_last_visit
    query = { visit_filter: 'LastVisitOverMonth' }
    redirect_to customers_profiles_path(query)
  end
end
