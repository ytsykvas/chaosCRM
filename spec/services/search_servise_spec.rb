# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService, type: :service do
  describe '#search' do
    let(:user1) do
      create(:user, phone: '0504303352', last_visit: nil)
    end
    let(:user2) do
      create(:user, first_name: 'ЮрійТест', phone: '0934303352', last_visit: 2.months.ago)
    end
    let(:user3) do
      create(:user, phone: '0954303352', last_visit: 1.month.ago)
    end

    let(:user4) do
      create(:user, phone: '0974303352', last_visit: 1.day.ago)
    end

    let(:users) { [user1, user2, user3] }

    it 'returns all users if query is blank and no visit filter is provided' do
      search_service = SearchService.new(users)
      expect(search_service.search('')).to eq(users)
    end

    it "returns users with no last visit if 'NoLastVisit' filter is provided" do
      search_service = SearchService.new(users, 'NoLastVisit')
      expect(search_service.search('')).to eq([user1])
    end

    it "returns users with last visit older than 1 month if 'LastVisitOverMonth' filter is provided" do
      search_service = SearchService.new(users, 'LastVisitOverMonth')
      expect(search_service.search('').count).to eq(2)
      expect(search_service.search('').first&.email).to eq(user2.email)
      expect(search_service.search('').last&.email).to eq(user3.email)
    end

    it 'returns users matching the search query' do
      search_service = SearchService.new(users)
      expect(search_service.search('Юрійтест').count).to eq(1)
      expect(search_service.search('Юрійтест').first&.first_name).to eq(user2.first_name)
    end

    it 'filtering users with a phone number' do
      search_service = SearchService.new(users)
      expect(search_service.search('095').count).to eq(1)
      expect(search_service.search('095').first&.phone).to eq(user3.phone)
    end
  end

  describe '#get_filtered_ids' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }

    let(:users) { [user1, user2, user3] }

    it 'returns ids of filtered users' do
      search_service = SearchService.new(users)
      expect(search_service.get_filtered_ids).to eq([user1.id, user2.id, user3.id])
    end
  end
end
