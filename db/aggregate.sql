-- TABLE: admin
-- Schema: pin
insert into admin (pin
) values('1337');



-- TABLE: property
-- Schema: street_name,city,state,zipcode
insert into property (street_name,city,state,zipcode
) values('668 Northland Park','Lincoln','NE','96426');
insert into property (street_name,city,state,zipcode
) values('6 Vermont Parkway','Aiken','SC','97265');



-- TABLE: person
-- Schema: first_name,last_name,age,phone_number,email,credit_score
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Hugibert','Checo',67,'226-332-9025','hcheco0@redcross.org','718');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Raddie','Ludee',31,'496-015-9160','rludee1@ca.gov','511');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Lisabeth','Craythorne',40,'946-282-9151','lcraythorne2@senate.gov','757');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Chalmers','Belison',28,'140-720-6686','cbelison3@engadget.com','304');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Caprice','Monkman',48,'116-575-5172','cmonkman4@gov.uk','346');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Devora','Shearman',18,'168-283-6477','dshearman5@amazon.de','540');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Paola','Reaper',72,'445-385-1357','preaper6@last.fm','425');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Son','Twentyman',38,'615-403-2269','stwentyman7@soup.io','485');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Alec','Sahlstrom',38,'166-594-2804','asahlstrom8@amazon.de','490');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Paulette','Condliffe',70,'824-010-5646','pcondliffe9@blogs.com','813');



-- TABLE: pet
-- Schema: animal,pet_name
insert into pet (animal,pet_name
) values('Cat','Lana');
insert into pet (animal,pet_name
) values('Parrot','Dania');
insert into pet (animal,pet_name
) values('Cat','Layla');



-- TABLE: pay_card
-- Schema: first_name,last_name,card_num,exp_date,cvv,pin
insert into pay_card (first_name,last_name,card_num,exp_date,cvv,pin
) values('Montgomery','Witham','5048373738896780',to_date('05/10/2091', 'MM/DD/YYYY'),'685',NULL);
insert into pay_card (first_name,last_name,card_num,exp_date,cvv,pin
) values('Dannye','Dunnan','5048379414406638',to_date('05/08/2065', 'MM/DD/YYYY'),'843','1441');



-- TABLE: venmo
-- Schema: handle
insert into venmo (handle
) values('@srabier0');
insert into venmo (handle
) values('@ktimby1');



-- TABLE: ach
-- Schema: acct_num,routing_num,bank_name
insert into ach (acct_num,routing_num,bank_name
) values('84024046305047214','242745717','Wells Fargo');
insert into ach (acct_num,routing_num,bank_name
) values('11041194166538804','472095935','Barclays');



-- TABLE: payment_method
-- Schema: person_id,card_id,venmo_id,ach_id
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(8,1,NULL,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(8,2,NULL,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(1,NULL,1,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(2,NULL,2,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(7,NULL,NULL,1);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(3,NULL,NULL,2);



-- TABLE: apartment
-- Schema: prop_id,apt,square_footage,bed_count,bath_count,rent
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'A360','1788',2,'2.5','1900');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'A6','863',2,'1.5','2100');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'A69','1059',5,1,'1500');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'C55','2065',4,1,'4000');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'B426','827',3,'1.5','2200');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'A361','2080',2,3,'3000');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'D347','1307',1,1,'3300');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'A58','1217',3,'2.5','3100');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'C374','1821',1,1,'4300');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'C308','1457',5,2,'1700');



-- TABLE: prop_amenity
-- Schema: prop_id,amenity,cost
insert into prop_amenity (prop_id,amenity,cost
) values(1,'Swimming Pool',38);
insert into prop_amenity (prop_id,amenity,cost
) values(1,'Gym',44);
insert into prop_amenity (prop_id,amenity,cost
) values(1,'City Shuttle',13);
insert into prop_amenity (prop_id,amenity,cost
) values(1,'Parking',60);
insert into prop_amenity (prop_id,amenity,cost
) values(2,'Swimming Pool',50);



-- TABLE: apt_amenity
-- Schema: prop_id,apt,amenity,cost
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A360','Furnished',88);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A6','Balcony',25);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A6','In-house Laundry',40);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A6','TV+Cable Included',28);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A69','Balcony',33);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A69','In-house Laundry',31);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A69','TV+Cable Included',21);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'C55','Furnished',58);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'C55','Balcony',21);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'C55','TV+Cable Included',38);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A58','TV+Cable Included',34);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A58','Balcony',28);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'C308','Furnished',64);



