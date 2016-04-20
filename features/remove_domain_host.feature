Feature: Remove Domain Host

  Background:
    Given I am authenticated as partner

  Scenario: Remove domain host
    When  I try to remove a domain host from a domain
    Then  domain must no longer have domain host
