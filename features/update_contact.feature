Feature: Update Contact
  Background:
    Given I am authenticated as partner

  Scenario: Successfully update a contact
    When  I update a contact
    Then  contact must be updated on EPP

  Scenario Outline: Bad request
    When  I update a contact <invalid update>
    Then  error must be <error>

    Examples:
      | invalid update                | error       |
      | that does not exist           | not found   |
      | with a new handle             | bad request |
      | that I do not own             | not found   |
      | and change the handle         | bad request |

