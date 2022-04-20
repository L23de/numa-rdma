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
		INSERT INTO amenity_payment(date_paid, pay_method_id, pay_amt, payer, memo)
		VALUES(DEFAULT, pay_method, pay_amt, payer, memo);
		ret := 0;
	ELSIF lease_id <> -1 THEN
		INSERT INTO lease_payment(date_paid, pay_method_id, pay_amt, payer, memo)
		VALUES(DEFAULT, pay_method, pay_amt, payer, memo);
		ret := 0;
	ELSE
		ret := 1;
	END IF;
END;