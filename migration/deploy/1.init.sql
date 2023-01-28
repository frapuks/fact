-- Deploy ofact:1.init to pg

BEGIN;

CREATE DOMAIN email AS TEXT
CHECK (
    VALUE ~ '^([a-zA-Z0-9]+[-_.]?)*[a-zA-Z0-9]+@[a-zA-Z0-9]+[-]?[a-zA-Z0-9]+.[a-z]{2,}$'
);

CREATE DOMAIN password AS TEXT
CHECK (
    VALUE ~ '^\$2b\$'
);

CREATE DOMAIN zip_code AS TEXT
CHECK (
    VALUE ~ '^[\d]{5}$'
);

CREATE DOMAIN price AS DECIMAL
CHECK (
    VALUE > 0
);

CREATE TABLE visitor (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email email UNIQUE NOT NULL,
    password password NOT NULL,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    zip_code zip_code NOT NULL,
    city TEXT NOT NULL
);

CREATE TABLE product (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label TEXT UNIQUE NOT NULL,
    price price NOT NULL,
    price_with_taxes price NOT NULL
);

CREATE TABLE invoice (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    visitor_id INTEGER NOT NULL REFERENCES visitor(id),
    issued_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    paid_at TIMESTAMPTZ
);

CREATE TABLE invoice_line (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quantity INTEGER NOT NULL,
    invoice_id INTEGER NOT NULL REFERENCES invoice(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES product(id)
);

CREATE INDEX product_label_index ON product USING hash (label);
CREATE INDEX price_index ON product (price);
CREATE INDEX invoice_id_index ON invoice_line USING hash (invoice_id);

COMMIT;
