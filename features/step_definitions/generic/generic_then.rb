# frozen_string_literal: true

Then('I click submit') do
  all('[type="submit"]').last.click
end

Then(/(After waiting max (\d*) seconds )?I (should see|should not see) the text: (.*)/) do |wait, see_or_not, key|
  hash_of_i18n_keys = {
    # Devise
    'sign up title': 'devise.registrations.new.title',
    'email field label': 'devise.registrations.new.email',
    'password field label': 'devise.registrations.new.password',
    'success registration alert': 'devise.registrations.signed_up',
    'signed in alert': 'devise.sessions.signed_in',
    'forgot password': 'devise.shared_links.forgot_password',
    'Signed out': 'devise.sessions.already_signed_out',
    # navbar
    'main page': 'navbar.index',
    services: 'navbar.services',
    masters: 'navbar.masters',
    reserve: 'navbar.reserve',
    'contacts page': 'navbar.contacts',
    my_account: 'navbar.my_account',
    'log in': 'navbar.enter',
    'log out': 'navbar.exit',
    'my page': 'navbar.my_account',
    # toolbar
    'profile title': 'account.title',
    'messages': 'account.my_messages',
    'settings': 'account.settings',
    # toolbar (admin)
    'admin my planed visits': 'account.admin_navbar.my_planed_visits',
    'admin all planed visits': 'account.admin_navbar.all_visits',
    'admin all customers': 'account.admin_navbar.customers',
    'admin all employees': 'account.admin_navbar.employees',
    'admin all statistic': 'account.admin_navbar.statistic',
    'admin all finances': 'account.admin_navbar.finances',
    # toolbar (employee)
    'employee work schedule': 'account.employee_navbar.work_schedule',
    'employee planed visits': 'account.employee_navbar.my_planed_visits',
    'employee my calendar': 'account.employee_navbar.my_calendar',
    'employee statistic': 'account.employee_navbar.statistic',
    # toolbar (visitor)
    'visitor book visit': 'account.customer_navbar.book_visit',
    'visitor all visits': 'account.customer_navbar.all_visits',
    'visitor left feedback': 'account.customer_navbar.left_feedback',
    # customers
    'customers page title': 'customers.title',
    'back button': 'basic.back',
    'search customers': 'customers.search',
    'search button': 'customers.search_submit',
    'download XLS': 'customers.export',
    'name': 'customers.table.name',
    'phone': 'customers.table.phone',
    'email': 'customers.table.email',
    'last visit': 'customers.table.last_visit',
    'never been customers button': 'customers.filter_buttons.have_not_visited',
    'last visit later then month customers button': 'customers.filter_buttons.long_time_ago',
    'skip filters button': 'customers.filter_buttons.skip_filters',
    'can not visit customers': 'pundit.customers_policy.customers?'
  }.stringify_keys
  text = I18n.t(hash_of_i18n_keys.fetch(key))
  wait ||= Capybara.default_max_wait_time
  if see_or_not == 'should see'
    expect(page).to have_content text, wait: wait.to_i
  else
    expect(page).to_not have_content text, wait: wait.to_i
  end
end

Then(/^I see text: (.+)/) do |text|
  expect(page).to have_text(text)
end

Then('I confirm alert') do
  page.driver.browser.switch_to.alert.accept
end

Then(/^I (should|should not) see pagination$/) do |should_or_not|
  if should_or_not == 'should'
    expect(page).to have_selector('.pagination')
  else
    expect(page).not_to have_selector('.pagination')
  end
end

Then(/^I should see a table with (.*?) objects/) do |count|
  expect(page).to have_css('.table-responsive table tbody tr', count:)
end

Then(/^I should receive a file with the name "(.*?)"/) do |filename|
  download_path = Rails.root.join('tmp', 'downloads', filename)
  wait_time = 1
  max_attempts = 3
  attempts = 0
  found = false
  until found || attempts >= max_attempts
    sleep wait_time
    found = File.exist?(download_path)
    attempts += 1
  end
end
