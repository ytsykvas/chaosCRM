# frozen_string_literal: true

FactoryBot.define do
  factory :visit do
    association :visitor, factory: :user, account_type: 'visitor'
    association :employee, factory: :user, account_type: 'employee'
    payment_status { 0 }
    visit_date { Faker::Time.backward(days: 14) }
    comment { Faker::Lorem.sentence }
    conclusion { { status: 'completed', services: 'makeup', gross: 500, net: 80, new_points: 10, used_points: 0 } }
  end
end
