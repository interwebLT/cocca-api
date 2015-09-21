Feature: Register Domain

  Scenario: Register new domain
    When  I register a domain that is still available
    Then  domain must be registered

  Scenario Outline: Register domain with invalid parameters
    When  I register a domain with <invalid parameter>
    Then  error must be validation failed

    Examples: Missing required fields
      | invalid parameter     |
      | no domain name        |
      | no period             |
      | no registrant handle  |
      | no authcode           |

    Examples: Invalid data
      | invalid parameter               |
      | existing domain name            |
      | period more than 10 years       |
      | non-existing registrant handle  |
