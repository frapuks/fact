-- Revert ofact:5.invoice_details from pg

BEGIN;

DROP VIEW invoice_details;

COMMIT;
