-- Verify ofact:7.sales on pg

BEGIN;

SELECT * FROM sales_by_dates('2019-12-31', '2024-01-02');

ROLLBACK;
