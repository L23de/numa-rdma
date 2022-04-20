-- Used by NUMA to end prematurely or extend a person's lease

UPDATE lease
SET term_length = ?
WHERE id = ?;