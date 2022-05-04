create or replace PROCEDURE add_card (
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


	