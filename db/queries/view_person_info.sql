-- Given Person ID
select 
	person.id as id,
	first_name || ' ' || last_name as name,
	ssn,
	age,
	phone_number,
	email,
	credit_score,
	apt,
	lease_id
from 
	(((person 
		left outer join renter_info on renter_info.person_id = person.id)  		
		natural left outer join person_on_lease) 
		left outer join lease on lease_id = lease.id) 
	natural left outer join apartment 
where person.id = ?;


-- Given First/Last Name
select 
	person.id as id,
	first_name || ' ' || last_name as name,
	ssn,
	age,
	phone_number,
	email,
	credit_score,
	apt,
	lease_id
from 
	(((person 
		left outer join renter_info on renter_info.person_id = person.id)  		
		natural left outer join person_on_lease) 
		left outer join lease on lease_id = lease.id) 
	natural left outer join apartment 
where first_name = ? or last_name = ?;


-- Given First Name ONLY
select 
	person.id as id,
	first_name || ' ' || last_name as name,
	ssn,
	age,
	phone_number,
	email,
	credit_score,
	apt,
	lease_id
from 
	(((person 
		left outer join renter_info on renter_info.person_id = person.id)  		
		natural left outer join person_on_lease) 
		left outer join lease on lease_id = lease.id) 
	natural left outer join apartment 
where first_name = ?;