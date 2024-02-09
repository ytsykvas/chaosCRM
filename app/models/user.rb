# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_validation :normalize_phone_number, :normalize_name

  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :phone, presence: true, format: { with: /\A\+?\d{10,15}\z/ }
  validates :first_name, presence: true, format: { with: /\A[\p{L}'][\p{L}'-]{0,14}\z/u }
  validates :last_name, presence: true, format: { with: /\A[\p{L}'][\p{L}'-]{0,14}\z/u }
  validates :account_type, inclusion: { in: %w[visitor admin employee] }

  scope :visitors, -> { where(account_type: 'visitor') }
  scope :admins, -> { where(account_type: 'admin') }
  scope :employees, -> { where(account_type: 'employee') }

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    account_type == 'admin'
  end

  private

  def normalize_phone_number
    self.phone = phone.gsub(/\D/, '') if phone.present?
  end

  def normalize_name
    self.first_name = first_name.downcase.capitalize if first_name.present?
    self.last_name = last_name.downcase.capitalize if last_name.present?
  end
end
