DROP VIEW IF EXISTS audit_host_address;
DROP TABLE IF EXISTS audit_host_address;

CREATE VIEW audit_host_address AS
SELECT
  audit_transaction,
  audit_operation,
  host_name,
  ip,
  address
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    audit_transaction,
    audit_operation,
    host_name,
    ip,
    address
  FROM audit.host_address
') cocca (
  audit_transaction BIGINT,
  audit_operation   VARCHAR(1),
  host_name         VARCHAR(255),
  ip                VARCHAR(2),
  address           VARCHAR(255)
);