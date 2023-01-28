-- Revert ofact:4.update_function_invoice from pg

BEGIN;

DROP FUNCTION update_invoice, update_invoice_issued_at;

CREATE FUNCTION update_invoice(body JSON) RETURNS invoice AS $$
    UPDATE invoice
    SET
        visitor_id = CAST(body->>'visitor_id' AS INT),
        issued_at = CAST(body->>'issued_at' AS TIMESTAMPTZ),
        paid_at = CAST(body->>'paid_at' AS TIMESTAMPTZ)
    WHERE id = CAST(body->>'id' AS INT)
    RETURNING *;
$$ LANGUAGE SQL;

COMMIT;
