# frozen_string_literal: true

module Customers
  class ExportXls
    def initialize(ids)
      @ids = ids
    end

    def generate_excel
      book = Spreadsheet::Workbook.new
      sheet = book.create_worksheet(name: 'Customers')
      document_header(sheet)
      row_index = 1

      find_customers.each do |customer|
        row_index += 1
        customer_data(customer, sheet, row_index)
      end

      book.write('customers.xls')
      'customers.xls'
    end

    def document_header(sheet)
      sheet.row(0).default_format = Spreadsheet::Format.new(weight: :bold)
      sheet.row(0).push('All my customers:')
      sheet.row(1).push('Number', 'Full name', 'Email', 'Phone', 'Last Visit')
    end

    def customer_data(customer, sheet, row_index)
      sheet[row_index, 0] = row_index - 1
      sheet[row_index, 1] = customer.full_name
      sheet[row_index, 2] = customer.email
      sheet[row_index, 3] = customer.phone
      sheet[row_index, 4] = customer.last_visit.present? ? customer.last_visit.to_date.to_s : 'Never'
    end

    def find_customers
      User.where(id: @ids.split('/'))
    end
  end
end
