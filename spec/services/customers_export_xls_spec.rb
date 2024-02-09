# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customers::ExportXls do
  let(:user1) { create(:user, last_visit: nil) }
  let(:user2) { create(:user, last_visit: 2.months.ago) }
  let(:user3) { create(:user, last_visit: 1.month.ago) }

  let(:ids) { "#{user1.id}/#{user2.id}/#{user3.id}" }
  let(:excel_generator) { described_class.new(ids) }

  describe '#generate_excel' do
    it 'creates an Excel file with customer data' do
      filename = excel_generator.generate_excel
      expect(File.exist?(filename)).to be_truthy

      workbook = Spreadsheet.open(filename)
      sheet = workbook&.worksheet(0)

      expect(sheet[0, 0]).to eq('All my customers:')
      expect(sheet[1, 0]).to eq('Number')
      expect(sheet[1, 1]).to eq('Full name')
      expect(sheet[1, 2]).to eq('Email')
      expect(sheet[1, 3]).to eq('Phone')
      expect(sheet[1, 4]).to eq('Last Visit')

      expect(sheet[2, 0]).to eq(1)
      expect(sheet[2, 1]).to eq(user1.full_name)
      expect(sheet[2, 2]).to eq(user1.email)
      expect(sheet[2, 3]).to eq(user1.phone)
      expect(sheet[2, 4]).to eq('Never')

      expect(sheet[3, 0]).to eq(2)
      expect(sheet[3, 1]).to eq(user2.full_name)
      expect(sheet[3, 2]).to eq(user2.email)
      expect(sheet[3, 3]).to eq(user2.phone)
      expect(sheet[3, 4]).to eq(user2.last_visit.to_date.to_s)

      expect(sheet[4, 0]).to eq(3)
      expect(sheet[4, 1]).to eq(user3.full_name)
      expect(sheet[4, 2]).to eq(user3.email)
      expect(sheet[4, 3]).to eq(user3.phone)
      expect(sheet[4, 4]).to eq(user3.last_visit.to_date.to_s)

      File.delete(filename)
    end
  end
end
