DROP VIEW IF EXISTS audit_domain_host;
DROP TABLE IF EXISTS audit_domain_host;

CREATE VIEW audit_domain_host AS
SELECT
  audit_transaction,
  audit_operation,
  domain_name,
  host_name
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    audit_transaction,
    audit_operation,
    domain_name,
    host_name
  FROM audit.domain_host
') cocca (
  audit_transaction BIGINT,
  audit_operation   VARCHAR(1),
  domain_name       VARCHAR(255),
  host_name         VARCHAR(255)
);