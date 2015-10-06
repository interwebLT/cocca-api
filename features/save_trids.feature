Feature: Save transaction ids 
  Scenario: Register new domain
    When  I register a domain that is still available
    Then  transaction ID must be saved

  Scenario: Renew domain
    When  I renew a domain that exists
    Then  transaction ID must be saved

  Scenario: Sucessfully create host entry
    When  I create a host entry
    Then  transaction ID must be saved
