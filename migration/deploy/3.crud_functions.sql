-- Deploy ofact:3.crud_functions to pg

BEGIN;

CREATE FUNCTION insert_visitor(body JSON) RETURNS visitor AS $$
    INSERT INTO visitor (email, password, name, address, zip_code, city)
        VALUES (
            body->>'email',
            body->>'password',
            body->>'name',
            body->>'address',
            body->>'zip_code',
            body->>'city'
        )
        RETURNING *;
$$ LANGUAGE SQL;

CREATE FUNCTION update_visitor(body JSON) RETURNS visitor AS $$
    UPDATE visitor
    SET
        email = body->>'email',
        password = body->>'password',
        name = body->>'name',
        address = body->>'address',
        zip_code = body->>'zip_code',
        city = body->>'city'
    WHERE id = CAST(body->>'id' AS INT)
    RETURNING *;
$$ LANGUAGE SQL;






CREATE FUNCTION insert_invoice(body JSON) RETURNS invoice AS $$
    INSERT INTO invoice (visitor_id, issued_at)
        VALUES (
            CAST(body->>'visitor_id' AS INT),
            CAST(body->>'issued_at' AS TIMESTAMPTZ)
        ) RETURNING *;
$$ LANGUAGE SQL;

CREATE FUNCTION update_invoice(body JSON) RETURNS invoice AS $$
    UPDATE invoice
    SET
        visitor_id = CAST(body->>'visitor_id' AS INT),
        issued_at = CAST(body->>'issued_at' AS TIMESTAMPTZ),
        paid_at = CAST(body->>'paid_at' AS TIMESTAMPTZ)
    WHERE id = CAST(body->>'id' AS INT)
    RETURNING *;
$$ LANGUAGE SQL;






CREATE FUNCTION insert_invoice_line(body JSON) RETURNS invoice_line AS $$
    INSERT INTO invoice_line (quantity, invoice_id, product_id)
        VALUES (
            CAST(body->>'quantity' AS INT),
            CAST(body->>'invoice_id' AS INT),
            CAST(body->>'product_id' AS INT)
        ) RETURNING *;
$$ LANGUAGE SQL;

CREATE FUNCTION update_invoice_line(body JSON) RETURNS invoice_line AS $$
    UPDATE invoice_line
    SET
        quantity = CAST(body->>'quantity' AS INT),
        invoice_id = CAST(body->>'invoice_id' AS INT),
        product_id = CAST(body->>'product_id' AS INT)
    WHERE id = CAST(body->>'id' AS INT)
    RETURNING *;
$$ LANGUAGE SQL;






CREATE FUNCTION insert_product(body JSON) RETURNS product AS $$
    INSERT INTO product (label, price, tax_id)
        VALUES (
            body->>'label',
            CAST(body->>'price' AS DECIMAL),
            CAST(body->>'tax_id' AS DECIMAL)
        ) RETURNING *;
$$ LANGUAGE SQL;

CREATE FUNCTION update_product(body JSON) RETURNS product AS $$
    UPDATE product
    SET
        label = body->>'label',
        price = CAST(body->>'price' AS DECIMAL),
        tax_id = CAST(body->>'tax_id' AS DECIMAL)
    WHERE id = CAST(body->>'id' AS INT)
    RETURNING *;
$$ LANGUAGE SQL;






CREATE FUNCTION insert_tax(body JSON) RETURNS tax AS $$
    INSERT INTO tax (name, percent)
        VALUES (
            body->>'name',
            CAST(body->>'percent' AS DECIMAL)
        ) RETURNING *;
$$ LANGUAGE SQL;

CREATE FUNCTION update_tax(body JSON) RETURNS tax AS $$
    UPDATE tax
    SET
        name = body->>'name',
        percent = CAST(body->>'percent' AS DECIMAL)
    WHERE id = CAST(body->>'id' AS INT)
    RETURNING *;
$$ LANGUAGE SQL;

COMMIT;