DROP TRIGGER tr_registry_sync_domain_host_insert ON audit.domain_host;

CREATE OR REPLACE FUNCTION fn_registry_sync_domain_host_insert() RETURNS TRIGGER
AS
$BODY$
DECLARE
-- nothing to declare
BEGIN
PERFORM
public.DBLINK_EXEC('dbname=cocca user=coccauser password=coccauser', 'INSERT INTO public.registry_sync_domain_hosts(audit_transaction, audit_operation, domain_name, host_name, ' ||
CASE WHEN new.sort_order IS NULL THEN '' ELSE 'sort_order, ' END ||
' queued, acknowledged) VALUES(' || new.audit_transaction || ' , ''' || new.audit_operation || ''', ''' || new.domain_name || ''', ''' || new.host_name || ''' ' ||
CASE WHEN new.sort_order IS NULL THEN '' ELSE ',' || new.sort_order END ||
', false, false)');
RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_registry_sync_domain_host_insert
AFTER INSERT ON audit.domain_host
FOR EACH ROW EXECUTE PROCEDURE fn_registry_sync_domain_host_insert();