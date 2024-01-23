class User < ApplicationRecord
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

	validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
	validates :phone, presence: true, format: { with: /\A\+?\d{10,15}\z/ }
	validates :first_name, presence: true, format: { with: /\A[\p{L}'][\p{L}'\-]{0,14}\z/u }
	validates :last_name, presence: true, format: { with: /\A[\p{L}'][\p{L}'\-]{0,14}\z/u }
	validates :account_type, inclusion: { in: %w(visitor admin employee) }
end
