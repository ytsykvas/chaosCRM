# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeesPolicy, type: :policy do
  let!(:user) { FactoryBot.create(:user) }

  subject { described_class }

  permissions :index? do
    it 'grants access to admin users' do
      user.update!(account_type: 'admin')
      expect(subject).to permit(user)
    end

    it 'denies access to non-admin users' do
      expect(subject).not_to permit(user)
    end
  end

  permissions :show? do
    it 'grants access to admin users' do
      user.update!(account_type: 'admin')
      expect(subject).to permit(user)
    end

    it 'denies access to non-admin users' do
      expect(subject).not_to permit(user)
    end
  end

  permissions :edit? do
    it 'grants access to admin users' do
      user.update!(account_type: 'admin')
      expect(subject).to permit(user)
    end

    it 'denies access to non-admin users' do
      expect(subject).not_to permit(user)
    end
  end
end
