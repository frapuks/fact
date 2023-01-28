-- Revert ofact:9.add_invoice from pg

BEGIN;

DROP FUNCTION add_invoice;

COMMIT;
