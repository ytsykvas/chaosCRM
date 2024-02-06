FactoryBot.define do
	factory :user do
		email { Faker::Internet.email }
		phone { Faker::PhoneNumber.phone_number }
		first_name { Faker::Name.first_name }
		last_name { Faker::Name.last_name }
		password { Faker::Internet.password(min_length: 8) }
		account_type { %w(visitor admin employee).sample }
		created_at { Faker::Time.backward(days: 30) }
		updated_at { Faker::Time.backward(days: 15) }
		remember_created_at { nil }
	end
end