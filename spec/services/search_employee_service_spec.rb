# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchEmployeeService, type: :service do
  describe '#search' do
    let(:user1) { create(:user, first_name: 'John', last_name: 'Doe', phone: '0501234567', email: 'john@example.com') }
    let(:user2) { create(:user, first_name: 'Jane', last_name: 'Doe', phone: '0507654321', email: 'jane@example.com') }
    let(:user3) { create(:user, first_name: 'Bob', last_name: 'Smith', phone: '0509876543', email: 'bob@example.com') }
    let(:users) { [user1, user2, user3] }

    it 'returns all users if query is blank' do
      search_service = SearchEmployeeService.new(users)
      expect(search_service.search('')).to eq(users)
    end

    it 'returns users matching the search query by first name, last name, phone, or email' do
      search_service = SearchEmployeeService.new(users)
      expect(search_service.search('John').count).to eq(1)
      expect(search_service.search('John').first.first_name).to eq(user1.first_name)
      expect(search_service.search('Doe').count).to eq(2)
      expect(search_service.search('050').count).to eq(3)
      expect(search_service.search('john@example.com').count).to eq(1)
    end
  end
end
