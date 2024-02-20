# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do # rubocop:disable Metrics/BlockLength
  let(:user) { build(:user) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a phone number' do
      user.phone = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a first name' do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a last name' do
      user.last_name = nil
      expect(user).to_not be_valid
    end

    it 'is not valid with an invalid email format' do
      user.email = 'invalid_email'
      expect(user).to_not be_valid
    end

    it 'is not valid with an invalid phone format' do
      user.phone = 'invalid_phone'
      expect(user).to_not be_valid
    end

    it 'is valid with a valid account type' do
      expect(user).to allow_value('visitor', 'admin', 'employee').for(:account_type)
    end

    it 'is not valid with an invalid account type' do
      user.account_type = 'invalid_account_type'
      expect(user).to_not be_valid
    end

    it 'normalizes phone number before validation' do
      user.phone = '(097) 388-91-28'
      user.valid?
      expect(user.phone).to eq('0973889128')
    end
  end

  describe 'Creating UserSetting after creating User' do
    let(:user) { create(:user) }

    it 'creates UserSetting after creating User' do
      expect(User.all.count).to eq(UserSetting.all.count)
    end

    it 'has default data in UserSetting' do
      expect(user.user_setting.user_id).to eq(user.id)
      expect(user.user_setting.status).to eq('active')
      expect(user.user_setting.language).to eq('ua')
      expect(user.user_setting.deposit_required).to eq(true)
    end

    it 'has empty field Comment in UserSetting' do
      expect(user.user_setting.comment).to eq(nil)
    end
  end

  describe 'User scopes' do
    let!(:visitor) { create(:user) }
    let!(:admin) { create(:user, account_type: 'admin') }
    let!(:employee) { create(:user, account_type: 'employee') }

    it 'returns all visitors' do
      expect(User.all.count).to eq(3)
      expect(User.visitors.count).to eq(1)
      expect(User.visitors.first.account_type).to eq('visitor')
    end

    it 'returns all admins' do
      expect(User.all.count).to eq(3)
      expect(User.admins.count).to eq(1)
      expect(User.admins.first.account_type).to eq('admin')
    end

    it 'returns all employees' do
      expect(User.all.count).to eq(3)
      expect(User.employees.count).to eq(1)
      expect(User.employees.first.account_type).to eq('employee')
    end

    it 'returns all bunned users' do
      User.first.user_setting.update!(status: 'banned')
      expect(User.all.count).to eq(3)
      expect(User.banned.count).to eq(1)
      expect(User.banned.first.user_setting.status).to eq('banned')
    end
  end

  describe 'User model methods' do
    let!(:admin) do
      create(:user, account_type: 'admin')
    end
    let!(:employee) do
      create(:user, account_type: 'employee')
    end
    let!(:visitor) do
      create(:user, first_name: 'Yurii', last_name: 'Tsykvas', last_visit: Time.now - 2.days)
    end

    it 'returns full name' do
      expect(visitor.full_name).to eq('Yurii Tsykvas')
    end

    it 'checks is user an admin' do
      expect(admin.admin?).to eq(true)
      expect(employee.admin?).to eq(false)
      expect(visitor.admin?).to eq(false)
    end

    it 'checks is user an employee' do
      expect(admin.employee?).to eq(false)
      expect(employee.employee?).to eq(true)
      expect(visitor.employee?).to eq(false)
    end

    it 'checks is user an visitor' do
      expect(admin.visitor?).to eq(false)
      expect(employee.visitor?).to eq(false)
      expect(visitor.visitor?).to eq(true)
    end

    it 'checks is user banned' do
      expect(admin.visitor?).to eq(false)
      expect(employee.visitor?).to eq(false)
      expect(visitor.visitor?).to eq(true)
    end

    it 'checks have user visits or not' do
      expect(admin.visited?).to eq(false)
      expect(visitor.visited?).to eq(true)
    end
  end
end
