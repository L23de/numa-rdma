-- Select leases that are still active
-- End date of the lease is past today's date
-- Payment has already been made for the month or first payment is due

SELECT id, prop_id, apt, start_date, term_length, rent_amount
FROM lease left outer join lease_payment on lease.id = lease_payment.lease_id
WHERE id in (SELECT lease_id from person_on_lease where person_id = 8) and
	TO_CHAR(ADD_MONTHS(start_date, term_length), 'YYYYMM') >= TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMM') and 
	(TO_CHAR(date_paid, 'YYYYMM') = TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMM') or TO_CHAR(date_paid, 'YYYYMM') is null);