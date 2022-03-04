-- ===================
-- Primitive Tables
-- ===================
CREATE TABLE property (
	-- Autoincremented ID attribute
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	street_name VARCHAR2(255) NOT NULL,
	city VARCHAR2(255) NOT NULL,
	state VARCHAR2(255) NOT NULL,
	zipcode NUMBER(5) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE person (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	first_name VARCHAR2(255) NOT NULL,
	last_name VARCHAR2(255) NOT NULL,
	age NUMBER(3) NOT NULL,
	phone_number VARCHAR2(12) NOT NULL 
		CHECK (phone_number LIKE '###\-###\-####'),
	email VARCHAR2(255) NOT NULL 
		CHECK (email LIKE '%@%'),
	credit_score NUMBER(3) NOT NULL 
		CHECK (credit_score >= 300 AND credit_score <= 850),
	PRIMARY KEY(id)
);

CREATE TABLE pet (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	animal VARCHAR2(255) NOT NULL,
	name VARCHAR2(255),
	cost NUMBER NOT NULL,
	PRIMARY KEY(id)
);


-- -------------------
-- Payment Types
-- -------------------
-- Can be debit or credit, from the point of view of NUMA, it doesn't matter
CREATE TABLE pay_card (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	card_num VARCHAR2(19) NOT NULL,
	exp_date DATE NOT NULL,
	cvv NUMBER NOT NULL,
	pin NUMBER,
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
	acct_num VARCHAR2(17) NOT NULL,
	routing_num CHAR(9) NOT NULL,
	bank_name VARCHAR2(255) NOT NULL,
	PRIMARY KEY(id)
);

-- Aggregates all payment methods into a single table with a unique ID
-- Adding a specific payment method (Card, Venmo or ACH) should trigger a row add to this table automatically
-- Only one of the [payment]_id methods should be filled, rest should be NULL
CREATE TABLE payment_method (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	card_id NUMBER,
	venmo_id NUMBER,
	ach_id NUMBER,
	PRIMARY KEY(id),
	FOREIGN KEY(card_id) REFERENCES pay_card(id),
	FOREIGN KEY(venmo_id) REFERENCES venmo(id),
	FOREIGN KEY(ach_id) REFERENCES ach(id)
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
    FOREIGN KEY(prop_id) REFERENCES property(id)
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
	FOREIGN KEY(prop_id) REFERENCES property(id)
);

CREATE TABLE apt_amenity (
    id NUMBER GENERATED ALWAYS AS IDENTITY,
	prop_id NUMBER,
	apt VARCHAR2(5) NOT NULL,
	amenity VARCHAR2(255) NOT NULL,
	cost NUMBER NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(prop_id, apt) REFERENCES apartment(prop_id, apt)
);

-- Aggregates all amenities to have a unique ID in a single table
-- Adding a specific amenity (Property or apartment-specific) should trigger a row add to this table automatically
-- Only one of the [specific]_amenity_id methods should be filled, rest should be NULL
CREATE TABLE amenity (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	prop_amenity_id NUMBER,
	apt_amenity_id NUMBER,
	PRIMARY KEY(id),
	FOREIGN KEY(prop_amenity_id) REFERENCES prop_amenity(id),
	FOREIGN KEY(apt_amenity_id) REFERENCES apt_amenity(id)
);

-- -------------------
-- Person details
-- -------------------
CREATE TABLE visited (
	date_visited DATE,
	person_id NUMBER,
	prop_id NUMBER,
	apt VARCHAR2(5),
	PRIMARY KEY(date_visited, person_id, prop_id, apt),
	FOREIGN KEY(person_id) REFERENCES person(id),
	FOREIGN KEY(prop_id, apt) REFERENCES apartment(prop_id, apt)
);

CREATE TABLE prev_addr (
	person_id NUMBER,
	street_name VARCHAR2(255) NOT NULL,
	city VARCHAR2(255) NOT NULL,
	state VARCHAR2(255) NOT NULL,
	zipcode NUMBER(5) NOT NULL,
	PRIMARY KEY(person_id, street_name, zipcode),
	FOREIGN KEY(person_id) REFERENCES person(id)
);

CREATE TABLE renter_info (
	id NUMBER,
	ssn VARCHAR(11)
		CHECK (ssn LIKE '###\-##\-####'),
	preferred_ach NUMBER,
	preferred_card NUMBER,
	preferred_venmo NUMBER,
	PRIMARY KEY(id, ssn),
    FOREIGN KEY(id) REFERENCES person(id),
	FOREIGN KEY(preferred_ach) REFERENCES ach(id),
	FOREIGN KEY(preferred_card) REFERENCES pay_card(id),
	FOREIGN KEY(preferred_venmo) REFERENCES venmo(id)
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
	FOREIGN KEY(prop_id, apt) REFERENCES apartment(prop_id, apt)
);

CREATE TABLE pet_on_lease (
	lease_id NUMBER,
	pet_id NUMBER,
	active CHAR(1),
	PRIMARY KEY(lease_id, pet_id),
	FOREIGN KEY(lease_id) REFERENCES lease(id),
	FOREIGN KEY(pet_id) REFERENCES pet(id)
);

CREATE TABLE person_on_lease (
	lease_id NUMBER,
	person_id NUMBER,
	active CHAR(1),
	PRIMARY KEY(lease_id, person_id),
	FOREIGN KEY(lease_id) REFERENCES lease(id),
	FOREIGN KEY(person_id) REFERENCES person(id)
);


-- -------------------
-- Payment Ledger
-- -------------------
CREATE TABLE lease_payment (
	date_paid DATE NOT NULL,
	lease_id NUMBER,
	pay_method_id NUMBER,
	pay_amt NUMBER NOT NULL,
	paid_by NUMBER NOT NULL,
	memo VARCHAR2(255),
	PRIMARY KEY(date_paid, lease_id, pay_method_id),
	FOREIGN KEY(pay_method_id) REFERENCES payment_method(id),
	FOREIGN KEY(paid_by) REFERENCES person(id)
);

CREATE TABLE amenity_payment (
	date_paid DATE NOT NULL,
	amenity_id NUMBER,
	pay_method_id NUMBER,
	pay_amt NUMBER NOT NULL,
	paid_by NUMBER NOT NULL,
	memo VARCHAR2(255),
	PRIMARY KEY(date_paid, amenity_id, pay_method_id),
	FOREIGN KEY(pay_method_id) REFERENCES payment_method(id),
	FOREIGN KEY(paid_by) REFERENCES person(id)
);