CREATE OR REPLACE TYPE amen_pay_row as OBJECT(
	amen_id number,
	amenity VARCHAR2(255),
	cost number,
	months_outstanding number
);

