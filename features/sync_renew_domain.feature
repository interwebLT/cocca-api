Feature: Sync Renew Domain

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync renew domain
    Given I renewed a domain
    When  latest changes are synced
    Then  renew domain must be synced

  Scenario: Sync renew domain with period in months
    Given I renewed a domain with period in months
    When  latest changes are synced
    Then  renew domain must be synced
