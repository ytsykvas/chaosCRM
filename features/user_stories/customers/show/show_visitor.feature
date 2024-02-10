Feature: User can visit customer info page

  Scenario: Admin can visit and see customer information
    Given We have 2 customers
    And We register admin user
    Then I visit first customer page
    And I see first customer
    And I should see the text: back
    And I should see the text: name
    And I should see the text: phone
    And I should see the text: email
    And I should see the text: last visit
    And I should see the text: book visit for customer
    And I should see the text: customer bonuses
    And I should see the text: edit customer
    And I should see the text: block customer

  Scenario: Employee can visit and see customer information
    Given We have 2 customers
    And We register employee user
    Then I visit first customer page
    And I see first customer
    And I should see the text: back
    And I should see the text: name
    And I should see the text: phone
    And I should see the text: email
    And I should see the text: last visit
    And I should see the text: book visit for customer
    And I should see the text: customer bonuses
    And I should see the text: edit customer
    And I should see the text: block customer


  Scenario: Visitor can not visit and see customer information
    Given We have 2 customers
    And We register visitor user
    Then I visit first customer page
    And I should see the text: visitor can not visit customer page
    And I should not see the text: name
    And I should not see the text: phone
    And I should not see the text: book visit for customer
    And I should not see the text: customer bonuses
    And I should not see the text: edit customer
    And I should not see the text: block customer
