Feature: Add Host Address 
  Scenario: Successfully add ipv4 host address entry
    When  I add an ipv4 host address entry to an existing host
    Then  ipv4 host address must be created

  Scenario: Successfully add ipv6 host address entry
    When  I add an ipv6 host address entry to an existing host
    Then  ipv6 host address must be created

  Scenario Outline: Invalid parameters
    When  I add a host address entry using <invalid parameter>
    Then  error must be validation failed

    Examples:
      | invalid parameter | 
      | missing address   | 
      | blank address     | 
      | missing type      | 
      | blank type        | 
      | invalid type      | 

  Scenario: Host address already in the host
    When  I add a host address entry which is already present
    Then  error must be validation failed

  Scenario: Host does not exist
    When  I add a host address entry for non-existing host
    Then  error must be validation failed

  # This feature should be implemented on the EPP side; a test here doesn't make
  # sense but I'm leaving the feature description in for the sake of making the 
  # requirement clear.
  @wip 
  Scenario: Same host address used in different hosts
    When  I add a host address entry which is also used by another host
    Then  host address must be created
