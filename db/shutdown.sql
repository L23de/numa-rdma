-- Types
DROP TYPE amen_pay_table;
DROP TYPE lease_pay_table;
DROP TYPE prop_amen_table;

DROP TYPE amen_pay_row;
DROP TYPE lease_pay_row;
DROP TYPE prop_amen_row;

-- Triggers
DROP TRIGGER amenity_apt;
DROP TRIGGER amenity_prop;

DROP TRIGGER payment_ach;
DROP TRIGGER payment_card;
DROP TRIGGER payment_venmo;

DROP TRIGGER update_payment;

-- Functions
DROP FUNCTION apt_amen_to_pay;
DROP FUNCTION lease_to_pay;
DROP FUNCTION prop_amen_to_pay;

-- Procedures

DROP PROCEDURE add_ach;
DROP PROCEDURE add_card;
DROP PROCEDURE add_venmo;

DROP PROCEDURE add_pet;
DROP PROCEDURE add_person_to_lease;

DROP PROCEDURE make_payment;
DROP PROCEDURE sign_lease;
DROP PROCEDURE update_apt;

-- Tables
DROP TABLE lease_payment;
DROP TABLE amenity_payment;

DROP TABLE pet_on_lease;
DROP TABLE person_on_lease;
DROP TABLE lease;

DROP TABLE visited;
DROP TABLE prev_addr;
DROP TABLE renter_info;

DROP TABLE amenity;
DROP TABLE prop_amenity;
DROP TABLE apt_amenity;

DROP TABLE apartment;

DROP TABLE payment_method;
DROP TABLE pay_card;
DROP TABLE venmo;
DROP TABLE ach;

DROP TABLE property;
DROP TABLE person;
DROP TABLE pet;
DROP TABLE admin;