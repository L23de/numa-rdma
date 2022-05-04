create or replace PROCEDURE add_pet (
		animal pet.animal%type,
		pet_name pet.pet_name%type,
		lease_id lease.id%type
	) IS
		pet_id pet.id%type;
	BEGIN
		INSERT INTO pet(animal, pet_name) VALUES(animal, pet_name);
        commit;
		SELECT MAX(id) into pet_id from pet;
		INSERT INTO pet_on_lease(lease_id, pet_id) VALUES(lease_id, pet_id);
        commit;
	END;


	