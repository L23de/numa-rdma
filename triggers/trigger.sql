CREATE OR REPLACE TRIGGER amenity_apt
    AFTER INSERT ON apt_amenity
    FOR EACH ROW
    BEGIN
        INSERT INTO amenity VALUES(DEFAULT, NULL, :NEW.id);
    END;

CREATE OR REPLACE TRIGGER amenity_prop
    AFTER INSERT ON prop_amenity
    FOR EACH ROW
    BEGIN
        INSERT INTO amenity VALUES(DEFAULT, :NEW.id, NULL);
    END;

CREATE OR REPLACE TRIGGER payment_ach
    AFTER INSERT ON ach
    FOR EACH ROW
    BEGIN
        INSERT INTO payment_method VALUES(DEFAULT, NULL, NULL, :NEW.id);
    END;

aCREATE OR REPLACE TRIGGER payment_card
    AFTER INSERT ON pay_card
    FOR EACH ROW
    BEGIN
        INSERT INTO payment_method VALUES(DEFAULT, :NEW.id, NULL, NULL);
    END;

CREATE OR REPLACE TRIGGER payment_venmo
    AFTER INSERT ON venmo
    FOR EACH ROW
    BEGIN
        INSERT INTO payment_method VALUES(DEFAULT, NULL, :NEW.id, NULL);
    END;

