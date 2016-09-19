DROP TRIGGER tr_registry_sync_contact_insert ON audit.contact;

CREATE OR REPLACE FUNCTION fn_registry_sync_contact_insert() RETURNS TRIGGER
AS
$BODY$
DECLARE
-- nothing to declare
BEGIN
PERFORM
DBLINK_EXEC('dbname=cocca user=coccauser password=coccauser','INSERT INTO registry_sync_contacts(audit_transaction, audit_operation, roid, audit_contactid, st_cl_deleteprohibited, st_cl_transferprohibited, st_cl_updateprohibited, st_linked, st_ok, st_pendingcreate, st_pendingdelete, st_pendingtransfer, st_pendingupdate, st_sv_deleteprohibited, st_sv_transferprohibited, st_sv_updateprohibited, intpostalname, intpostalorg, intpostalstreet1, intpostalstreet2, intpostalstreet3, intpostalcity, intpostalsp, intpostalpc, intpostalcc, locpostalname, locpostalorg, locpostalstreet1, locpostalstreet2, locpostalstreet3, locpostalcity, locpostalsp, locpostalpc, locpostalcc, voice, voicex, fax, faxx, email, authinfopw, clid, crid, createdate, upid, updatedate, transferdate, queued, acknowledged) VALUES(' ||
new.audit_transaction||' , '''||new.audit_operation||''', '''||new.roid||''', '''||new.id||''', '||
CASE WHEN new.st_cl_deleteprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_cl_deleteprohibited || '''' END || ', ' ||
CASE WHEN new.st_cl_transferprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_cl_transferprohibited || '''' END || ', ' ||
CASE WHEN new.st_cl_updateprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_cl_updateprohibited || '''' END || ', ' ||
CASE WHEN new.st_linked IS NULL THEN 'NULL' ELSE '''' || new.st_linked || '''' END || ', ' ||
CASE WHEN new.st_ok IS NULL THEN 'NULL' ELSE '''' || new.st_ok || '''' END || ', ' ||
CASE WHEN new.st_pendingcreate IS NULL THEN 'NULL' ELSE '''' || new.st_pendingcreate || '''' END || ', ' ||
CASE WHEN new.st_pendingdelete IS NULL THEN 'NULL' ELSE '''' || new.st_pendingdelete || '''' END || ', ' ||
CASE WHEN new.st_pendingtransfer IS NULL THEN 'NULL' ELSE '''' || new.st_pendingtransfer || '''' END || ', ' ||
CASE WHEN new.st_pendingupdate IS NULL THEN 'NULL' ELSE '''' || new.st_pendingupdate || '''' END || ', ' ||
CASE WHEN new.st_sv_deleteprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_sv_deleteprohibited || '''' END || ', ' ||
CASE WHEN new.st_sv_transferprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_sv_transferprohibited || '''' END || ', ' ||
CASE WHEN new.st_sv_updateprohibited IS NULL THEN 'NULL' ELSE '''' || new.st_sv_updateprohibited || '''' END || ', ' ||
CASE WHEN new.intpostalname IS NULL THEN 'NULL' ELSE '''' || new.intpostalname || '''' END || ', ' ||
CASE WHEN new.intpostalorg IS NULL THEN 'NULL' ELSE '''' || new.intpostalorg || '''' END || ', ' ||
CASE WHEN new.intpostalstreet1 IS NULL THEN 'NULL' ELSE '''' || new.intpostalstreet1 || '''' END || ', ' ||
CASE WHEN new.intpostalstreet2 IS NULL THEN 'NULL' ELSE '''' || new.intpostalstreet2 || '''' END || ', ' ||
CASE WHEN new.intpostalstreet3 IS NULL THEN 'NULL' ELSE '''' || new.intpostalstreet3 || '''' END || ', ' ||
CASE WHEN new.intpostalcity IS NULL THEN 'NULL' ELSE '''' || new.intpostalcity || '''' END || ', ' ||
CASE WHEN new.intpostalsp IS NULL THEN 'NULL' ELSE '''' || new.intpostalsp || '''' END || ', ' ||
CASE WHEN new.intpostalpc IS NULL THEN 'NULL' ELSE '''' || new.intpostalpc || '''' END || ', ' ||
CASE WHEN new.intpostalcc IS NULL THEN 'NULL' ELSE '''' || new.intpostalcc || '''' END || ', ' ||
CASE WHEN new.locpostalname IS NULL THEN 'NULL' ELSE '''' || new.locpostalname || '''' END || ', ' ||
CASE WHEN new.locpostalorg IS NULL THEN 'NULL' ELSE '''' || new.locpostalorg || '''' END || ', ' ||
CASE WHEN new.locpostalstreet1 IS NULL THEN 'NULL' ELSE '''' || new.locpostalstreet1 || '''' END || ', ' ||
CASE WHEN new.locpostalstreet2 IS NULL THEN 'NULL' ELSE '''' || new.locpostalstreet2 || '''' END || ', ' ||
CASE WHEN new.locpostalstreet3 IS NULL THEN 'NULL' ELSE '''' || new.locpostalstreet3 || '''' END || ', ' ||
CASE WHEN new.locpostalcity IS NULL THEN 'NULL' ELSE '''' || new.locpostalcity || '''' END || ', ' ||
CASE WHEN new.locpostalsp IS NULL THEN 'NULL' ELSE '''' || new.locpostalsp || '''' END || ', ' ||
CASE WHEN new.locpostalpc IS NULL THEN 'NULL' ELSE '''' || new.locpostalpc || '''' END || ', ' ||
CASE WHEN new.locpostalcc IS NULL THEN 'NULL' ELSE '''' || new.locpostalcc || '''' END || ', ' ||
CASE WHEN new.voice IS NULL THEN 'NULL' ELSE '''' || new.voice || '''' END || ', ' ||
CASE WHEN new.voicex IS NULL THEN 'NULL' ELSE '''' || new.voicex || '''' END || ', ' ||
CASE WHEN new.fax IS NULL THEN 'NULL' ELSE '''' || new.fax || '''' END || ', ' ||
CASE WHEN new.faxx IS NULL THEN 'NULL' ELSE '''' || new.faxx || '''' END || ', ' ||
CASE WHEN new.email IS NULL THEN 'NULL' ELSE '''' || new.email || '''' END || ', ' ||
CASE WHEN new.authinfopw IS NULL THEN 'NULL' ELSE '''' || new.authinfopw || '''' END || ', ''' ||
new.clid||''', '''||new.crid||''', '''||new.createdate||''', '||
CASE WHEN new.upid IS NULL THEN 'NULL' ELSE '''' || new.upid || '''' END || ', ' ||
CASE WHEN new.updatedate IS NULL THEN 'NULL' ELSE '''' || new.updatedate || '''' END || ', ' ||
CASE WHEN new.transferdate IS NULL THEN 'NULL' ELSE '''' || new.transferdate || '''' END || ', false, false)');
RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_registry_sync_contact_insert
AFTER INSERT ON audit.contact
FOR EACH ROW EXECUTE PROCEDURE fn_registry_sync_contact_insert();