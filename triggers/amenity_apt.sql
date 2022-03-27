CREATE OR REPLACE TRIGGER amenity_apt
    AFTER INSERT ON apt_amenity
    FOR EACH ROW
    BEGIN
        INSERT INTO amenity VALUES(DEFAULT, NULL, :NEW.id);
    END;

