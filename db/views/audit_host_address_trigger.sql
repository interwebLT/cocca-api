DROP TRIGGER tr_registry_sync_host_address_insert ON audit.host_address;

CREATE OR REPLACE FUNCTION fn_registry_sync_host_address_insert() RETURNS TRIGGER
AS
$BODY$
DECLARE
-- nothing to declare
BEGIN
PERFORM
public.DBLINK_EXEC('dbname=cocca user=coccauser password=coccauser','INSERT INTO public.registry_sync_host_addresses(audit_transaction, audit_operation, host_name, ip, address, queued, acknowledged) VALUES('||new.audit_transaction||' , '''||new.audit_operation||''', '''||new.host_name||''', '''||new.ip||''', '''||new.address||''', false, false)');
RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_registry_sync_host_address_insert
AFTER INSERT ON audit.host_address
FOR EACH ROW EXECUTE PROCEDURE fn_registry_sync_host_address_insert();