-- Revert ofact:2.3fn from pg

BEGIN;


ALTER TABLE product
    ADD COLUMN price_with_taxes price NOT NULL DEFAULT 1;
ALTER TABLE product
    ALTER COLUMN price_with_taxes DROP DEFAULT;

CREATE FUNCTION revert_tax() RETURNS void AS $$
    DECLARE
        prod record;
        prixHT decimal;
        tax decimal;
        prixTTC decimal(10,2);
    BEGIN
        FOR prod IN
            SELECT * FROM product
        LOOP
            tax := (SELECT percent FROM tax WHERE tax.id = prod.tax_id);
            prixHT := prod.price;
            prixTTC := prixHT+(prixHT*tax/100);

            UPDATE product
                SET price_with_taxes = prixTTC
                WHERE id = prod.id;
        END LOOP;
    END
$$ LANGUAGE plpgsql;

SELECT * FROM revert_tax();

DROP FUNCTION revert_tax;

ALTER TABLE product
    DROP COLUMN tax_id;

DROP TABLE tax;

COMMIT;
