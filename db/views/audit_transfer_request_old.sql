DROP VIEW IF EXISTS audit_transfer_request;
DROP TABLE IF EXISTS audit_transfer_request;

CREATE VIEW audit_transfer_request AS
SELECT
  id,
  audit_transaction,
  audit_operation,
  requestdate AS "request_date",
  domainname AS "domain_name",
  transfer_to_clid,
  owner_clid,
  response,
  extension_unit,
  extension_num_units,
  transferred_by_clid,
  transferred_by_username
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    id,
    audit_transaction,
    audit_operation,
    requestdate,
    domainname,
    transfer_to_clid,
    owner_clid,
    response,
    extension_unit,
    extension_num_units,
    transferred_by_clid,
    transferred_by_username
  FROM audit.transfer_request
') cocca (
  id                      BIGINT,
  audit_transaction       BIGINT,
  audit_operation         VARCHAR(1),
  requestdate             TIMESTAMP,
  domainname              VARCHAR(255),
  transfer_to_clid        VARCHAR(16),
  owner_clid              VARCHAR(16),
  response                VARCHAR(25),
  extension_unit          VARCHAR(1),
  extension_num_units     INTEGER,
  transferred_by_clid     VARCHAR(16),
  transferred_by_username VARCHAR(16)
);