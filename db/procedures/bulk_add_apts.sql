-- Used by NUMA to add apartments for a new property
-- Do last

CREATE OR REPLACE PROCEDURE bulk_add (
	propId property.id%type,
	maxLetter char,
	maxNumber number,
	
)