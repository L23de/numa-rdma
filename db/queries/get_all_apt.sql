-- Used by NUMA to get more details about a certain apartment

SELECT *
FROM apartment
WHERE prop_id = ?;