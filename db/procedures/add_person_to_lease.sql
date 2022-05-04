create or replace PROCEDURE add_person_to_lease (
	pid IN person.id%type,
	lid IN lease.id%type,
	success OUT number
) IS
	valid number;
BEGIN
	-- Check if lease is valid
	SELECT COUNT(*) INTO valid
	FROM lease join person_on_lease on lease.id = person_on_lease.person_id
	WHERE
		lease.id = lid AND person_id <> pid AND
		CURRENT_TIMESTAMP >= ADD_MONTHS(start_date, term_length);

	IF valid <> 0 THEN
		success := 1;
		return;
	END IF;

	INSERT INTO person_on_lease VALUES(lid, pid);
	success := 0;
END;


