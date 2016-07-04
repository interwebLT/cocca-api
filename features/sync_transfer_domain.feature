Feature: Sync Transfer Domain

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync transfer domain
    Given I transferred a domain into my partner account
    When  latest changes are synced
    Then  transfer domain must be synced
