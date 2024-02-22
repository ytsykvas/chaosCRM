# frozen_string_literal: true

When(/I visit (.*?) page/) do |page|
  path = case page
         when 'sign up'
           new_user_registration_path
         when 'log in'
           new_user_session_path
         when 'main'
           root_path
         when 'profile'
           profile_path
         when 'customers'
           customers_path
         when 'first customer'
           customer_path(1)
         end
  visit path
end

When(/I visit (.*?) number (.*?)/) do |_model, id|
  customer_path(id.to_i)
  visit path
end

When(/I fill "(.*?)" in the (.*?) (field|select box)/) do |text, field_test_id, type|
  hash_of_data_test_id = {
    # Devise
    'email': 'email-input',
    'password': 'password-input',
    'password confirmation': 'password-confirmation-input',
    'phone number': 'phone-input',
    'first name': 'first-name-input',
    'last name': 'last-name-input',
    'search': 'search_field',
    # block customer
    'ban reason': 'block-reason-input',
    # customers # edit
    '': ''
  }.stringify_keys

  input_element = find("[data-test-id='#{hash_of_data_test_id[field_test_id.downcase]}']")
  if type == 'field'
    input_element.fill_in(with: text)
  elsif type == 'select box'
    input_element.select(text)
  end
end

When(/I click on the (.*?) (link|button)/) do |test_id, type|
  link_test_id = {
    # dashboard
  }
  button_test_id = {
    # Base
    'submit': 'submit_button',
    'sign in': 'log_in_button',
    'sign out': 'log_out_button',
    'search': 'search_button',
    'have never been': 'never_been_button',
    'long time ago': 'long_time_button',
    'skip filters': 'skip_filters_button',
    'download XLS': 'download_xls_button',
    # customers show
    'edit user': 'edit-user-button',
    'ban user': 'ban-user-button',
    'unban user': 'unban-user-button'
  }.stringify_keys
  object = case type
           when 'link'
             link_test_id[test_id.downcase]
           when 'button'
             button_test_id[test_id]
           else
             'unknown test id'
           end
  find("[data-test-id='#{object}']").click
end

When(/^I submit the form$/) do
  find('input[type="submit"]').click
end
