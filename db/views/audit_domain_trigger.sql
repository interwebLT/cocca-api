DROP TRIGGER tr_registry_sync_domain_insert ON audit.domain;

CREATE OR REPLACE FUNCTION fn_registry_sync_domain_insert() RETURNS TRIGGER
AS
$BODY$
DECLARE
-- nothing to declare
BEGIN
PERFORM
DBLINK_EXEC('dbname=cocca user=coccauser password=coccauser','INSERT INTO registry_sync_domains(audit_transaction, audit_operation, roid, name, exdate, st_cl_deleteprohibited, st_cl_hold, st_cl_renewprohibited, st_cl_transferprohibited, st_cl_updateprohibited, st_inactive, st_ok, st_pendingcreate, st_pendingdelete, st_pendingrenew, st_pendingtransfer, st_pendingupdate, st_sv_deleteprohibited, st_sv_hold, st_sv_renewprohibited, st_sv_transferprohibited, st_sv_updateprohibited, registrant, authinfopw, clid, crid, createdate, upid, updatedate, transferdate, zone, deletedate, queued, acknowledged) VALUES('||new.audit_transaction||' , '''||new.audit_operation||''', '''||new.roid||''', '''||new.name||''', '''||new.exdate||''', '||
CASE WHEN new.st_cl_deleteprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_cl_deleteprohibited || '''' END || ', ' ||
CASE WHEN new.st_cl_hold IS NULL THEN 'NULL' ELSE '''' || new.st_cl_hold || '''' END || ', ' ||
CASE WHEN new.st_cl_renewprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_cl_renewprohibited || '''' END || ', ' ||
CASE WHEN new.st_cl_transferprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_cl_transferprohibited || '''' END || ', ' ||
CASE WHEN new.st_cl_updateprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_cl_updateprohibited || '''' END || ', ' ||
CASE WHEN new.st_inactive IS NULL THEN 'NULL' ELSE '''' || new.st_inactive || '''' END || ', ' ||
CASE WHEN new.st_ok IS NULL THEN 'NULL' ELSE '''' || new.st_ok || '''' END || ', ' ||
CASE WHEN new.st_pendingcreate IS NULL THEN 'NULL' ELSE '''' || new.st_pendingcreate || '''' END || ', ' ||
CASE WHEN new.st_pendingdelete IS NULL THEN 'NULL' ELSE '''' || new.st_pendingdelete || '''' END || ', ' ||
CASE WHEN new.st_pendingrenew IS NULL THEN 'NULL' ELSE '''' || new.st_pendingrenew || '''' END || ', ' ||
CASE WHEN new.st_pendingtransfer IS NULL THEN 'NULL' ELSE '''' || new.st_pendingtransfer || '''' END || ', ' ||
CASE WHEN new.st_pendingupdate IS NULL THEN 'NULL' ELSE '''' || new.st_pendingupdate || '''' END || ', ' ||
CASE WHEN new.st_sv_deleteprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_sv_deleteprohibited || '''' END || ', ' ||
CASE WHEN new.st_sv_hold IS NULL THEN 'NULL' ELSE '''' || new.st_sv_hold || '''' END || ', ' ||
CASE WHEN new.st_sv_renewprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_sv_renewprohibited || '''' END || ', ' ||
CASE WHEN new.st_sv_transferprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_sv_transferprohibited || '''' END || ', ' ||
CASE WHEN new.st_sv_updateprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_sv_updateprohibited || '''' END || ', ' ||
CASE WHEN new.registrant IS NULL THEN 'NULL' ELSE '''' || new.registrant || '''' END || ', ' ||
CASE WHEN new.authinfopw IS NULL THEN 'NULL' ELSE '''' || new.authinfopw || '''' END || ', ''' ||
new.clid||''', '''||new.crid||''', '''||new.createdate||''', '||
CASE WHEN new.upid IS NULL THEN 'NULL' ELSE '''' || new.upid || '''' END || ', ' ||
CASE WHEN new.updatedate IS NULL THEN 'NULL' ELSE '''' || new.updatedate || '''' END || ', ' ||
CASE WHEN new.transferdate IS NULL THEN 'NULL' ELSE '''' || new.transferdate || '''' END ||
', '''||new.zone||''', '||
CASE WHEN new.deletedate IS NULL THEN 'NULL' ELSE '''' || new.deletedate || '''' END || ', false, false)');
RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_registry_sync_domain_insert
AFTER INSERT ON audit.domain
FOR EACH ROW EXECUTE PROCEDURE fn_registry_sync_domain_insert();