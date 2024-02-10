Feature: User can export customers list

  Scenario: Admin can export customers list
    Given We have 10 customers
    And We register admin user
    When I visit customers page
    And I click on the download XLS button
    Then I should receive a file with the name "AllCustomers.xls"
