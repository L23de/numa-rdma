-- Used to get aggregate data about the leases
-- Group by prop_id (Avg term length and count of each property)
-- Group by term_length (Total # of tenants with the same term length)
-- Group by prop_id, term_length (Total # of tenants w/ same term length in the same property)
-- Group by nothing (Average term and total tenants)

SELECT prop_id, avg(term_length), count(person_id) 
FROM lease join person_on_lease on lease.id = person_on_lease.lease_id 
GROUP BY cube(prop_id, term_length);