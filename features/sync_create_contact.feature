Feature: Sync Create Contact

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync create contact
    Given I created a contact
    When  latest changes are synced
    Then  create contact must be synced
