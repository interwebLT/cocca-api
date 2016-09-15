DROP TRIGGER tr_registry_sync_domain_insert ON audit.domain;

CREATE OR REPLACE FUNCTION fn_registry_sync_domain_insert() RETURNS TRIGGER
AS
$BODY$
DECLARE
-- nothing to declare
BEGIN
PERFORM
DBLINK_EXEC('dbname=cocca user=coccauser password=coccauser','INSERT INTO registry_sync_domains(audit_transaction, audit_operation, roid, name, exdate, st_cl_deleteprohibited, st_cl_hold, st_cl_renewprohibited, st_cl_transferprohibited, st_cl_updateprohibited, st_inactive, st_ok, st_pendingcreate, st_pendingdelete, st_pendingrenew, st_pendingtransfer, st_pendingupdate, st_sv_deleteprohibited, st_sv_hold, st_sv_renewprohibited, st_sv_transferprohibited, st_sv_updateprohibited, registrant, authinfopw, clid, crid, createdate, upid, updatedate, zone, deletedate, queued, acknowledged) VALUES('||new.audit_transaction||' , '''||new.audit_operation||''', '''||new.roid||''', '''||new.name||''', '''||new.exdate||''', '''||new.st_cl_deleteprohibited||''', '''||new.st_cl_hold||''', '''||new.st_cl_renewprohibited||''', '''||new.st_cl_transferprohibited||''', '''||new.st_cl_updateprohibited||''', '''||new.st_inactive||''', '''||new.st_ok||''', '''||new.st_pendingcreate||''', '''||new.st_pendingdelete||''', '''||new.st_pendingrenew||''', '''||new.st_pendingtransfer||''', '''||new.st_pendingupdate||''', '''||new.st_sv_deleteprohibited||''', '''||new.st_sv_hold||''', '''||new.st_sv_renewprohibited||''', '''||new.st_sv_transferprohibited||''', '''||new.st_sv_updateprohibited||''', '''||new.registrant||''', '''||new.authinfopw||''', '''||new.clid||''', '''||new.crid||''', '''||new.createdate||''', '''||new.upid||''', '''||new.updatedate||''', '''||new.zone||''', '''||new.deletedate||''', false, false)');
RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_registry_sync_domain_insert
AFTER INSERT ON audit.domain
FOR EACH ROW EXECUTE PROCEDURE fn_registry_sync_domain_insert();