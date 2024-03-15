# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee::Operation::Index do
  let!(:admin_user) { create(:user, account_type: 'admin') }
  let(:search_params) { ActionController::Parameters.new({ 'search' => { 'query' => 'John Doe' } }) }
  let(:empty_search_params) { ActionController::Parameters.new({ 'search' => { 'query' => '' } }) }
  let(:invalid_search_params) { ActionController::Parameters.new({ 'search' => { 'query' => '%|' } }) }

  before do
    allow_any_instance_of(described_class).to receive(:authorize!).and_return(nil)
    10.times { create(:user, account_type: 'employee') }
  end

  subject { described_class.new }

  describe '#perform!' do
    it 'returns all employees when search query is empty' do
      subject.perform!(user: admin_user, params: empty_search_params)

      expect(subject.result.model[:employees].size).to eq(10)
    end

    it 'returns employees matching the search query' do
      User.last.update!(first_name: 'John', last_name: 'Doe')

      subject.perform!(user: admin_user, params: search_params)

      expect(subject.result.model[:employees].size).to eq(1)
      expect(subject.result.model[:employees].first.full_name).to eq(User.last.full_name)
    end

    it 'returns no employees when search query is invalid' do
      subject.perform!(user: admin_user, params: invalid_search_params)

      expect(subject.result.model[:employees].size).to eq(0)
    end
  end
end
