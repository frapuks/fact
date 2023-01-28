-- Verify ofact:6.invoice_recap on pg

BEGIN;

SELECT * FROM invoice_details;

ROLLBACK;
