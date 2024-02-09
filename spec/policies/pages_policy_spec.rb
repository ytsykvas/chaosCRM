# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesPolicy, type: :policy do
  subject { described_class }

  permissions :profile? do
    it 'grants access if user is present' do
      user = FactoryBot.create(:user)
      expect(subject).to permit(user)
    end

    it 'denies access if user is not present' do
      expect(subject).not_to permit(nil)
    end
  end
end
