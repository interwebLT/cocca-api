Feature: Sync Create Host

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync create host
    Given I created a host entry
    When  latest changes are synced
    Then  create host must be synced
