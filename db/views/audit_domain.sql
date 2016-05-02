DROP VIEW IF EXISTS audit_domain;
DROP TABLE IF EXISTS audit_domain;

CREATE VIEW audit_domain AS
SELECT
  audit_transaction,
  audit_operation,
  roid,
  name,
  exdate,
  clid,
  crid,
  createdate,
  zone,
  registrant,
  st_cl_deleteprohibited,
  st_cl_hold,
  st_cl_renewprohibited,
  st_cl_transferprohibited,
  st_cl_updateprohibited,
  st_sv_deleteprohibited,
  st_sv_hold,
  st_sv_renewprohibited,
  st_sv_transferprohibited,
  st_sv_updateprohibited,
  authinfopw,
  st_pendingtransfer
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    d.audit_transaction,
    d.audit_operation,
    d.roid,
    d.name,
    d.exdate,
    d.clid,
    d.crid,
    d.createdate,
    d.zone,
    d.registrant,
    d.st_cl_deleteprohibited,
    d.st_cl_hold,
    d.st_cl_renewprohibited,
    d.st_cl_transferprohibited,
    d.st_cl_updateprohibited,
    d.st_sv_deleteprohibited,
    d.st_sv_hold,
    d.st_sv_renewprohibited,
    d.st_sv_transferprohibited,
    d.st_sv_updateprohibited,
    d.authinfopw,
    d.st_pendingtransfer
  FROM audit.master m, audit.domain d
  WHERE 1=1
  AND d.audit_transaction = m.audit_transaction
  AND m.audit_time > (current_timestamp - interval ''1'' day)
') cocca (
  audit_transaction         BIGINT,
  audit_operation           VARCHAR(1),
  roid                      VARCHAR(89),
  name                      VARCHAR(255),
  exdate                    TIMESTAMP,
  clid                      VARCHAR(16),
  crid                      VARCHAR(16),
  createdate                TIMESTAMP,
  zone                      VARCHAR(64),
  registrant                VARCHAR(16),
  st_cl_deleteprohibited    VARCHAR(1024),
  st_cl_hold                VARCHAR(1024),
  st_cl_renewprohibited     VARCHAR(1024),
  st_cl_transferprohibited  VARCHAR(1024),
  st_cl_updateprohibited    VARCHAR(1024),
  st_sv_deleteprohibited    VARCHAR(1024),
  st_sv_hold                VARCHAR(1024),
  st_sv_renewprohibited     VARCHAR(1024),
  st_sv_transferprohibited  VARCHAR(1024),
  st_sv_updateprohibited    VARCHAR(1024),
  authinfopw                VARCHAR(64),
  st_pendingtransfer        VARCHAR(1024)
);
