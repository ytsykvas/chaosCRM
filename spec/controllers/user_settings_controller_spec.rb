require 'rails_helper'

RSpec.describe UserSettingsController, type: :controller do
  let!(:user) { create(:user, account_type: 'admin') }
  let!(:visitor) { create(:user, last_name: 'Tsykvas') }

  before { sign_in user }

  describe 'POST #block_customer' do
    it 'blocks a customer' do
      params = { user_setting: { user_id: visitor.id, comment: 'Blocked for test' } }
      post :block_customer, params: params
      expect(response).to redirect_to(customer_path(visitor))
      expect(User.banned.count).to eq(1)
      expect(User.banned.last.user_setting.comment).to eq(params[:user_setting][:comment])
    end
  end

  describe 'PUT #unblock_customer' do
    it 'unblocks a customer' do
      visitor.user_setting.update!(status: 'banned', comment: 'Blocked for test')
      put :unblock_customer, params: { format: visitor.id }

      expect(response).to redirect_to(customer_path(visitor))
      expect(User.banned.count).to eq(0)
      expect(User.find_by(last_name: 'Tsykvas').user_setting.comment).to eq(nil)
    end
  end
end
