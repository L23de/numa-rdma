CREATE OR REPLACE TRIGGER update_payment
    AFTER INSERT ON payment_method
    FOR EACH ROW
    BEGIN
		UPDATE renter_info
		SET preferred_payment = :NEW.id
		WHERE person_id = :NEW.person_id
    END;

