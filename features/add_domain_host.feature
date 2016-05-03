Feature: Add Domain Host

  Background:
    Given I am authenticated as partner

  Scenario: Add domain host
    When  I try to add a domain host to a domain
    Then  domain must now have domain host

  Scenario: Add domain host failed
    When  I try to add a domain host to a domain and fails
    Then  error must be validation failed

  Scenario Outline: Invalid parameters
    When  I try to add a domain host with <invalid parameter>
    Then  error must be validation failed

    Examples:
      | invalid parameter |
      | no domain         |
      | no name           |
