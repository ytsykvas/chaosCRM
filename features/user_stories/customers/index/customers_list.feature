Feature: User can visit customers page

  Scenario: Admin user can visit customers
    Given We have 10 customers
    When We register admin user
    And I visit customers page
    Then I should see the text: customers page title
    And I should see the text: back button
    And I should see the text: download XLS
    And I should see the text: name
    And I should see the text: phone
    And I should see the text: email
    And I should see the text: last visit
    And I should see the text: never been customers button
    And I should see the text: last visit later then month customers button
    And I should see the text: skip filters button

  Scenario: User can see pagination at customers page if we have more then 10 customers
    Given We have 15 customers
    When We register admin user
    And I visit customers page
    Then I should see pagination
    And I should see a table with 10 objects

  Scenario: User can not see pagination at customers page if we have less then 10 customers
    Given We have 8 customers
    When We register admin user
    And I visit customers page
    Then I should not see pagination
    And I should see a table with 8 objects

  Scenario: Employee can't visit customers page
    When We register employee user
    And I visit customers page
    Then I should see the text: can not visit customers

  Scenario: Visitor can`t visit customers page
    When We register visitor user
    And I visit customers page
    Then I should see the text: can not visit customers

  Scenario: Not signed user can`t visit customers page
    And I visit customers page
    Then I should see the text: sign in to continue
