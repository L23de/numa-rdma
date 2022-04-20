-- Used by NUMA to register a new visit to a property

INSERT into visited(person_id, date_visited, prop_id, apt)
VALUES(?, ?, ?, ?);