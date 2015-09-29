Feature: Create Host as Administrator
  Scenario: Sucessfully create host entry
    When  I create a host entry
    Then  host entry must be created

  @wip
  Scenario Outline: Invalid parameters
    When  I create a host entry with <invalid parameter>
    Then  error must be validation failed
    And   validation error on <field> must be "<code>"

    Examples:
      | invalid parameter     | field   | code            |
      | no host name          | name    | missing         |
      | blank host name       | name    | invalid         |
      | existing host name    | name    | already_exists  |
