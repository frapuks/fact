-- Revert ofact:6.invoice_recap from pg

BEGIN;

DROP VIEW invoice_recap;

COMMIT;
