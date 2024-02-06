# frozen_string_literal: true

Given(/^We register a visitor$/) do
  visit new_user_registration_path

  find("[data-test-id='first-name-input']").fill_in(with: 'Test')
  find("[data-test-id='last-name-input']").fill_in(with: 'User')
  find("[data-test-id='email-input']").fill_in(with: Faker::Internet.email)
  find("[data-test-id='phone-number-input']").fill_in(with: Faker::PhoneNumber.phone_number)
  find("[data-test-id='password-input']").fill_in(with: 'blink182')
  find("[data-test-id='password-confirmation-input']").fill_in(with: 'blink182')
  find('input[type="submit"]').click
end
