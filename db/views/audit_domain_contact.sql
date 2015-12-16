DROP VIEW IF EXISTS audit_domain_contact;
DROP TABLE IF EXISTS audit_domain_contact;

CREATE VIEW audit_domain_contact AS
SELECT
  audit_transaction,
  audit_operation,
  domain_name,
  contact_id,
  type
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    audit_transaction,
    audit_operation,
    domain_name,
    contact_id,
    type
  FROM audit.domain_contact
') cocca (
  audit_transaction BIGINT,
  audit_operation   VARCHAR(1),
  domain_name       VARCHAR(255),
  contact_id        VARCHAR(255),
  type              VARCHAR(16)
);