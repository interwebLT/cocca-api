DROP VIEW IF EXISTS audit_domain_event;
DROP TABLE IF EXISTS audit_domain_event;

CREATE VIEW audit_domain_event AS
SELECT
  id,
  audit_transaction,
  audit_operation,
  domain_roid,
  domain_name,
  client_clid,
  event,
  term_length,
  term_units,
  expiry_date,
  ledger_id,
  login_username
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    id,
    audit_transaction,
    audit_operation,
    domain_roid,
    domain_name,
    client_clid,
    event,
    term_length,
    term_units,
    expiry_date,
    ledger_id,
    login_username
  FROM audit.domain_event
') cocca (
  id                BIGINT,
  audit_transaction BIGINT,
  audit_operation   VARCHAR(1),
  domain_roid       VARCHAR(89),
  domain_name       VARCHAR(255),
  client_clid       VARCHAR(16),
  event             VARCHAR(20),
  term_length       INTEGER,
  term_units        VARCHAR(20),
  expiry_date       TIMESTAMP,
  ledger_id         BIGINT,
  login_username    VARCHAR(16)
);