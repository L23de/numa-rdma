create or replace FUNCTION sign_lease_helper (
	propId IN lease.prop_id%type,
    aptId IN lease.apt%type,
    termLength IN lease.term_length%type
) RETURN number
IS
    amt number;
    valid number;
	rent_amount lease.rent_amount%type;
    leaseId number;
BEGIN
	-- Ensures that the lease does not exist the same time as another        
    SELECT COUNT(*) into amt 
    FROM lease 
    WHERE 
        prop_id = propId and apt = aptId AND 
        CURRENT_TIMESTAMP <= ADD_MONTHS(start_date, term_length);

    -- Ensures that the apartment is a valid apartment
    SELECT COUNT(*) into valid
    FROM apartment 
    WHERE prop_id = propId and apt = aptId;

    IF amt <> 0 THEN
        return -1;
    ELSIF valid = 0 THEN
        return -2;
    END IF;

    SELECT RENT into rent_amount 
    FROM apartment where prop_id = propId and apt = aptId;

    INSERT INTO lease(prop_id, apt, start_date, term_length, rent_amount) 
    VALUES(propId, aptId, CURRENT_TIMESTAMP, termLength, rent_amount) RETURNING id into leaseId;
    commit;
    return leaseId;
END;