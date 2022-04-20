CREATE OR REPLACE PROCEDURE sign_lease (
		personId IN payment_method.person_id%type,
		propId IN lease.prop_id%type,
        apt IN lease.apt%type,
        termLength IN lease.term_length%type,
        amt OUT number,
        valid OUT number,
        success OUT number
	) IS
        rent_amount lease.rent_amount%type;
        lease_id lease.id%type;
	BEGIN
        -- Ensures that the lease does not exist the same time as another        
        SELECT COUNT(*) into amt from lease where prop_id = propId and apt=apt and CURRENT_TIMESTAMP <= ADD_MONTHS(start_date, term_length);
        -- Ensures that the apartment is a valid apartment
        SELECT COUNT(*) into valid from apartment where prop_id = propId and apt = apt;
        
        IF amt <> 0 THEN
            success := -1;
            return;
        ELSIF valid <> 0 THEN
            success := -2;
            return;
        END IF;
        
        SELECT RENT into rent_amount from apartment where prop_id = propId and apt = apt;
        INSERT INTO lease(prop_id, apt, start_date, term_length, rent_amount) VALUES(propId, apt, CURRENT_TIMESTAMP, termLength, rent_amount);
        SELECT MAX(id) into lease_id from lease;
        INSERT INTO person_on_lease VALUES(lease_id, personId);
        success := 0;
	END;

