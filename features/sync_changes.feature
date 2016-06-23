Feature: Sync Changes

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync error
    Given I registered a domain
    When  syncing of latest changes results in an error
    Then  I must be informed of the error

  Scenario: Sync domains renewed
    Given I renewed a domain
    When  latest changes are synced
    Then  domain must now be renewed

  Scenario: Sync domains renewed with period in months
    Given I renewed a domain with period in months
    When  latest changes are synced
    Then  domain must now be renewed

  Scenario: Sync domain transfers
    Given I transferred a domain into my partner account
    When  latest changes are synced
    Then  domain must now be under my partner

  Scenario: Sync deleted domains
    Given I deleted an existing domain
    When  latest changes are synced
    Then  domain must now be deleted
