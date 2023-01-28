-- Revert ofact:7.sales from pg

BEGIN;

DROP FUNCTION sales_by_dates;
DROP TYPE sales;

COMMIT;
