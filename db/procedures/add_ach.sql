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

