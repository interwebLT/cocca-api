DROP VIEW IF EXISTS audit_contact;
DROP TABLE IF EXISTS audit_contact;

CREATE VIEW audit_contact AS
SELECT
  audit_transaction,
  audit_operation,
  roid,
  id,
  clid,
  crid,
  createdate,
  intpostalname,
  intpostalorg,
  intpostalstreet1,
  intpostalcity,
  intpostalsp,
  intpostalpc,
  intpostalcc,
  locpostalname,
  locpostalorg,
  locpostalstreet1,
  locpostalcity,
  locpostalsp,
  locpostalpc,
  locpostalcc,
  voice,
  fax,
  email,
  intpostalstreet2,
  intpostalstreet3,
  locpostalstreet2,
  locpostalstreet3,
  voicex,
  faxx
FROM dblink('dbname=registry user=coccauser password=coccauser', '
  SELECT
    audit_transaction,
    audit_operation,
    roid,
    id,
    clid,
    crid,
    createdate,
    intpostalname,
    intpostalorg,
    intpostalstreet1,
    intpostalcity,
    intpostalsp,
    intpostalpc,
    intpostalcc,
    locpostalname,
    locpostalorg,
    locpostalstreet1,
    locpostalcity,
    locpostalsp,
    locpostalpc,
    locpostalcc,
    voice,
    fax,
    email,
    intpostalstreet2,
    intpostalstreet3,
    locpostalstreet2,
    locpostalstreet3,
    voicex,
    faxx
  FROM audit.contact
  WHERE createdate > (current_timestamp - interval ''1'' day)
') cocca (
  audit_transaction BIGINT,
  audit_operation   VARCHAR(1),
  roid              VARCHAR(89),
  id                VARCHAR(16),
  clid              VARCHAR(16),
  crid              VARCHAR(16),
  createdate        TIMESTAMP,
  intpostalname     VARCHAR(255),
  intpostalorg      VARCHAR(255),
  intpostalstreet1  VARCHAR(255),
  intpostalcity     VARCHAR(255),
  intpostalsp       VARCHAR(255),
  intpostalpc       VARCHAR(255),
  intpostalcc       VARCHAR(255),
  locpostalname     VARCHAR(255),
  locpostalorg      VARCHAR(255),
  locpostalstreet1  VARCHAR(255),
  locpostalcity     VARCHAR(255),
  locpostalsp       VARCHAR(255),
  locpostalpc       VARCHAR(255),
  locpostalcc       VARCHAR(255),
  voice             VARCHAR(64),
  fax               VARCHAR(64),
  email             VARCHAR(2048),
  intpostalstreet2  VARCHAR(255),
  intpostalstreet3  VARCHAR(255),
  locpostalstreet2  VARCHAR(255),
  locpostalstreet3  VARCHAR(255),
  voicex            VARCHAR(64),
  faxx              VARCHAR(64)
);

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
  authinfopw,
  st_pendingtransfer
FROM dblink('dbname=registry user=coccauser password=coccauser', '
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
    authinfopw,
    st_pendingtransfer
  FROM audit.domain
  WHERE createdate > (current_timestamp - interval ''1'' day)
') cocca (
  audit_transaction         INTEGER,
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
  authinfopw                VARCHAR(64),
  st_pendingtransfer        VARCHAR(1024)
);

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
  id                INTEGER,
  audit_transaction BIGINT,
  audit_operation   VARCHAR(1),
  domain_roid       VARCHAR(89),
  domain_name       VARCHAR(255),
  client_clid       VARCHAR(16),
  event             VARCHAR(20),
  term_length       INTEGER,
  term_units        VARCHAR(20),
  expiry_date       TIMESTAMP,
  ledger_id         INTEGER,
  login_username    VARCHAR(16)
);

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
  tld
FROM dblink('dbname=registry user=coccauser password=coccauser', '
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
    tld
  FROM audit.ledger
  WHERE created > (current_timestamp - interval ''1'' day)
') cocca (
  id                INTEGER,
  audit_transaction BIGINT,
  audit_operation   VARCHAR(1),
  client_roid       VARCHAR(89),
  description       TEXT,
  currency          VARCHAR(3),
  total             NUMERIC,
  created           TIMESTAMP,
  balance           NUMERIC,
  tld               VARCHAR(64)
);

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
