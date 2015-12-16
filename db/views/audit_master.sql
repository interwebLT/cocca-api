DROP VIEW IF EXISTS audit_master;
DROP TABLE IF EXISTS audit_master;

CREATE VIEW audit_master AS
SELECT
  audit_transaction,
  audit_user,
  audit_login,
  audit_time,
  audit_ip
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    audit_transaction,
    audit_user,
    audit_login,
    audit_time,
    audit_ip
  FROM audit.master
  WHERE audit_time > (current_timestamp - interval ''1'' day)
') cocca (
  audit_transaction BIGINT,
  audit_user        VARCHAR(16),
  audit_login       VARCHAR(16),
  audit_time        TIMESTAMP,
  audit_ip          VARCHAR(255)
);