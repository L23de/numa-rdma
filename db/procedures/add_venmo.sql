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
