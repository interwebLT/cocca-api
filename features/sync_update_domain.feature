Feature: Sync Changes

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync update domain
    Given I updated an existing domain
    When  latest changes are synced
    Then  update domain must be synced

  Scenario: Sync update domain contact
    Given I updated a contact of an existing domain
    When  latest changes are synced
    Then  update domain contact must be synced
