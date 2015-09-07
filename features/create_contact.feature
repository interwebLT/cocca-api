Feature: Create Contact

  Scenario: Create contact with required fields only
    When  I create a new contact with required fields only
    Then  contact must be created

  Scenario: Missing required fields
    When  I create a new contact with missing handle
    Then  error must be validation failed
