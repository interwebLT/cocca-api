Feature: Renew Domain

  @wip
  Scenario: Renew domain
    When  I renew a domain that exists
    Then  domain must be registered

  @wip
  Scenario: Renew domain that is still available
    When  I renew a domain that is still available
    Then  error must be validation failed

  @wip
  Scenario Outline: Renew domain with invalid parameters
    When  I renew a domain with <invalid parameter>
    Then  error must be validation failed

    Examples: Missing required fields
      | invalid parameter |
      | no domain name    |
      | no period         |

    Examples: Invalid data
      | invalid parameter         |
      | period more than 10 years |
