create or replace PROCEDURE sign_lease (
    personId IN payment_method.person_id%type,
    propId IN lease.prop_id%type,
    aptId IN lease.apt%type,
    termLength IN lease.term_length%type,
    ssn IN renter_info.ssn%type,
    success OUT number 
) IS
    leaseId lease.id%type;
BEGIN
    leaseId := sign_lease_helper(propId, aptId, termLength);
    dbms_output.put_line(leaseId);

    if leaseId > 0 then
        INSERT INTO renter_info(person_id, ssn) VALUES(personId, ssn);
        commit;
        INSERT INTO person_on_lease VALUES(leaseId, personId);
        commit;
        success := 0;
        return;
    end if;

    success := -1;
    return;
END;


