-- By Lease ID
select 
	prop_id,
	street_name,
	apt,
	city,
	state,
	zipcode,
	square_footage,
	bed_count,
	bath_count,
	start_date,
	term_length,
	rent
from (lease join apartment on lease.prop_id = apartment.prop_id and lease.apt = apartment.apt) join property on lease.prop_id = property.id;


-- Get Prop Amenities
select amenity, cost 
from prop_amenity 
where prop_id = ?;


-- Get Apt Amenities
select amenity, cost 
from apt_amenity 
where prop_id = ? and apt = ?;


-- Get Roommates
select first_name, last_name 
from person_on_lease join person on person_on_lease.person_id = person.id
where lease_id = ? and person_id <> ?;


-- Get Pets
select animal, pet_name
from pet_on_lease join pet on pet_on_lease.pet_id = pet.id
where lease_id = ?;
