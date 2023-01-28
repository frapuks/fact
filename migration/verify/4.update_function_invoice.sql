-- Verify ofact:4.update_function_invoice on pg

BEGIN;

SELECT * FROM update_invoice('{
    "visitor_id": "1",
    "id": 1
}');

SELECT * FROM update_invoice_issued_at('{
    "issued_at": "2020-01-01",
    "id": 1
}');

ROLLBACK;
