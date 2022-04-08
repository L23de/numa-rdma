-- ===================   
-- Primitive Tables
-- ===================
CREATE TABLE property (
	-- Autoincremented ID attribute
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	street_name VARCHAR2(255) NOT NULL,
	city VARCHAR2(255) NOT NULL,
	state CHAR(2) NOT NULL
		CHECK (state like '__'),
	zipcode CHAR(5) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE person (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	first_name VARCHAR2(255) NOT NULL,
	last_name VARCHAR2(255) NOT NULL,
	age NUMBER(2) NOT NULL,
	phone_number CHAR(12) NOT NULL 
		CHECK (REGEXP_LIKE(phone_number, '\d{3}-\d{3}-\d{4}')),
	email VARCHAR2(255) NOT NULL 
		CHECK (email LIKE '%@%'),
	credit_score NUMBER(3) NOT NULL 
		CHECK (credit_score >= 300 AND credit_score <= 850),
	PRIMARY KEY(id)
);

CREATE TABLE pet (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	animal VARCHAR2(255) NOT NULL,
	pet_name VARCHAR2(255),
	PRIMARY KEY(id)
);

CREATE TABLE admin (
	pin NUMBER
);


-- -------------------
-- Payment Types
-- -------------------
-- Can be debit or credit, from the point of view of NUMA, it doesn't matter (Debit will have PIN)
CREATE TABLE pay_card (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	first_name VARCHAR2(255) NOT NULL,
	last_name VARCHAR2(255) NOT NULL,
	card_num CHAR(19) NOT NULL
		CHECK (REGEXP_LIKE(card_num, '\d{19}')),
	exp_date CHAR(7) NOT NULL
		CHECK (exp_date LIKE '__/____'),
	cvv CHAR(3) NOT NULL
		CHECK (REGEXP_LIKE(cvv, '\d{3}')),
	pin CHAR(4) DEFAULT NULL
		CHECK (REGEXP_LIKE(pin, '\d{4}')),
	PRIMARY KEY(id)
);

CREATE TABLE venmo (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	handle VARCHAR2(255) NOT NULL
		CHECK (handle LIKE '@%'),
	PRIMARY KEY(id)
);

CREATE TABLE ach (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	acct_num CHAR(17) NOT NULL
		CHECK (REGEXP_LIKE(acct_num, '\d{17}')),
	routing_num CHAR(9) NOT NULL
		CHECK (REGEXP_LIKE(routing_num, '\d{9}')),
	bank_name VARCHAR2(255) NOT NULL,
	PRIMARY KEY(id)
);

-- Aggregates all payment methods into a single table with a unique ID
-- Adding a specific payment method (Card, Venmo or ACH) should trigger a row add to this table automatically
-- Only one of the [payment]_id methods should be filled, rest should be NULL
CREATE TABLE payment_method (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	person_id NUMBER NOT NULL,
	card_id NUMBER DEFAULT NULL,
	venmo_id NUMBER DEFAULT NULL,
	ach_id NUMBER DEFAULT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(person_id) REFERENCES person(id) ON DELETE CASCADE,
	FOREIGN KEY(card_id) REFERENCES pay_card(id) ON DELETE CASCADE,
	FOREIGN KEY(venmo_id) REFERENCES venmo(id) ON DELETE CASCADE,
	FOREIGN KEY(ach_id) REFERENCES ach(id) ON DELETE CASCADE
);


-- ===================
-- Relational Tables
-- ===================
CREATE TABLE apartment (
	prop_id NUMBER,
	apt VARCHAR2(5),
	square_footage NUMBER NOT NULL,
	bed_count NUMBER NOT NULL,
	bath_count NUMBER NOT NULL
		CHECK (MOD(bath_count, 0.5) = 0),
	rent NUMBER NOT NULL,
	PRIMARY KEY(prop_id, apt),
    FOREIGN KEY(prop_id) REFERENCES property(id) ON DELETE CASCADE
);


-- -------------------
-- Amenities
-- -------------------
CREATE TABLE prop_amenity (
    id NUMBER GENERATED ALWAYS AS IDENTITY,
	prop_id NUMBER NOT NULL,
	amenity VARCHAR2(255) NOT NULL,
	cost NUMBER NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(prop_id) REFERENCES property(id) ON DELETE CASCADE
);

CREATE TABLE apt_amenity (
    id NUMBER GENERATED ALWAYS AS IDENTITY,
	prop_id NUMBER NOT NULL,
	apt VARCHAR2(5) NOT NULL,
	amenity VARCHAR2(255) NOT NULL,
	cost NUMBER NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(prop_id, apt) REFERENCES apartment(prop_id, apt) ON DELETE CASCADE
);

-- Aggregates all amenities to have a unique ID in a single table
-- Adding a specific amenity (Property or apartment-specific) should trigger a row add to this table automatically
-- Only one of the [specific]_amenity_id methods should be filled, rest should be NULL
CREATE TABLE amenity (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	prop_amenity_id NUMBER DEFAULT NULL,
	apt_amenity_id NUMBER DEFAULT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(prop_amenity_id) REFERENCES prop_amenity(id) ON DELETE CASCADE,
	FOREIGN KEY(apt_amenity_id) REFERENCES apt_amenity(id) ON DELETE CASCADE
);

-- -------------------
-- Person details
-- -------------------
CREATE TABLE visited (
	person_id NUMBER,
	date_visited DATE DEFAULT CURRENT_TIMESTAMP,
	prop_id NUMBER,
	apt VARCHAR2(5),
	PRIMARY KEY(person_id, date_visited, prop_id, apt),
	FOREIGN KEY(person_id) REFERENCES person(id) ON DELETE CASCADE,
	FOREIGN KEY(prop_id, apt) REFERENCES apartment(prop_id, apt) ON DELETE CASCADE
);

CREATE TABLE prev_addr (
	person_id NUMBER,
	street_name VARCHAR2(255),
	city VARCHAR2(255) NOT NULL,
	state CHAR(2) NOT NULL
		CHECK (state like '__'),
	zipcode CHAR(5),
	PRIMARY KEY(person_id, street_name, zipcode),
	FOREIGN KEY(person_id) REFERENCES person(id) ON DELETE CASCADE
);

CREATE TABLE renter_info (
	person_id NUMBER,
	ssn CHAR(11)
		CHECK (REGEXP_LIKE(ssn, '\d{3}-\d{2}-\d{4}')),
	preferred_payment NUMBER NOT NULL,
	PRIMARY KEY(person_id),
    FOREIGN KEY(person_id) REFERENCES person(id) ON DELETE CASCADE,
	FOREIGN KEY(preferred_payment) REFERENCES payment_method(id)
);

-- -------------------
-- Lease Details
-- -------------------
CREATE TABLE lease (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	prop_id NUMBER NOT NULL,
	apt VARCHAR2(5) NOT NULL,
	start_date DATE NOT NULL,
	term_length NUMBER NOT NULL,
	rent_amount NUMBER NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(prop_id, apt) REFERENCES apartment(prop_id, apt) ON DELETE CASCADE
);

CREATE TABLE pet_on_lease (
	lease_id NUMBER,
	pet_id NUMBER,
	PRIMARY KEY(lease_id, pet_id),
	FOREIGN KEY(lease_id) REFERENCES lease(id) ON DELETE CASCADE,
	FOREIGN KEY(pet_id) REFERENCES pet(id) ON DELETE CASCADE
);

CREATE TABLE person_on_lease (
	lease_id NUMBER,
	person_id NUMBER UNIQUE, -- Only one person per lease
	PRIMARY KEY(lease_id, person_id),
	FOREIGN KEY(lease_id) REFERENCES lease(id) ON DELETE CASCADE,
	FOREIGN KEY(person_id) REFERENCES renter_info(person_id) ON DELETE CASCADE
);


-- -------------------
-- Payment Ledger
-- -------------------
CREATE TABLE lease_payment (
	lease_id NUMBER,
	date_paid DATE DEFAULT CURRENT_TIMESTAMP,
	pay_method_id NUMBER,
	pay_amt NUMBER NOT NULL,
	payer NUMBER NOT NULL,
	memo VARCHAR2(255),
	PRIMARY KEY(lease_id, date_paid),
	FOREIGN KEY(lease_id) REFERENCES lease(id) ON DELETE CASCADE,
	FOREIGN KEY(pay_method_id) REFERENCES payment_method(id),
	FOREIGN KEY(payer) REFERENCES person(id)
);

CREATE TABLE amenity_payment (
	amenity_id NUMBER,
	date_paid DATE DEFAULT CURRENT_TIMESTAMP,
	pay_method_id NUMBER,
	pay_amt NUMBER NOT NULL,
	payer NUMBER NOT NULL,
	memo VARCHAR2(255),
	PRIMARY KEY(amenity_id, date_paid),
	FOREIGN KEY(amenity_id) REFERENCES amenity(id) ON DELETE CASCADE,
	FOREIGN KEY(pay_method_id) REFERENCES payment_method(id),
	FOREIGN KEY(payer) REFERENCES person(id)
);