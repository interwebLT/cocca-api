DROP VIEW IF EXISTS audit_host;
DROP TABLE IF EXISTS audit_host;

CREATE VIEW audit_host AS
SELECT
  audit_transaction,
  audit_operation,
  roid,
  name,
  clid,
  crid,
  createdate
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    audit_transaction,
    audit_operation,
    roid,
    name,
    clid,
    crid,
    createdate
  FROM audit.host
') cocca (
  audit_transaction BIGINT,
  audit_operation   VARCHAR(1),
  roid              VARCHAR(89),
  name              VARCHAR(255),
  clid              VARCHAR(16),
  crid              VARCHAR(16),
  createdate        TIMESTAMP
);
