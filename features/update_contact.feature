Feature: Update Contact
  @wip
  Scenario: Successfully update a contact
    When  I update a contact
    Then  contact must be updated

  @wip
  Scenario Outline: Bad request
    When  I update a contact <invalid update>
    Then  error must be <error>

    Examples:
      | invalid update                | error       |
      | that does not exist           | not found   |
      | with a new handle             | bad request |
      | to another partner            | bad request |
      | that I do not own             | not found   |
      | with an existing handle       | bad request |

