-- Verify ofact:1.init on pg

BEGIN;

SELECT (id, email, password, name, address, zip_code, city) FROM visitor;
SELECT (id, visitor_id, issued_at, paid_at) FROM invoice;
SELECT (id, quantity, invoice_id, product_id) FROM invoice_line;
SELECT (id, label, price) FROM product;

ROLLBACK;
