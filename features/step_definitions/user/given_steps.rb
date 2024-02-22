# frozen_string_literal: true

Given(/^We register (.*?) user/) do |type|
  visit new_user_registration_path

  find("[data-test-id='first-name-input']").fill_in(with: 'Test')
  find("[data-test-id='last-name-input']").fill_in(with: type.to_s.capitalize)
  find("[data-test-id='email-input']").fill_in(with: Faker::Internet.email)
  find("[data-test-id='phone-number-input']").fill_in(with: Faker::PhoneNumber.phone_number)
  find("[data-test-id='password-input']").fill_in(with: 'blink182')
  find("[data-test-id='password-confirmation-input']").fill_in(with: 'blink182')
  find('input[type="submit"]').click
  User.last.update!(account_type: type)
end

Given(/^We have (.*?) customers/) do |number|
  number.to_i.times { FactoryBot.create(:user) }
end

Given(/^The last customer have this phone number "(.*?)"/) do |number|
  User.visitors.last.update(phone: number)
end

Given(/^The last customer have this first name "(.*?)"/) do |name|
  User.visitors.last.update(first_name: name)
end

Given(/^(.*?) customers used our service later then 1 month/) do |number|
  User.visitors.limit(number.to_i).each { |user| user.update!(last_visit: 2.months.ago) }
end
