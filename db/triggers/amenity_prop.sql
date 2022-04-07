CREATE OR REPLACE TRIGGER amenity_prop
    AFTER INSERT ON prop_amenity
    FOR EACH ROW
    BEGIN
        INSERT INTO amenity(prop_amenity_id, apt_amenity_id) VALUES(:NEW.id, NULL);
    END;

