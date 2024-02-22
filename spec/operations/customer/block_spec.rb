# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer::Operation::Block do
  let!(:user) { create(:user, account_type: 'admin') }
  let!(:visitor) { create(:user) }
  let(:valid_params) { ActionController::Parameters.new({ id: visitor.id }) }

  subject { described_class.new }

  before do
    allow_any_instance_of(described_class).to receive(:authorize!).and_return(nil)
  end

  describe '#perform!' do
    context 'when user setting exists' do
      it 'returns the existing user setting' do
        subject.perform!(user:, params: valid_params)

        expect(subject.result.model[:setting]).to eq(visitor.user_setting)
      end
    end

    context 'when user setting does not exist' do
      it 'creates a new user setting' do
        UserSetting.destroy_all

        subject.perform!(user:, params: valid_params)

        expect(subject.result.model[:setting]).to be_persisted
        expect(subject.result.model[:setting].user).to eq(visitor)
      end
    end
  end
end
