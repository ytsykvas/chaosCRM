# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do # rubocop:disable Metrics/BlockLength
  let(:user) { build(:user) }

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
