-- TABLE: admin
-- Schema: pin
insert into admin (pin
) values('1337');



-- TABLE: property
-- Schema: street_name,city,state,zipcode
insert into property (street_name,city,state,zipcode
) values('4107 Evergreen Terrace','Laurel','MD','38934');
insert into property (street_name,city,state,zipcode
) values('8 Kedzie Pass','Huntington','WV','89541');



-- TABLE: person
-- Schema: first_name,last_name,age,phone_number,email,credit_score
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Keven','Haresnaip',62,'734-309-9756','kharesnaip0@symantec.com','839');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Dolph','Porker',41,'873-657-3429','dporker1@pinterest.com','456');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Pail','Hizir',30,'234-499-2712','phizir2@youku.com','756');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Esra','Gowrie',23,'673-030-4088','egowrie3@meetup.com','409');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Nickola','Woosnam',56,'729-084-8887','nwoosnam4@google.es','838');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Devina','Hawkeswood',54,'366-058-9031','dhawkeswood5@usgs.gov','696');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Amandi','Finnis',45,'344-046-8713','afinnis6@accuweather.com','591');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Osborne','Padefield',27,'311-653-0690','opadefield7@yellowpages.com','836');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Rodger','Blaxeland',20,'287-593-1810','rblaxeland8@xrea.com','682');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Modesta','Antoniou',50,'898-774-6287','mantoniou9@google.com','816');



-- TABLE: pet
-- Schema: animal,pet_name
insert into pet (animal,pet_name
) values('Parrot','Dal');
insert into pet (animal,pet_name
) values('Fish','Andria');
insert into pet (animal,pet_name
) values('Fish','Trip');



-- TABLE: pay_card
-- Schema: first_name,last_name,card_num,exp_date,cvv,pin
insert into pay_card (first_name,last_name,card_num,exp_date,cvv,pin
) values('Rudy','Fante','5048370584957294','50/5522','646',NULL);
insert into pay_card (first_name,last_name,card_num,exp_date,cvv,pin
) values('Marnia','Mansford','5108759345991526','58/8654','758',NULL);



-- TABLE: venmo
-- Schema: handle
insert into venmo (handle
) values('@jmatysiak0');
insert into venmo (handle
) values('@lblenkensop1');



-- TABLE: ach
-- Schema: acct_num,routing_num,bank_name
insert into ach (acct_num,routing_num,bank_name
) values('98520980505477001','417581764','Chase');
insert into ach (acct_num,routing_num,bank_name
) values('63441178839518856','777728260','Citi');



-- TABLE: payment_method
-- Schema: person_id,card_id,venmo_id,ach_id
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(1,1,NULL,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(7,2,NULL,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(7,NULL,1,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(8,NULL,2,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(2,NULL,NULL,1);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(5,NULL,NULL,2);



-- TABLE: apartment
-- Schema: prop_id,apt,square_footage,bed_count,bath_count,rent
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'C186','1577',5,'3.5','4500');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'C382','2021',5,3,'4800');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'C8','1305',4,'1.5','2600');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'B75','1475',2,'2.5','2500');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'B391','930',3,'3.5','1300');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'B364','1079',5,'3.5','1500');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'D424','1664',1,'2.5','5100');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'C7','1993',4,'2.5','2600');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'A88','1201',5,3,'1600');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'C20','2006',4,'1.5','5600');



-- TABLE: prop_amenity
-- Schema: prop_id,amenity,cost
insert into prop_amenity (prop_id,amenity,cost
) values(1,'Swimming Pool',33);
insert into prop_amenity (prop_id,amenity,cost
) values(1,'Gym',21);
insert into prop_amenity (prop_id,amenity,cost
) values(2,'Parking',70);
insert into prop_amenity (prop_id,amenity,cost
) values(2,'Swimming Pool',11);
insert into prop_amenity (prop_id,amenity,cost
) values(2,'City Shuttle',30);



-- TABLE: apt_amenity
-- Schema: prop_id,apt,amenity,cost
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'C186','Balcony',27);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'C186','TV+Cable Included',45);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'C186','In-house Laundry',35);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'C382','Balcony',30);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'C8','Furnished',78);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'C8','Balcony',28);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B75','TV+Cable Included',31);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B75','Balcony',22);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B391','In-house Laundry',31);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B391','Furnished',63);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B391','Balcony',25);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B364','In-house Laundry',25);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B364','TV+Cable Included',47);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B364','Furnished',50);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'D424','Furnished',88);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'D424','TV+Cable Included',30);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'D424','Balcony',29);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'C7','Balcony',23);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'C20','Balcony',32);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'C20','In-house Laundry',32);



