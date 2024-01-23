class User < ApplicationRecord
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable

	# validates :email, presence: true
	# validates :phone, presence: true
	# validates :first_name, presence: true
	# validates :last_name, presence: true
end
