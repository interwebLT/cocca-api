Feature: Sync Changes

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync error
    Given I registered a domain
    When  syncing of latest changes results in an error
    Then  I must be informed of the error
