-- Check if a person is a resident or not, used for login

SELECT COUNT(*) FROM renter_info where person_id = ?;