require 'rails_helper'

RSpec.describe Customer::Operation::Index do
  let!(:user) { create(:user, account_type: 'admin') }
  let(:all_user_params) { ActionController::Parameters.new({ 'search' => { 'query' => '' } }) }
  let(:phone_user_params) { ActionController::Parameters.new({ 'search' => { 'query' => '0934303352' } }) }
  let(:email_user_params) { ActionController::Parameters.new({ 'search' => { 'query' => 'tsykvas@gmail.com' } }) }
  let(:name_user_params) { ActionController::Parameters.new({ 'search' => { 'query' => 'Yurii Tsykvas' } }) }
  let(:last_visit_user_params) { ActionController::Parameters.new({ 'visit_filter' => 'LastVisitOverMonth' }) }
  let(:no_visit_user_params) { ActionController::Parameters.new({ 'visit_filter' => 'NoLastVisit' }) }
  let(:invalid_user_params) { ActionController::Parameters.new({ 'search' => { 'query' => '%|' } }) }
  before do
    allow_any_instance_of(described_class).to receive(:authorize!).and_return(nil)
    10.times { create(:user) }
  end

  subject { described_class.new }

  describe '#perform!' do
    it 'returns all customers when query is empty' do
      subject.perform!(user:, params: all_user_params)

      expect(subject.result.model[:customers].size).to eq(10)
    end

    it 'returns customer with required phone number' do
      User.last.update!(phone: '0934303352')

      subject.perform!(user:, params: phone_user_params)

      expect(subject.result.model[:customers].size).to eq(1)
      expect(subject.result.model[:customers].first.phone).to eq(User.last.phone)
    end

    it 'returns customer with required email' do
      User.last.update!(email: 'tsykvas@gmail.com')

      subject.perform!(user:, params: email_user_params)

      expect(subject.result.model[:customers].size).to eq(1)
      expect(subject.result.model[:customers].first.email).to eq(User.last.email)
    end

    it 'returns customer with required name' do
      User.last.update!(first_name: 'Yurii', last_name: 'Tsykvas')

      subject.perform!(user:, params: name_user_params)

      expect(subject.result.model[:customers].size).to eq(1)
      expect(subject.result.model[:customers].first.full_name).to eq(User.last.full_name)
    end

    it 'returns customers with last visit later then 1 month' do
      User.first.update!(last_visit: Time.now)
      User.last.update!(last_visit: Time.now - 3.months)

      subject.perform!(user:, params: last_visit_user_params)

      expect(subject.result.model[:customers].size).to eq(1)
      expect(subject.result.model[:customers].first.last_visit).to eq(User.last.last_visit)
    end

    it 'returns customers with no last visit' do
      User.visitors.all.last.update!(last_visit: Time.now - 1.day)

      subject.perform!(user:, params: no_visit_user_params)

      expect(subject.result.model[:customers].size).to eq(9)
      expect(subject.result.model[:customers].first.last_visit.present?).to eq(false)
      expect(subject.result.model[:customers].last.last_visit.present?).to eq(false)
    end

    it 'returns no customers when user have now data with querry data' do
      subject.perform!(user:, params: invalid_user_params)

      expect(subject.result.model[:customers].size).to eq(0)
    end
  end
end
