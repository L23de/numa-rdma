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

CREATE OR REPLACE PROCEDURE add_pet_lease (
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
		INSERT INTO payment_method(person_id, card_id, venmo_id, ach_id) VALUES(person_id, NULL, venmo_id, NULL);
	END;
