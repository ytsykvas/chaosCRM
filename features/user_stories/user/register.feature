Feature: User should be able create a new account

  Scenario: User can register new account with mail and password
    When We register a visitor
    And I should not see the text: sign up title
    And I should see the text: success registration alert
