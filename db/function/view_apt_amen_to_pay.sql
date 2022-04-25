CREATE OR REPLACE FUNCTION apt_amen_to_pay (
	lid number,
	pid number,
	apt_str apartment.apt%type
) RETURN amen_pay_table 
AS
	tbl_out amen_pay_table;
BEGIN
	SELECT amen_pay_row(amenity.id, amenity, cost)
	BULK COLLECT INTO tbl_out
	FROM 
		-- Check amenities that correspond to the person's lease
		(amenity left outer join 
			(SELECT amenity_id, MAX(date_paid) as date_paid 
			FROM amenity_payment 
			WHERE payer in -- Payers were people on the lease
				(SELECT person_id from person_on_lease
				WHERE lease_id = lid)
			GROUP BY amenity_id)
		on amenity.id = amenity_id) 
		join apt_amenity on amenity.apt_amenity_id = apt_amenity.id
	WHERE
		prop_id = pid and apt = apt_str and -- Amenity connected to the apartment
		(CURRENT_TIMESTAMP >= ADD_MONTHS(date_paid, 1) OR
		date_paid is null);

	-- If months_outstanding is NULL, in Java, set it to ceiling of months between CURRENT_TIMESTAMP - start_date

	RETURN tbl_out;
END;