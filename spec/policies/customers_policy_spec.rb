require 'rails_helper'

RSpec.describe CustomersPolicy, type: :policy do
  let!(:user) { FactoryBot.create(:user) }

  subject { described_class }

  permissions :customers? do
    it "grants access to admin users" do
      user.update!(account_type: 'admin')
      expect(subject).to permit(user)
    end

    it "denies access to non-admin users" do
      expect(subject).not_to permit(user)
    end
  end
end
