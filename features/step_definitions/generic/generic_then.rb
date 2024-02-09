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
    'visitor left feedback': 'account.customer_navbar.left_feedback'
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
