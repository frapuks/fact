-- Verify ofact:5.invoice_details on pg

BEGIN;

SELECT * FROM invoice_details;

ROLLBACK;
