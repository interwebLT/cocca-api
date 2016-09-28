DROP TRIGGER tr_registry_sync_master_insert ON audit.master;

CREATE OR REPLACE FUNCTION fn_registry_sync_master_insert() RETURNS TRIGGER
AS
$BODY$
DECLARE
-- nothing to declare
BEGIN
PERFORM
DBLINK_EXEC('dbname=cocca user=coccauser password=coccauser','INSERT INTO registry_sync_masters(audit_transaction, audit_user, audit_login, audit_time, audit_ip, queued, acknowledged) VALUES('||new.audit_transaction||' , ' ||
CASE WHEN new.audit_user IS NULL THEN 'NULL' ELSE '''' || new.audit_user || '''' END ||
', ''' || new.audit_login||''', '''||new.audit_time||''', '''||new.audit_ip||''', false, false)');
RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_registry_sync_master_insert
AFTER INSERT ON audit.master
FOR EACH ROW EXECUTE PROCEDURE fn_registry_sync_master_insert();