Feature: Sync Changes

  Background:
    Given registry accepts sync requests
    And   some partners are excluded from sync
    And   I am allowed to sync to registry

  Scenario: Sync error
    Given I registered a domain
    When  syncing of latest changes results in an error
    Then  I must be informed of the error

  Scenario: Sync hosts created
    Given I created a host entry
    When  latest changes are synced
    Then  host entry must now exist

  Scenario: Sync host addresses added to an existing host
    Given I added a host address to an existing host
    When  latest changes are synced
    Then  host must now have the host address I associated with it

  Scenario: Sync host addresses removed from an existing host
    Given I removed a host address from an existing host
    When  latest changes are synced
    Then  host must no longer have the host address I removed associated with it

  Scenario: Sync domain host entry added to an existing domain
    Given I added a domain host entry to an existing domain
    When  latest changes are synced
    Then  domain must now have the domain host entry I associated with it

  Scenario: Sync domain host entry added to an existing domain
    Given I removed a domain host entry from an existing domain
    When  latest changes are synced
    Then  domain must no longer have the domain host entry I removed associated with it

  Scenario: Sync contact updates
    Given I updated an existing contact
    When  latest changes are synced
    Then  contact must be updated

  Scenario: Sync domain updates
    Given I updated an existing domain
    When  latest changes are synced
    Then  domain must be updated

  Scenario: Sync domain contact updates
    Given I updated a contact of an existing domain
    When  latest changes are synced
    Then  domain contact must be updated

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
