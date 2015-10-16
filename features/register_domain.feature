Feature: Register Domain

  Scenario: Register new domain
    When  I register a domain that is still available
    Then  domain must be registered

  Scenario: Register multiple domains, all of which are available
    When I register multiple domains that are still available
    Then  domains must be registered

  Scenario: Register multiple domains, one of which has a validation error
    When I register multiple domains with one validation error
    Then  error must be validation failed

  Scenario: Register multiple domains, one of which fails for an unknown reason
    When I place an order that fails at an external step
    Then  error must be validation failed

  Scenario Outline: Register domain with invalid parameters
    When  I register a domain using <invalid parameter>
    Then  error must be validation failed

    Examples: Validation errors
      | invalid parameter     |
      | missing order details |
      | no domain name        |
      | no period             |
      | no registrant handle  |
      # | no authcode           |
      | period more than 10 years       |

  Scenario Outline: Register domain with invalid data
    When  I register a domain with <invalid parameter>
    Then  error must be validation failed

    Examples: External errors
      | invalid parameter               |
      | existing domain name            |
      | non-existing registrant handle  |