-- TABLE: visited
-- Schema: person_id,date_visited,prop_id,apt
insert into visited (person_id,date_visited,prop_id,apt
) values(1,to_date('01/20/2022', 'MM/DD/YYYY'),1,'B391');
insert into visited (person_id,date_visited,prop_id,apt
) values(1,to_date('12/09/2021', 'MM/DD/YYYY'),2,'C8');
insert into visited (person_id,date_visited,prop_id,apt
) values(2,to_date('07/04/2021', 'MM/DD/YYYY'),2,'C8');
insert into visited (person_id,date_visited,prop_id,apt
) values(3,to_date('01/07/2022', 'MM/DD/YYYY'),1,'A88');
insert into visited (person_id,date_visited,prop_id,apt
) values(3,to_date('04/18/2021', 'MM/DD/YYYY'),2,'C7');
insert into visited (person_id,date_visited,prop_id,apt
) values(3,to_date('04/25/2021', 'MM/DD/YYYY'),2,'C382');
insert into visited (person_id,date_visited,prop_id,apt
) values(4,to_date('10/25/2021', 'MM/DD/YYYY'),2,'C7');
insert into visited (person_id,date_visited,prop_id,apt
) values(4,to_date('12/08/2021', 'MM/DD/YYYY'),2,'C8');
insert into visited (person_id,date_visited,prop_id,apt
) values(4,to_date('01/02/2022', 'MM/DD/YYYY'),1,'B75');
insert into visited (person_id,date_visited,prop_id,apt
) values(5,to_date('08/10/2021', 'MM/DD/YYYY'),1,'B364');
insert into visited (person_id,date_visited,prop_id,apt
) values(6,to_date('02/16/2022', 'MM/DD/YYYY'),1,'B391');
insert into visited (person_id,date_visited,prop_id,apt
) values(6,to_date('03/15/2022', 'MM/DD/YYYY'),1,'B75');
insert into visited (person_id,date_visited,prop_id,apt
) values(7,to_date('10/02/2021', 'MM/DD/YYYY'),1,'B391');
insert into visited (person_id,date_visited,prop_id,apt
) values(7,to_date('03/16/2022', 'MM/DD/YYYY'),1,'C186');
insert into visited (person_id,date_visited,prop_id,apt
) values(9,to_date('08/22/2021', 'MM/DD/YYYY'),1,'B75');



-- TABLE: renter_info
-- Schema: person_id,ssn,preferred_payment
insert into renter_info (person_id,ssn,preferred_payment
) values(10,'574-81-9236',2);
insert into renter_info (person_id,ssn,preferred_payment
) values(8,'120-19-8737',4);
insert into renter_info (person_id,ssn,preferred_payment
) values(8,'285-60-1054',3);
insert into renter_info (person_id,ssn,preferred_payment
) values(9,'173-60-1061',1);
insert into renter_info (person_id,ssn,preferred_payment
) values(9,'318-47-0126',6);



-- TABLE: lease
-- Schema: prop_id,apt,start_date,term_length,rent_amount
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(1,'A88',to_date('03/18/2022', 'MM/DD/YYYY'),48,'1600');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(1,'B391',to_date('11/16/2021', 'MM/DD/YYYY'),60,'1300');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(2,'C7',to_date('12/18/2021', 'MM/DD/YYYY'),12,'2600');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(2,'C8',to_date('10/10/2021', 'MM/DD/YYYY'),48,'2600');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(1,'B75',to_date('06/12/2021', 'MM/DD/YYYY'),12,'2500');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(2,'C382',to_date('10/07/2021', 'MM/DD/YYYY'),30,'4800');



-- TABLE: pet_on_lease
-- Schema: lease_id,pet_id
insert into pet_on_lease (lease_id,pet_id
) values(3,1);
insert into pet_on_lease (lease_id,pet_id
) values(1,2);
insert into pet_on_lease (lease_id,pet_id
) values(4,3);



-- TABLE: person_on_lease
-- Schema: lease_id,person_id
insert into person_on_lease (lease_id,person_id
) values(1,8);
insert into person_on_lease (lease_id,person_id
) values(2,9);
insert into person_on_lease (lease_id,person_id
) values(3,8);
insert into person_on_lease (lease_id,person_id
) values(4,1);
insert into person_on_lease (lease_id,person_id
) values(5,9);



COMMIT;
