Feature: Sync Changes

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync remove domain host
    Given I removed a domain host entry from an existing domain
    When  latest changes are synced
    Then  remove domain host must be synced
