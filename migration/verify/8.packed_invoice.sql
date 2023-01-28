-- Verify ofact:8.packed_invoice on pg

BEGIN;

SELECT * FROM packed_invoice(1);

ROLLBACK;
