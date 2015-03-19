CREATE OR REPLACE VIEW audit_contact        AS SELECT * FROM audit.contact;
CREATE OR REPLACE VIEW audit_domain         AS SELECT * FROM audit.domain;
CREATE OR REPLACE VIEW audit_domain_contact AS SELECT * FROM audit.domain_contact;
CREATE OR REPLACE VIEW audit_domain_event   AS SELECT * FROM audit.domain_event;
CREATE OR REPLACE VIEW audit_domain_host    AS SELECT * FROM audit.domain_host;
CREATE OR REPLACE VIEW audit_host           AS SELECT * FROM audit.host;
CREATE OR REPLACE VIEW audit_host_address   AS SELECT * FROM audit.host_address;
CREATE OR REPLACE VIEW audit_ledger         AS SELECT * FROM audit.ledger;
CREATE OR REPLACE VIEW audit_master         AS SELECT * FROM audit.master;

