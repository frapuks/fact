-- Verify ofact:2.3fn on pg

BEGIN;

SELECT (id, label, price, tax_id) FROM product;

ROLLBACK;
