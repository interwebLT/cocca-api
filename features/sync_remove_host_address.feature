Feature: Sync Remove Host Address

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync remove host address
    Given I removed a host address from an existing host
    When  latest changes are synced
    Then  remove host address must be synced
