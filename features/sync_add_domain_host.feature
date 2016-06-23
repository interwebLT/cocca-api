Feature: Sync Add Domain Host

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync add domain host
    Given I added a domain host entry to an existing domain
    When  latest changes are synced
    Then  add domain host must be synced
