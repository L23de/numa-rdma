-- TABLE: property
-- Schema: id,street_name,city,state,zipcode
insert into property values(1,'98 Fairview Way','Clearwater','FL','48266');
insert into property values(2,'7 Weeping Birch Junction','Fort Wayne','IN','11937');



-- TABLE: person
-- Schema: id,first_name,last_name,age,phone_number,email,credit_score
insert into person values(1,'Creight','Tomasi',20,'263-004-2303','ctomasi0@de.vu','686');
insert into person values(2,'Jethro','Watkiss',58,'102-838-4666','jwatkiss1@printfriendly.com','645');
insert into person values(3,'Chas','Vasquez',30,'928-744-5900','cvasquez2@army.mil','649');
insert into person values(4,'Cal','Medcalfe',59,'747-721-1379','cmedcalfe3@businesswire.com','382');
insert into person values(5,'Zack','Robic',58,'661-629-6058','zrobic4@cpanel.net','465');
insert into person values(6,'Frazier','Harrema',24,'141-098-5863','fharrema5@squidoo.com','839');
insert into person values(7,'Carmita','Frounks',31,'149-692-8478','cfrounks6@ucoz.ru','503');
insert into person values(8,'Paloma','Cheevers',49,'369-377-1093','pcheevers7@angelfire.com','476');
insert into person values(9,'Deni','Poleye',65,'051-094-2756','dpoleye8@bandcamp.com','812');
insert into person values(10,'Tilly','Marr',72,'854-201-7748','tmarr9@jalbum.net','609');



-- TABLE: pet
-- Schema: id,animal,name
insert into pet values(1,'Sheep','Catie');
insert into pet values(2,'Springbok','Ruy');
insert into pet values(3,'Oryx','Keely');



-- TABLE: pay_card
-- Schema: id,person_id,card_num,exp_date,cvv,pin
insert into pay_card values(1,4,'5108751761425543',to_date('06/29/2076', 'MM/DD/YYYY'),'749',NULL);
insert into pay_card values(2,2,'5108754238866224',to_date('09/25/2071', 'MM/DD/YYYY'),'969',NULL);
insert into pay_card values(3,8,'5108754774321188',to_date('11/14/2073', 'MM/DD/YYYY'),'452',NULL);



-- TABLE: venmo
-- Schema: id,person_id,handle
insert into venmo values(1,6,'@wdeely0');
insert into venmo values(2,1,'@rcollin1');



-- TABLE: ach
-- Schema: id,person_id,acct_num,routing_num,bank_name
insert into ach values(1,3,'41562034919092289','297688211','Voomm');
insert into ach values(2,4,'96902162129760854','792761205','Mita');
insert into ach values(3,2,'33770837102223050','684600700','Skiptube');
insert into ach values(4,9,'07881929068339189','457425756','Mita');
insert into ach values(5,9,'24869902901554707','773027582','Twitternation');
insert into ach values(6,5,'05621154018448546','486688975','Realcube');
insert into ach values(7,7,'02175627135382975','146161131','Yoveo');
insert into ach values(8,4,'60402615143144197','948900598','Quatz');
insert into ach values(9,5,'64887120917777080','949839912','Tagpad');
insert into ach values(10,10,'09255586945223886','262270055','Thoughtworks');



-- TABLE: apartment
-- Schema: prop_id,apt,square_footage,bed_count,bath_count,rent
insert into apartment values(2,'A316','1853',1,3,'4200');
insert into apartment values(1,'C49','1176',5,1,'1400');
insert into apartment values(2,'A179','1880',2,1,'5700');
insert into apartment values(1,'B86','1620',4,1,'3600');
insert into apartment values(1,'D275','1972',5,3,'2500');
insert into apartment values(2,'A54','1386',5,3,'2800');
insert into apartment values(1,'A253','939',5,2,'1100');
insert into apartment values(2,'A111','1335',3,1,'2100');
insert into apartment values(2,'A118','1570',5,2,'3100');
insert into apartment values(2,'C315','1899',1,2,'1800');



-- TABLE: prop_amenity
-- Schema: id,prop_id,amenity,cost
insert into prop_amenity values(DEFAULT,1,'Parking',66);
insert into prop_amenity values(DEFAULT,1,'Swimming Pool',42);
insert into prop_amenity values(DEFAULT,1,'City Shuttle',29);
insert into prop_amenity values(DEFAULT,1,'Gym',37);
insert into prop_amenity values(DEFAULT,2,'Parking',32);
insert into prop_amenity values(DEFAULT,2,'Gym',45);
insert into prop_amenity values(DEFAULT,2,'City Shuttle',30);



