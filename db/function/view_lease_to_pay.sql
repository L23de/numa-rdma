-- Select leases that are still active and have outstanding lease payments
-- End date of the lease is past today's date
-- Payment has already been made for the month or first payment is due

-- Call using 'select * from table(view_lease_to_pay(pid));'

CREATE OR REPLACE FUNCTION view_lease_to_pay (
	pid number
) RETURN lease_pay_table 
AS
	tbl_out lease_pay_table;
BEGIN
	SELECT lease_pay_row(
		prop_id, 
		apt, 
		start_date, 
		term_length, 
		rent_amount, 
		CEIL(MONTHS_BETWEEN(CURRENT_TIMESTAMP, date_paid))
	)
	BULK COLLECT INTO tbl_out
	FROM 
		lease
		left outer join 
		(SELECT lease_id, MAX(date_paid) as date_paid
		FROM lease_payment GROUP BY lease_id) 
		on lease.id = lease_id
		-- Selects lease info with most recent date paid
	WHERE 
		id in (SELECT lease_id from person_on_lease where person_id = pid) AND -- Lease is under the person
		ADD_MONTHS(start_date, term_length) >= CURRENT_TIMESTAMP AND -- Lease is still active
		(TO_DATE(date_paid, 'YYYYMM') <> TO_DATE(CURRENT_TIMESTAMP, 'YYYYMM') OR
		date_paid is null); -- Lease has not been paid this month (Includes null case)

	-- If months_outstanding is NULL, in Java, set it to ceiling of months between CURRENT_TIMESTAMP - start_date

	RETURN tbl_out;
END;