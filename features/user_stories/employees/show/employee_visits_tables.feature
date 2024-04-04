Feature: User can visit and see employee`s visit table

  Background:
    Given We have 1 customers
    And We have 1 employees
    And First customer have 15 orders to first employee for today

  Scenario: Admin can visit and see table
    Given We register admin user
    And I visit employees page
    When I click on the employee name link
    Then I see first customer
    And I should see pagination
    And I should see the text: opened visits title
    And I should see the text: without conclusion title

  Scenario: Employee can not see this page
    Given We register employee user
    When I visit employees page
    Then I should see the text: can not visit employees
    And I should not see the text: opened visits title
    And I should not see the text: without conclusion title

  Scenario: Visitor can not see this page
    Given We register visitor user
    When I visit employees page
    Then I should see the text: can not visit employees
    And I should not see the text: opened visits title
    And I should not see the text: without conclusion title
