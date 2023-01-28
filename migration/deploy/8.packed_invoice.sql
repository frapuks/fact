-- Deploy ofact:8.packed_invoice to pg

BEGIN;

CREATE TYPE packed AS (name TEXT, city TEXT, invoice_ref INTEGER, issued_at TIMESTAMPTZ, paid_at TIMESTAMPTZ, lines JSON[], total NUMERIC);

CREATE FUNCTION packed_invoice (invoiceId INTEGER) RETURNS SETOF packed AS $$
	BEGIN
		RETURN QUERY (
			SELECT invoice_recap.visitor AS name, invoice_details.city, invoice_recap.id AS invoice_ref, invoice_recap.issued_at, invoice_recap.paid_at, array_agg(json_build_object('quantity', quantity, 'label', label, 'price', price, 'taux TVA', taux_tva, 'total ligne', invoice_details.total)) AS lines, invoice_recap.total
			FROM invoice_recap
			JOIN invoice_details ON invoice_ref = invoice_recap.id
			WHERE invoice_recap.id = invoiceId
			GROUP BY invoice_recap.visitor, invoice_details.city, invoice_recap.id, invoice_recap.issued_at, invoice_recap.paid_at, invoice_recap.total
		);
	END;
$$ LANGUAGE plpgsql;

COMMIT;
