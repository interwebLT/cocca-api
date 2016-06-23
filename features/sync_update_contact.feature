Feature: Sync Update Contact

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync update contact
    Given I updated an existing contact
    When  latest changes are synced
    Then  update contact must be synced
