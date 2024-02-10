Feature: Admin can filter customers list

  Scenario: Admin filter customers list by a number
    Given We have 10 customers
    And The last customer have this phone number "0934303352"
    When We register admin user
    And I visit customers page
    And I fill "0934303352" in the search field
    And I click on the search button
    Then I should see a table with 1 objects

  Scenario: Admin filter customers list with a letters
    Given We have 10 customers
    And The last customer have this first name "Олександрнатест"
    When We register admin user
    And I visit customers page
    And I fill "Олександрнатест" in the search field
    And I click on the search button
    Then I should see a table with 1 objects

  Scenario: Admin can use button for filtering customers and see customers that did not visited yet and skip this filter
    Given We have 10 customers
    And 6 customers used our service later then 1 month
    And We register admin user
    And I visit customers page
    When I click on the have never been button
    Then I should see a table with 4 objects
    And I click on the search button
    And I should see a table with 10 objects
    And I click on the have never been button
    And I should see a table with 4 objects
    And I click on the skip filters button
    And I should see a table with 10 objects

  Scenario: Admin can use button for filtering customers and see customers that visited later then 1 month ago
    Given We have 10 customers
    And 6 customers used our service later then 1 month
    And We register admin user
    And I visit customers page
    When I click on the long time ago button
    Then I should see a table with 6 objects
    And I click on the search button
    And I should see a table with 10 objects
    And I click on the long time ago button
    And I should see a table with 6 objects
    And I click on the skip filters button
    And I should see a table with 10 objects
