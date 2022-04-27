CREATE OR REPLACE TYPE lease_pay_row as OBJECT(
	lease_id number,
	prop_id number,
	apt varchar2(5),
	start_date date, 
	term_length number, 
	rent_amount number, 
	months_outstanding VARCHAR2(2)
);

