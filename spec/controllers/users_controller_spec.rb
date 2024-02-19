require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'PATCH #update' do
    let(:user) { create(:user, account_type: 'admin') }
    let(:visitor) { create(:user) }

    before { sign_in user }

    context 'with valid params' do
      it 'redirects to customers path with a success notice when we have first mame and last name' do
        patch :update, params: { id: visitor.id, user: { first_name: 'John', last_name: 'Doe' } }
        expect(flash[:notice]).to eq(I18n.t('customers.edit.success_update'))
      end

      it 'redirects to customers path with a success notice when we have all possible params' do
        patch :update, params: { id: visitor.id, user: {
                                                          first_name: 'John',
                                                          last_name: 'Doe',
                                                          phone: '0934303352',
                                                          email: 'example@gmail.com',
                                                          account_type: 'employee' } }
        expect(flash[:notice]).to eq(I18n.t('customers.edit.success_update'))
      end
    end

    context 'with invalid params' do
      it 'redirects to customers path with an error alert' do
        patch :update, params: { id: visitor.id, user: { email: '1111' } }
        expect(flash[:alert]).to eq(I18n.t('customers.edit.error_update'))
      end
    end
  end
end
