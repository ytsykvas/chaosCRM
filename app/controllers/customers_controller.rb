# frozen_string_literal: true

class CustomersController < ApplicationController
  require 'will_paginate/array'
  before_action :index_authorise_user, only: %i[index]
  before_action :show_authorise_user, only: %i[show]

  def index
    filtered_data = SearchService.new(User.visitors, params['visit_filter']).search(params.dig(:search, :query) || ' ')
    @customers = filtered_data.paginate(page: params[:page], per_page: 10)
    @customers_ids = SearchService.new(filtered_data).get_filtered_ids
  end

  def show
    @customer = User.find(params[:id])
  end

  def download_xls
    excel_generator = Customers::ExportXls.new(params['format'])
    send_file excel_generator.generate_excel, type: 'application/vnd.ms-excel', filename: 'AllCustomers.xls'
  end

  def no_last_visit
    query = { visit_filter: 'NoLastVisit' }
    redirect_to customers_path(query)
  end

  def old_last_visit
    query = { visit_filter: 'LastVisitOverMonth' }
    redirect_to customers_path(query)
  end

  private

  def index_authorise_user
    authorize :customers, :index?
  end

  def show_authorise_user
    authorize :customers, :show?
  end
end
