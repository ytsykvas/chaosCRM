# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer::Operation::Show do
  let!(:user) { create(:user, account_type: 'admin') }
  let(:visitor) { create(:user) }
  let(:employee) { create(:user, account_type: 'employee') }
  let(:valid_params) { ActionController::Parameters.new({ id: visitor.id }) }

  subject { described_class.new }

  before do
    allow_any_instance_of(described_class).to receive(:authorize!).and_return(nil)
  end


  describe '#perform!' do
    it 'returns the customer with his visits' do
      create_list(:visit, 5, visitor:, employee:)
      subject.perform!(user:, params: valid_params)

      expect(subject.result.model[:visits].count).to eq(5)
      expect(subject.result.model[:customer]).to eq(visitor)
    end

    it 'returns the customer without visits when there are not visits' do
      subject.perform!(user:, params: valid_params)

      expect(subject.result.model[:visits].count).to eq(0)
      expect(subject.result.model[:customer]).to eq(visitor)
    end
  end
end
