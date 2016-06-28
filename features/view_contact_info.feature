Feature: View Contact Info

  Background:
    Given I am authenticated as partner

  Scenario: View contact
    When  I try to view the info of an existing contact
    Then  I must see the info of the contact

  Scenario: Contact does not exist
    When  I try to view the info of contact that does not exist
    Then  I must be notified that contact does not exist
