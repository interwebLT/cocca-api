Feature: View Host Info

  Background:
    Given I am authenticated as partner

  Scenario: View host info
    When  I try to view the info of an existing host
    Then  I must see the info of the host

  Scenario: Host does not exist
    When  I try to view the info of a host that does not exist
    Then  I must be notified that host does not exist
