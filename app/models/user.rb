# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :visits_as_customer, class_name: 'Visit', foreign_key: 'visitor_id', dependent: :destroy
  has_many :visits_as_employee, class_name: 'Visit', foreign_key: 'employee_id', dependent: :nullify

  has_one :user_setting, dependent: :destroy

  after_create :create_user_setting
  before_validation :normalize_phone_number, :normalize_name

  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :phone, presence: true, format: { with: /\A\+?\d{10,15}\z/ }
  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 20 }
  validates :account_type, inclusion: { in: %w[visitor admin employee] }

  scope :visitors, -> { where(account_type: 'visitor') }
  scope :admins, -> { where(account_type: 'admin') }
  scope :employees, -> { where(account_type: 'employee') }
  scope :banned, -> { joins(:user_setting).where(user_settings: { status: :banned }) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    account_type == 'admin'
  end

  def employee?
    account_type == 'employee'
  end

  def visitor?
    account_type == 'visitor'
  end

  def visited?
    last_visit.present?
  end

  def banned?
    user_setting.present? && user_setting.status == 'banned'
  end

  private

  def normalize_phone_number
    self.phone = phone.gsub(/\D/, '') if phone.present?
  end

  def normalize_name
    self.first_name = first_name.downcase.capitalize if first_name.present?
    self.last_name = last_name.downcase.capitalize if last_name.present?
  end

  def create_user_setting
    build_user_setting.save
  end
end
