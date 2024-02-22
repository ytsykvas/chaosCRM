Feature: User can block and unblock a visitor

  Background:
    Given We have 1 customers
    And We register admin user
    And I visit first customer page

  Scenario: Admin can ban a visitor
    When I see first customer
    And I should see the text: block customer
    And I click on the ban user button
    And I should see the text: block customer title
    And I see first customer
    And I should see the text: ban user hint
    And I should see the text: unban user hint
    And I fill "antivax" in the ban reason field
    And I click submit
    Then I see first customer
    And I should see the text: success block notice
    And And I should see the text: blocked user alert title

  Scenario: User will get an error when he leave blank field with e block reason
    When I see first customer
    And I click on the ban user button
    And I click submit
    Then I see first customer
    And And I should not see the text: success block notice
    And And I should see the text: block error alert

  Scenario: User can block and unblock visitor
    When I click on the ban user button
    And I fill "antivax" in the ban reason field
    And I click submit
    And I should see the text: unblock button
    And I click on the unban user button
    Then I should see the text: success unblock notice
