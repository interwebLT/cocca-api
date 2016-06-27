Feature: Create Host

  Background:
    Given I am authenticated as partner

  Scenario: Sucessfully create host entry
    When  I create a host entry
    Then  host entry must be created

  Scenario Outline: Invalid parameters
    When  I create a host entry with <invalid parameter>
    Then  error must be validation failed

    Examples:
      | invalid parameter     | field   | code            |
      | no host name          | name    | missing         |
      | blank host name       | name    | invalid         |
      | existing host name    | name    | already_exists  |
