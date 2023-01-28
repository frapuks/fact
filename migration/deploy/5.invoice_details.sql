-- Deploy ofact:5.invoice_details to pg

BEGIN;

CREATE VIEW invoice_details AS
    SELECT visitor.name, city, invoice.id AS invoice_ref, issued_at, paid_at, quantity, label, price, percent AS taux_TVA, (price*(1+(percent/100))*quantity)::decimal(10,2) AS total
    FROM invoice_line
    JOIN product ON product_id = product.id
    JOIN tax ON tax_id = tax.id
    JOIN invoice ON invoice_id = invoice.id
    JOIN visitor ON visitor_id = visitor.id;

COMMIT;
