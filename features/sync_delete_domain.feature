Feature: Sync Delete Domain

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync delete domain
    Given I deleted an existing domain
    When  latest changes are synced
    Then  delete domain must be synced