-- TABLE: apt_amenity
-- Schema: id,prop_id,apt,amenity,cost
insert into apt_amenity values(DEFAULT,2,'A316','Balcony',31);
insert into apt_amenity values(DEFAULT,2,'A316','In-house Laundry',33);
insert into apt_amenity values(DEFAULT,1,'C49','TV+Cable Included',34);
insert into apt_amenity values(DEFAULT,1,'C49','In-house Laundry',38);
insert into apt_amenity values(DEFAULT,2,'A179','Balcony',32);
insert into apt_amenity values(DEFAULT,2,'A179','TV+Cable Included',38);
insert into apt_amenity values(DEFAULT,2,'A179','Furnished',72);
insert into apt_amenity values(DEFAULT,1,'B86','Balcony',20);
insert into apt_amenity values(DEFAULT,1,'B86','In-house Laundry',38);
insert into apt_amenity values(DEFAULT,1,'B86','TV+Cable Included',45);
insert into apt_amenity values(DEFAULT,1,'D275','In-house Laundry',26);
insert into apt_amenity values(DEFAULT,2,'A54','TV+Cable Included',29);
insert into apt_amenity values(DEFAULT,2,'A54','Furnished',72);
insert into apt_amenity values(DEFAULT,1,'A253','TV+Cable Included',25);
insert into apt_amenity values(DEFAULT,1,'A253','Furnished',64);
insert into apt_amenity values(DEFAULT,2,'C315','In-house Laundry',33);
insert into apt_amenity values(DEFAULT,2,'C315','Furnished',70);
insert into apt_amenity values(DEFAULT,2,'C315','Balcony',26);



-- TABLE: visited
-- Schema: person_id,date_visited,prop_id,apt
insert into visited values(2,to_date('03/18/2022', 'MM/DD/YYYY'),2,'A118');
insert into visited values(2,to_date('08/18/2021', 'MM/DD/YYYY'),2,'A54');
insert into visited values(3,to_date('09/20/2021', 'MM/DD/YYYY'),2,'A111');
insert into visited values(3,to_date('03/18/2022', 'MM/DD/YYYY'),2,'A316');
insert into visited values(4,to_date('01/31/2022', 'MM/DD/YYYY'),1,'B86');
insert into visited values(4,to_date('09/19/2021', 'MM/DD/YYYY'),1,'C49');
insert into visited values(4,to_date('04/11/2021', 'MM/DD/YYYY'),1,'D275');
insert into visited values(5,to_date('03/28/2021', 'MM/DD/YYYY'),1,'C49');
insert into visited values(5,to_date('10/09/2021', 'MM/DD/YYYY'),1,'D275');
insert into visited values(5,to_date('07/09/2021', 'MM/DD/YYYY'),2,'C315');
insert into visited values(6,to_date('01/16/2022', 'MM/DD/YYYY'),1,'C49');
insert into visited values(8,to_date('11/16/2021', 'MM/DD/YYYY'),2,'C315');
insert into visited values(9,to_date('06/16/2021', 'MM/DD/YYYY'),2,'A111');



-- TABLE: prev_addr
-- Schema: person_id,street_name,city,state,zipcode
insert into prev_addr values(8,'18 Mayfield Alley','Washington','DC','92371');
insert into prev_addr values(6,'521 Bluejay Place','Portland','OR','94931');
insert into prev_addr values(1,'717 Haas Alley','Brockton','MA','83579');
insert into prev_addr values(7,'51175 Sycamore Trail','Cumming','GA','57028');
insert into prev_addr values(9,'1 Shopko Junction','El Paso','TX','83842');
insert into prev_addr values(3,'49 Corry Pass','Boulder','CO','56344');
insert into prev_addr values(9,'016 Toban Junction','Denton','TX','29602');
insert into prev_addr values(6,'59434 Lukken Crossing','Des Moines','IA','26112');
insert into prev_addr values(2,'68557 South Road','Richmond','VA','34140');
insert into prev_addr values(4,'519 Spohn Parkway','Odessa','TX','64938');
insert into prev_addr values(4,'259 Eliot Road','Silver Spring','MD','46833');
insert into prev_addr values(6,'9762 Del Sol Alley','Rockville','MD','21787');



-- TABLE: renter_info
-- Schema: person_id,ssn,preferred_payment
insert into renter_info values(4,'747-19-6366',4);
insert into renter_info values(3,'019-10-8287',14);
insert into renter_info values(5,'397-64-6966',7);
insert into renter_info values(9,'882-98-8546',6);
insert into renter_info values(2,'407-75-2958',5);



-- TABLE: lease
-- Schema: id,prop_id,apt,start_date,term_length,rent_amount
insert into lease values(1,1,'A253',to_date('03/24/2022', 'MM/DD/YYYY'),6,'1100');
insert into lease values(2,2,'C315',to_date('03/07/2022', 'MM/DD/YYYY'),24,'1800');
insert into lease values(3,1,'D275',to_date('10/09/2021', 'MM/DD/YYYY'),6,'2500');
insert into lease values(4,2,'A111',to_date('05/27/2021', 'MM/DD/YYYY'),24,'2100');
insert into lease values(5,2,'A118',to_date('11/23/2021', 'MM/DD/YYYY'),30,'3100');



-- TABLE: pet_on_lease
-- Schema: lease_id,pet_id,active
insert into pet_on_lease values(1,1,1);
insert into pet_on_lease values(4,2,1);
insert into pet_on_lease values(3,3,1);



-- TABLE: person_on_lease
-- Schema: lease_id,person_id,active
insert into person_on_lease values(1,4,1);
insert into person_on_lease values(2,9,1);
insert into person_on_lease values(3,5,1);
insert into person_on_lease values(4,3,1);
insert into person_on_lease values(5,9,1);



