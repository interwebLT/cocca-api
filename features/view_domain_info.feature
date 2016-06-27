Feature: View Domain

  Background:
    Given I am authenticated as partner

  Scenario: View domain
    When  I try to view the info of an existing domain
    Then  I must see the info of the domain
