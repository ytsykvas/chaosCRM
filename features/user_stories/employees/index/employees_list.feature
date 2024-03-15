Feature: Admin user can visit emloyees list page

  Scenario: Admin can visit employees page and see his employees
    Given We have 10 employees
    When We register admin user
    And I visit employees page
    Then I should see the text: employees list title
    And I should see the text: back button
    And I should see the text: skip filters button
    And I should see full names of all employees
    And I should not see pagination

  Scenario: Admin can visit employees page and see pagination
    Given We have 12 employees
    When We register admin user
    And I visit employees page
    Then I should see the text: employees list title
    And I should see pagination

  Scenario: Employee can not see this page
    When We register employee user
    And I visit employees page
    Then I should see the text: can not visit employees

  Scenario: Visitor can not see this page
    When We register visitor user
    And I visit employees page
    Then I should see the text: can not visit employees
