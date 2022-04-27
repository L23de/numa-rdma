CREATE OR REPLACE PROCEDURE add_ach (
		person_id payment_method.person_id%type,
		acct_num ach.acct_num%type,
		routing_num ach.routing_num%type,
		bank_name ach.bank_name%type
	) IS
		ach_id payment_method.ach_id%type;

	BEGIN
		INSERT INTO ach(acct_num, routing_num, bank_name) VALUES(acct_num, routing_num, bank_name);
		SELECT MAX(id) into ach_id from ach;
		INSERT INTO payment_method(person_id, card_id, venmo_id, ach_id) VALUES(person_id, NULL, NULL, ach_id);
	END;

CREATE OR REPLACE PROCEDURE add_card (
		person_id payment_method.person_id%type,
		first_name pay_card.first_name%type,
		last_name pay_card.last_name%type,
		card_num pay_card.card_num%type,
		exp_date pay_card.exp_date%type,
		cvv pay_card.cvv%type,
		pin pay_card.pin%type
	) IS
		card_id payment_method.card_id%type;
	BEGIN
		INSERT INTO pay_card(first_name, last_name, card_num, exp_date, cvv, pin) VALUES(first_name, last_name, card_num, exp_date, cvv, pin);
		SELECT MAX(id) into card_id from pay_card;
		INSERT INTO payment_method(person_id, card_id, venmo_id, ach_id) VALUES(person_id, card_id, NULL, NULL);
	END;

CREATE OR REPLACE PROCEDURE add_person_to_lease (
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
CREATE OR REPLACE PROCEDURE add_pet (
		animal pet.animal%type,
		pet_name pet.pet_name%type,
		lease_id lease.id%type
	) IS
		pet_id pet.id%type;
	BEGIN
		INSERT INTO pet(animal, pet_name) VALUES(animal, pet_name);
		SELECT MAX(id) into pet_id from pet;
		INSERT INTO pet_on_lease(lease_id, pet_id) VALUES(lease_id, pet_id);
	END;
CREATE OR REPLACE PROCEDURE add_venmo (
		person_id payment_method.person_id%type,
		handle venmo.handle%type
	) IS
		venmo_id payment_method.venmo_id%type;
	BEGIN
		INSERT INTO venmo(handle) VALUES(handle);
		SELECT MAX(id) into venmo_id from venmo;
		INSERT INTO payment_method(person_id, card_id, venmo_id, ach_id) VALU ES(person_id, NULL, venmo_id, NULL);
	END;
-- Used by NUMA to add apartments for a new property
-- Do last

CREATE OR REPLACE PROCEDURE -- Used by tenants to make an outstanding payment

CREATE OR REPLACE PROCEDURE make_payment (
	amen_id IN amenity_payment.amenity_id%type,
	lease_id IN lease_payment.lease_id%type,
	pay_method IN payment_method.id%type,
	pay_amt IN amenity_payment.pay_amt%type,
	payer IN person.id%type,
	memo IN amenity_payment.memo%type,
	ret OUT NUMBER
)
IS
BEGIN
	IF amen_id <> -1 THEN
		INSERT INTO amenity_payment(amenity_id, date_paid, pay_method_id, pay_amt, payer, memo)
		VALUES(amen_id, CURRENT_TIMESTAMP, pay_method, pay_amt, payer, memo);
		ret := 0;
	ELSIF lease_id <> -1 THEN
		INSERT INTO lease_payment(lease_id, date_paid, pay_method_id, pay_amt, payer, memo)
		VALUES(lease_id, CURRENT_TIMESTAMP, pay_method, pay_amt, payer, memo);
		ret := 0;
	ELSE
		ret := 1;
	END IF;
END;CREATE OR REPLACE PROCEDURE sign_lease (
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

-- Used to update an apartment's specs (Maybe due to renovation or rent hike)
-- Make sure that the apartment is out of lease

CREATE OR REPLACE PROCEDURE update_apt (
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
