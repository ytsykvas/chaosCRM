Feature: User can update visitor information

  Scenario: Admin can update visitor information
    Given We have 1 customers
    And We register admin user
    When I visit first customer page
    And I see first customer
    And I should see the text: edit customer
    And I click on the edit user button
    Then I should see the text: edit customer title
    And I should see the text: first name label
    And I should see the text: second name label
    And I should see the text: phone label
    And I should see the text: email field label
    And I should see the text: user type label
    And I fill "Yurii" in the first name field
    And I fill "Tsykvas" in the last name field
    And I fill "0934303352" in the phone number field
    And I fill "tsykvas@gmail.com" in the email field
    And I click submit
    And I should see the text: successfull user update

   Scenario: Admin can not update visitor information with invalid params
    Given We have 1 customers
    And We register admin user
    When I visit first customer page
    And I see first customer
    And I should see the text: edit customer
    And I click on the edit user button
    Then I should see the text: edit customer title
    And I should see the text: first name label
    And I should see the text: second name label
    And I should see the text: phone label
    And I should see the text: email field label
    And I should see the text: user type label
    And I fill "%|\" in the email field
    And I click submit
    And I should not see the text: successfull user update
    And I should see the text: error while updating user

  Scenario: Employee can not update visitor information
    Given We have 1 customers
    And We register employee user
    When I visit first customer page
    And I see first customer
    And I should not see the text: edit customer
