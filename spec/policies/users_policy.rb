# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersPolicy, type: :policy do
  subject { described_class }

  permissions :update? do
    it 'grants access if user is admin' do
      user = FactoryBot.create(:user, account_type: 'admin')
      expect(subject).to permit(user)
    end

    it 'denies access if user is not present' do
      expect(subject).not_to permit(nil)
    end

    it 'denies access if user visitor' do
      user = FactoryBot.create(:user, account_type: 'visitor')
      expect(subject).not_to permit(user)
    end

    it 'denies access if user employee' do
      user = FactoryBot.create(:user, account_type: 'employee')
      expect(subject).not_to permit(user)
    end
  end
end
