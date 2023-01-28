-- Revert ofact:8.packed_invoice from pg

BEGIN;

DROP FUNCTION packed_invoice;
DROP TYPE packed;

COMMIT;
