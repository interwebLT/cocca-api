Feature: Save transaction ids 
  Scenario: Register new domain
    When  I register a domain that is still available
    Then  transaction ID must be saved
