CREATE OR REPLACE PROCEDURE sign_lease (
    personId IN payment_method.person_id%type,
    propId IN lease.prop_id%type,
    apt IN lease.apt%type,
    termLength IN lease.term_length%type,
    success OUT number
) IS
    amt number;
    valid number;
    rent_amount lease.rent_amount%type;
    lease_id lease.id%type;
BEGIN
    -- Ensures that the lease does not exist the same time as another        
    SELECT COUNT(*) into amt 
    FROM lease 
    WHERE 
        prop_id = propId and apt = apt AND 
        CURRENT_TIMESTAMP <= ADD_MONTHS(start_date, term_length);

    -- Ensures that the apartment is a valid apartment
    SELECT COUNT(*) into valid
    FROM apartment 
    WHERE prop_id = propId and apt = apt;
    
    IF amt <> 0 THEN
        success := -1;
        return;
    ELSIF valid <> 0 THEN
        success := -2;
        return;
    END IF;
    
    SELECT RENT into rent_amount 
    FROM apartment where prop_id = propId and apt = apt;

    INSERT INTO lease(prop_id, apt, start_date, term_length, rent_amount) 
    VALUES(propId, apt, CURRENT_TIMESTAMP, termLength, rent_amount);

    SELECT MAX(id) into lease_id 
    FROM lease;

    INSERT INTO person_on_lease VALUES(lease_id, personId);

    success := 0;
END;

