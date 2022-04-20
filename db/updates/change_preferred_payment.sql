-- Used to update a renter's preferred payment method

UPDATE renter_info
SET preferred_payment = ?
WHERE person_id = ?;