Feature: Sync Add Host Address

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync add host address
    Given I added a host address to an existing host
    When  latest changes are synced
    Then  add host address must be synced
