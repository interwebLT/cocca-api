DROP VIEW IF EXISTS audit_ledger;
DROP TABLE IF EXISTS audit_ledger;

CREATE VIEW audit_ledger AS
SELECT
  id,
  audit_transaction,
  audit_operation,
  client_roid,
  description,
  currency,
  total,
  created,
  balance,
  tld,
  trans_type,
  domain_name
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    l.id,
    l.audit_transaction,
    l.audit_operation,
    c.clid AS client_roid,
    l.description,
    l.currency,
    l.total,
    l.created,
    l.balance,
    l.tld,
    l.trans_type,
    l.domain_name
  FROM audit.ledger l, client c
  WHERE created > (current_timestamp - interval ''1'' day)
  AND l.client_roid = c.roid
') cocca (
  id                BIGINT,
  audit_transaction BIGINT,
  audit_operation   VARCHAR(1),
  client_roid       VARCHAR(89),
  description       TEXT,
  currency          VARCHAR(3),
  total             NUMERIC,
  created           TIMESTAMP,
  balance           NUMERIC,
  tld               VARCHAR(64),
  trans_type        VARCHAR(64),
  domain_name       VARCHAR(128)
);