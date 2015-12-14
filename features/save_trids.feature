Feature: Save transaction ids
  Background:
    Given I am authenticated as partner

  Scenario: Register new domain
    When  I register a domain that is still available
    Then  transaction ID must be saved

  Scenario: Renew domain
    When  I renew a domain that exists
    Then  transaction ID must be saved

  Scenario: Saves id even if register domain fails
    When  I register a domain with existing domain name
    Then  transaction ID must be saved

  Scenario: Saves id even if renew domain fails
    When  I renew a domain that is still available
    Then  transaction ID must be saved

  Scenario: Sucessfully create host entry
    When  I create a host entry
    Then  transaction ID must be saved

  Scenario: Invalid host parameters
    When  I create a host entry with existing host name
    Then  transaction ID must be saved

  Scenario: Create contact with complete fields
    When  I create a new contact with complete fields provided
    Then  transaction ID must be saved

  Scenario: Handle already exists
    When  I create a new contact with an existing handle
    Then  transaction ID must be saved

  Scenario: Successfully update a contact
    When  I update a contact
    Then  transaction ID must be saved

  Scenario: Successfully add ipv4 host address entry
    When  I add an ipv4 host address entry to an existing host
    Then  transaction ID must be saved

  Scenario: Successfully add ipv6 host address entry
    When  I add an ipv6 host address entry to an existing host
    Then  transaction ID must be saved
