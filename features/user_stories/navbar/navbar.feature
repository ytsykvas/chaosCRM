Feature: User can see navbar

  Scenario: Not logged user can see navbar and log in button
    When I visit main page
    Then I should see the text: main page
    Then I should see the text: services
    Then I should see the text: masters
    Then I should see the text: reserve
    And I should see the text: log in
    And I should not see the text: log out
    And I should not see the text: my page

  Scenario: User is logged in as a supplier
    Given We register visitor user
    Then I should see the text: main page
    Then I should see the text: services
    Then I should see the text: masters
    Then I should see the text: reserve
    And I should not see the text: log in
    And I should see the text: log out
    And I should see the text: my page
