CREATE OR REPLACE TRIGGER amenity_apt
    AFTER INSERT ON apt_amenity
    FOR EACH ROW
    BEGIN
        INSERT INTO amenity(prop_amenity_id, apt_amenity_id) VALUES(NULL, :NEW.id);
    END;

