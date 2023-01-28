-- Deploy ofact:2.3fn to pg

BEGIN;

CREATE TABLE tax (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    percent DECIMAL NOT NULL
);

INSERT INTO tax (name, percent)
VALUES
    ('TVA', 20),
    ('TVA réduite', 5.5);

ALTER TABLE product
    ADD COLUMN tax_id INT NOT NULL REFERENCES tax(id) DEFAULT 1;
ALTER TABLE product
    ALTER COLUMN tax_id DROP DEFAULT;

CREATE FUNCTION migration_tax() RETURNS void AS $$
    DECLARE
        prod record;
        prixHT decimal;
        prixTTC decimal;
        taxe decimal(10,2);
        fk int;
    BEGIN
        FOR prod IN
            SELECT * FROM product
        LOOP
            prixHT := prod.price;
            prixTTC := prod.price_with_taxes;
            taxe := (prixTTC/prixHT-1)*100;

            IF taxe = 20 then fk = (SELECT id FROM tax WHERE percent = 20);
                ELSE fk = (SELECT id FROM tax WHERE percent = 5.50);
            END if;

            UPDATE product
                SET tax_id = fk
                WHERE id = prod.id;
        END LOOP;
    END
$$ LANGUAGE plpgsql;

SELECT * FROM migration_tax();

DROP FUNCTION migration_tax;

ALTER TABLE product
    DROP COLUMN price_with_taxes;

COMMIT;
