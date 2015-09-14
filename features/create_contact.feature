Feature: Create Contact

  Scenario: Create contact with required fields only
    When  I create a new contact with required fields only
    Then  contact must be created

  Scenario: Create contact with complete fields
    When  I create a new contact with complete fields provided
    Then  complete contact must be created

  Scenario Outline: Missing required fields
    When  I create a new contact with missing <field>
    Then  error must be validation failed

    Examples:
      | field         |
      | handle        |
      | name          |
      | street        |
      | city          |
      | country_code  |
      | voice         |
      | email         |
      | authcode      |

  Scenario: Handle already exists
    When  I create a new contact with an existing handle
    Then  error must be validation failed
