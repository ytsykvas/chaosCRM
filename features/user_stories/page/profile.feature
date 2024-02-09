Feature: User can visit his profile page

  Scenario: Signed visitor user can visit profile and see toolbar
    When We register visitor user
    And I visit profile page
    Then I should see the text: profile title
    And I should see the text: visitor book visit
    And I should see the text: visitor all visits
    And I should see the text: visitor left feedback
    And I should see the text: messages
    And I should see the text: settings
    And I should not see the text: admin all customers
    And I should not see the text: employee statistic

  Scenario: Signed admin user can visit profile and see toolbar
    When We register admin user
    And I visit profile page
    Then I should see the text: profile title
    And I should see the text: admin my planed visits
    And I should see the text: admin all planed visits
    And I should see the text: admin all customers
    And I should see the text: admin all employees
    And I should see the text: admin all statistic
    And I should see the text: admin all finances
    And I should see the text: messages
    And I should see the text: settings
    And I should not see the text: employee work schedule
    And I should not see the text: visitor left feedback

  Scenario: Signed employee user can visit profile and see toolbar
    When We register employee user
    And I visit profile page
    Then I should see the text: profile title
    And I should see the text: employee work schedule
    And I should see the text: employee planed visits
    And I should see the text: employee my calendar
    And I should see the text: employee statistic
    And I should see the text: messages
    And I should see the text: settings
    And I should not see the text: admin all customers
    And I should not see the text: visitor left feedback
