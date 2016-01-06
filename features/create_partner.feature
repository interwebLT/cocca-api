Feature: Create Partner

  Scenario: Sucessfully create new partner
    When  I create a new partner
    Then  partner must be created
    # And   partner must be synced to other systems

  Scenario Outline: Create partner with invalid parameters
    When  I create a new partner with <invalid parameter>
    Then  error must be validation failed

    Examples:
      | invalid parameter |
      | no name           |
      | no password       |