-- TABLE: visited
-- Schema: person_id,date_visited,prop_id,apt
insert into visited (person_id,date_visited,prop_id,apt
) values(1,to_date('01/22/2022', 'MM/DD/YYYY'),1,'C374');
insert into visited (person_id,date_visited,prop_id,apt
) values(1,to_date('10/13/2021', 'MM/DD/YYYY'),2,'A58');
insert into visited (person_id,date_visited,prop_id,apt
) values(3,to_date('01/03/2022', 'MM/DD/YYYY'),2,'A58');
insert into visited (person_id,date_visited,prop_id,apt
) values(3,to_date('10/16/2021', 'MM/DD/YYYY'),1,'C55');
insert into visited (person_id,date_visited,prop_id,apt
) values(3,to_date('01/09/2022', 'MM/DD/YYYY'),1,'B426');
insert into visited (person_id,date_visited,prop_id,apt
) values(5,to_date('06/20/2021', 'MM/DD/YYYY'),1,'C374');
insert into visited (person_id,date_visited,prop_id,apt
) values(6,to_date('01/08/2022', 'MM/DD/YYYY'),2,'C308');
insert into visited (person_id,date_visited,prop_id,apt
) values(7,to_date('11/13/2021', 'MM/DD/YYYY'),1,'C55');
insert into visited (person_id,date_visited,prop_id,apt
) values(7,to_date('11/16/2021', 'MM/DD/YYYY'),2,'C308');
insert into visited (person_id,date_visited,prop_id,apt
) values(7,to_date('07/27/2021', 'MM/DD/YYYY'),2,'A58');
insert into visited (person_id,date_visited,prop_id,apt
) values(8,to_date('08/13/2021', 'MM/DD/YYYY'),2,'A6');
insert into visited (person_id,date_visited,prop_id,apt
) values(8,to_date('08/24/2021', 'MM/DD/YYYY'),2,'D347');
insert into visited (person_id,date_visited,prop_id,apt
) values(9,to_date('05/08/2021', 'MM/DD/YYYY'),2,'C308');
insert into visited (person_id,date_visited,prop_id,apt
) values(9,to_date('01/05/2022', 'MM/DD/YYYY'),2,'A69');
insert into visited (person_id,date_visited,prop_id,apt
) values(9,to_date('08/17/2021', 'MM/DD/YYYY'),1,'A361');
insert into visited (person_id,date_visited,prop_id,apt
) values(10,to_date('03/17/2022', 'MM/DD/YYYY'),2,'A6');
insert into visited (person_id,date_visited,prop_id,apt
) values(10,to_date('11/16/2021', 'MM/DD/YYYY'),2,'C308');



-- TABLE: prev_addr
-- Schema: person_id,street_name,city,state,zipcode
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(1,'09 Utah Alley','New York City','NY','18931');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(3,'4 Bluejay Avenue','Jamaica','NY','48044');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(5,'032 Sachs Crossing','Houston','TX','54858');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(4,'8597 Sherman Court','Houston','TX','33047');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(3,'488 Rutledge Hill','Amarillo','TX','53016');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(2,'37 Monica Way','Little Rock','AR','64966');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(7,'8 Prentice Point','Rochester','MN','15345');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(2,'7729 Meadow Vale Court','Syracuse','NY','13411');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(7,'87149 Duke Circle','Tacoma','WA','23923');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(1,'25 Sundown Parkway','Santa Monica','CA','29201');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(2,'231 Atwood Alley','Nashville','TN','30416');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(7,'777 Delaware Crossing','Richmond','VA','72873');



-- TABLE: renter_info
-- Schema: person_id,ssn,preferred_payment
insert into renter_info (person_id,ssn,preferred_payment
) values(10,'718-47-0718',3);
insert into renter_info (person_id,ssn,preferred_payment
) values(9,'753-98-7069',4);
insert into renter_info (person_id,ssn,preferred_payment
) values(7,'155-72-1193',2);
insert into renter_info (person_id,ssn,preferred_payment
) values(10,'270-52-1085',1);
insert into renter_info (person_id,ssn,preferred_payment
) values(10,'359-66-6822',4);



-- TABLE: lease
-- Schema: prop_id,apt,start_date,term_length,rent_amount
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(1,'A361',to_date('06/01/2021', 'MM/DD/YYYY'),12,'3000');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(2,'C308',to_date('11/16/2021', 'MM/DD/YYYY'),18,'1700');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(2,'A58',to_date('11/19/2021', 'MM/DD/YYYY'),30,'3100');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(1,'C374',to_date('05/17/2021', 'MM/DD/YYYY'),6,'4300');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(2,'A69',to_date('11/21/2021', 'MM/DD/YYYY'),18,'1500');



-- TABLE: pet_on_lease
-- Schema: lease_id,pet_id
insert into pet_on_lease (lease_id,pet_id
) values(5,1);
insert into pet_on_lease (lease_id,pet_id
) values(3,2);
insert into pet_on_lease (lease_id,pet_id
) values(4,3);



-- TABLE: person_on_lease
-- Schema: lease_id,person_id
insert into person_on_lease (lease_id,person_id
) values(1,1);
insert into person_on_lease (lease_id,person_id
) values(2,1);
insert into person_on_lease (lease_id,person_id
) values(3,9);
insert into person_on_lease (lease_id,person_id
) values(4,1);
insert into person_on_lease (lease_id,person_id
) values(5,7);



COMMIT;
