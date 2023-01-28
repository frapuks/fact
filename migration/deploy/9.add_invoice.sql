-- Deploy ofact:9.add_invoice to pg

BEGIN;

CREATE FUNCTION add_invoice (body JSON) RETURNS integer AS $$
	DECLARE
		prod record;
	BEGIN
		RETURN (
			SELECT id FROM insert_invoice(body)
		) AS invoiceId;

		FOR
			prod IN SELECT products FROM body
		LOOP
			SELECT * FROM insert_invoice_line(
				json_build_object(
					'quantity', (prod->>quantity),
					'invoice_id', invoiceId,
					'product_id', (prod->>id)
				)
			);
		END LOOP;
	END;
$$ LANGUAGE plpgsql;

COMMIT;
