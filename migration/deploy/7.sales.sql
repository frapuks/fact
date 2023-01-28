-- Deploy ofact:7.sales to pg

BEGIN;

CREATE TYPE sales AS (date DATE, nb_invoices INTEGER, total NUMERIC);

CREATE FUNCTION sales_by_dates(date_from DATE, date_to DATE) RETURNS SETOF sales AS $$
	BEGIN
		RETURN QUERY (
			SELECT currentDate::DATE, COUNT(invoice_recap.id)::integer AS nb_invoices, COALESCE(SUM(invoice_recap.total),0)
			FROM generate_series(date_from::DATE, date_to::DATE, '1day') AS currentDate
			FULL JOIN invoice_recap ON currentDate = issued_at::date
			GROUP BY currentDate
		);
	END
$$ LANGUAGE plpgsql;

COMMIT;
