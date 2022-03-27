CREATE OR REPLACE TRIGGER amenity_prop
    AFTER INSERT ON prop_amenity
    FOR EACH ROW
    BEGIN
        INSERT INTO amenity VALUES(DEFAULT, :NEW.id, NULL);
    END;

