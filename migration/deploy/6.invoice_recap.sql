-- Deploy ofact:6.invoice_recap to pg

BEGIN;

CREATE VIEW invoice_recap AS
    SELECT
    invoice.id,
    issued_at,
    paid_at,
    (
        SELECT visitor.name
        FROM visitor
        WHERE visitor.id = invoice.visitor_id
    ) AS visitor,
    (
        SELECT SUM(total)
        FROM invoice_details
        WHERE invoice_ref = invoice.id
    ) AS total
    FROM invoice;

COMMIT;
