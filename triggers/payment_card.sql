CREATE OR REPLACE TRIGGER payment_card
    AFTER INSERT ON pay_card
    FOR EACH ROW
    BEGIN
        INSERT INTO payment_method VALUES(DEFAULT, :NEW.id, NULL, NULL);
    END;

