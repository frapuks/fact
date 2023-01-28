-- Verify ofact:9.add_invoice on pg

BEGIN;

SELECT id FROM add_invoice('{
    "issued_at": "2022-04-13 10:00:00+02", 
    "visitor_id": 1, 
    "products": [
        {
            "id": 1,
            "quantity": 5
        },
        {
            "id": 2,
            "quantity": 3
        }
    ]
}') AS id;

ROLLBACK;
