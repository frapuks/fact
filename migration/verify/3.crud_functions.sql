-- Verify ofact:3.crud_functions on pg

BEGIN;

SELECT * FROM insert_visitor('{
    "email": "xx@xx.fr",
    "password": "$2b$12345",
    "name": "Nico",
    "address": "Au mileu de la grande anse",
    "zip_code": "17370",
    "city": "Grand-Village plage"
}');
SELECT * FROM update_visitor('{
    "email": "numero@bis.eg",
    "password": "$2b$10$Btz1P5F51OMGfvuuL1wh7.kdwyEYXdzCSGpbLg1BAlx91GvwFGlXm",
    "name": "Numérobis",
    "address": "Avant dernière pyramide à gauche",
    "zip_code": "12345",
    "city": "Le Caire",
    "id": 1
}');



SELECT * FROM insert_invoice('{
    "visitor_id": "1",
    "issued_at": "2023-01-27",
    "paid_at": "2023-01-22"
}');
SELECT * FROM update_invoice('{
    "visitor_id": "1",
    "issued_at": "2020-01-01",
    "paid_at": "2023-01-22",
    "id": 1
}');



SELECT * FROM insert_invoice_line('{
    "quantity": 245,
    "invoice_id": 1,
    "product_id": 1
}');
SELECT * FROM update_invoice_line('{
    "quantity": 3,
    "invoice_id": 1,
    "product_id": 1,
    "id": 1
}');



SELECT * FROM insert_product('{
    "label": "balle de biche volley",
    "price": 10,
    "tax_id": 1
}');
SELECT * FROM update_product('{
    "label": "Arsenic (1.5L)",
    "price": 35,
    "tax_id": 2,
    "id": 5
}');






ROLLBACK;
