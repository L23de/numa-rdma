-- Used to register a new person into the NUMA system
-- For the purpose of a new leasee or a new visitor of one of NUMA's properties

INSERT into person(first_name, last_name, age, phone_number, email, credit_score)
VALUES(?, ?, ?, ?, ?, ?);