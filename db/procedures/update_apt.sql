create or replace PROCEDURE update_apt (
	propId IN apartment.prop_id%type,
	apt IN apartment.apt%type,
	sqFeet IN apartment.square_footage%type,
	beds IN apartment.bed_count%type,
	baths IN apartment.bath_count%type,
	rent IN apartment.rent%type,
	success OUT number
) IS
	amt number;
BEGIN
--	 Find if there is a lease for the corresponding apartment 
--	 (Should return 1 if under a lease, 0 if not)
	SELECT COUNT(*) into amt
	FROM lease
	WHERE 
		prop_id = propId AND apt = apt AND
		ADD_MONTHS(start_date, term_length) < CURRENT_TIMESTAMP;

	IF amt <> 0 THEN
		success := -1;
		return;
	END IF;

	UPDATE apartment
	SET 
		square_footage = sqFeet,
		bed_count = beds,
		bath_count = baths,
		rent = rent
	WHERE prop_id = propId and apt = apt;

	success := 0;
END;


