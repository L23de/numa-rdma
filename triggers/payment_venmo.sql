CREATE OR REPLACE TRIGGER payment_venmo
    AFTER INSERT ON venmo
    FOR EACH ROW
    BEGIN
        INSERT INTO payment_method VALUES(DEFAULT, NULL, :NEW.id, NULL);
    END;

