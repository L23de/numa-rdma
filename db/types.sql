CREATE OR REPLACE TYPE amen_pay_row as OBJECT(
	amen_id number,
	amenity VARCHAR2(255),
	cost number,
	months_outstanding number
);

CREATE OR REPLACE TYPE amen_pay_table AS
	TABLE OF amen_pay_row;

CREATE OR REPLACE TYPE lease_pay_row as OBJECT(
	lease_id number,
	prop_id number,
	apt varchar2(5),
	start_date date, 
	term_length number, 
	rent_amount number, 
	months_outstanding VARCHAR2(2)
);

CREATE OR REPLACE TYPE lease_pay_table AS
	TABLE OF lease_pay_row;

