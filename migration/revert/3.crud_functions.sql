-- Revert ofact:3.crud_functions from pg

BEGIN;

DROP FUNCTION insert_visitor, update_visitor, insert_invoice, update_invoice, insert_invoice_line, update_invoice_line, insert_product, update_product, insert_tax, update_tax;

COMMIT;
