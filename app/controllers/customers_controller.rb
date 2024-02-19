# frozen_string_literal: true

class CustomersController < ApplicationController
  def index
    endpoint Customer::Operation::Index, Customer::Component::Index
  end

  def show
    endpoint Customer::Operation::Show, Customer::Component::Show
  end

  def edit
    endpoint Customer::Operation::Edit, Customer::Component::Edit
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
end
