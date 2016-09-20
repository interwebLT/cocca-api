DROP TRIGGER tr_registry_sync_host_insert ON audit.host;

CREATE OR REPLACE FUNCTION fn_registry_sync_host_insert() RETURNS TRIGGER
AS
$BODY$
DECLARE
-- nothing to declare
BEGIN
PERFORM
DBLINK_EXEC('dbname=cocca user=coccauser password=coccauser','INSERT INTO registry_sync_hosts(audit_transaction, audit_operation, roid, name, st_cl_deleteprohibited, st_cl_updateprohibited, st_linked, st_ok, st_pendingcreate, st_pendingdelete, st_pendingtransfer, st_pendingupdate, st_sv_deleteprohibited, st_sv_updateprohibited, clid, crid, createdate, upid, updatedate, transferdate, queued, acknowledged) VALUES('||new.audit_transaction||' , '''||new.audit_operation||''', '''||new.roid||''', '''||new.name||''', '||
CASE WHEN new.st_cl_deleteprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_cl_deleteprohibited || '''' END || ', ' ||
CASE WHEN new.st_cl_updateprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_cl_updateprohibited || '''' END || ', ' ||
CASE WHEN new.st_linked IS NULL THEN 'NULL' ELSE '''' || new.st_linked || '''' END || ', ' ||
CASE WHEN new.st_ok IS NULL THEN 'NULL' ELSE '''' || new.st_ok || '''' END || ', ' ||
CASE WHEN new.st_pendingcreate IS NULL THEN 'NULL' ELSE '''' || new.st_pendingcreate || '''' END || ', ' ||
CASE WHEN new.st_pendingdelete IS NULL THEN 'NULL' ELSE '''' || new.st_pendingdelete || '''' END || ', ' ||
CASE WHEN new.st_pendingtransfer IS NULL THEN 'NULL' ELSE '''' || new.st_pendingtransfer || '''' END || ', ' ||
CASE WHEN new.st_pendingupdate IS NULL THEN 'NULL' ELSE '''' || new.st_pendingupdate || '''' END || ', ' ||
CASE WHEN new.st_sv_deleteprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_sv_deleteprohibited || '''' END || ', ' ||
CASE WHEN new.st_sv_updateprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_sv_updateprohibited || '''' END || ', ''' ||
new.clid||''', '''||new.crid||''', '''||new.createdate||''', '||
CASE WHEN new.upid IS NULL THEN 'NULL' ELSE '''' || new.upid || '''' END || ', ' ||
CASE WHEN new.updatedate IS NULL THEN 'NULL' ELSE '''' || new.updatedate || '''' END || ', ' ||
CASE WHEN new.transferdate IS NULL THEN 'NULL' ELSE '''' || new.transferdate || '''' END ||
', false, false)');
RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_registry_sync_host_insert
AFTER INSERT ON audit.host
FOR EACH ROW EXECUTE PROCEDURE fn_registry_sync_host_insert();