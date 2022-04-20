-- The prop_id and apt fields should come from the Java program, first ensuring that it is a valid apartment (Lease is still alive), view_lease_to_pay should be run before this.

-- Selecting prop amenities to pay for
SELECT amenity.id, amenity, cost
FROM 
	(amenity left outer join amenity_payment on amenity.id = amenity_payment.amenity_id) 
	join prop_amenity on amenity.prop_amenity_id = prop_amenity.id
WHERE
	prop_id = ? and
	(TO_CHAR(date_paid, 'YYYYMM') = TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMM') or TO_CHAR(date_paid, 'YYYYMM') is null);

-- Selecting apt amenities to pay for
SELECT amenity.id, amenity, cost 
FROM 
	(amenity left outer join amenity_payment on amenity.id = amenity_payment.amenity_id) 
	join apt_amenity on amenity.apt_amenity_id = apt_amenity.id
WHERE
	prop_id = ? and apt = ?
	(TO_CHAR(date_paid, 'YYYYMM') = TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMM') or TO_CHAR(date_paid, 'YYYYMM') is null);