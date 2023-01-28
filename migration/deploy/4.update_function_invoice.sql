-- Deploy ofact:4.update_function_invoice to pg

BEGIN;

DROP FUNCTION update_invoice;

CREATE FUNCTION update_invoice(body JSON) RETURNS invoice AS $$
    UPDATE invoice
    SET
        visitor_id = CAST(body->>'visitor_id' AS INT),
        paid_at = (SELECT COALESCE (CAST(body->>'paid_at' AS TIMESTAMPTZ), NOW()))
    WHERE id = CAST(body->>'id' AS INT)
    RETURNING *;
$$ LANGUAGE SQL;

CREATE FUNCTION update_invoice_issued_at(body JSON) RETURNS invoice AS $$
    UPDATE invoice
    SET
        issued_at = (SELECT COALESCE (CAST(body->>'issued_at' AS TIMESTAMPTZ), NOW()))
    WHERE id = CAST(body->>'id' AS INT)
    RETURNING *;
$$ LANGUAGE SQL;

COMMIT;
