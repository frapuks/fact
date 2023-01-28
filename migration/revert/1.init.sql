-- Revert ofact:1.init from pg

BEGIN;

DROP INDEX price_index, product_label_index, invoice_id_index;
DROP TABLE visitor, invoice, invoice_line, product;
DROP DOMAIN email, password, zip_code, price;

COMMIT;
