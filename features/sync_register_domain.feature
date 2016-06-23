Feature: Sync Register Domain

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync register domain
    Given I registered a domain
    When  latest changes are synced
    Then  register domain must be synced

  Scenario: Excluded IP
    Given I registered a domain from an excluded IP
    When  latest changes are synced
    Then  no changes must be synced

  Scenario: Sync register domain with period in months
    Given I registered a domain with period in months
    When  latest changes are synced
    Then  register domain must be synced
