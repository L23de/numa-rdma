-- TABLE: admin
-- Schema: pin
insert into admin (pin
) values('1337');



-- TABLE: property
-- Schema: street_name,city,state,zipcode
insert into property (street_name,city,state,zipcode
) values('51459 Chive Point','Allentown','PA','31787');
insert into property (street_name,city,state,zipcode
) values('35 Luster Place','Seattle','WA','13787');



-- TABLE: person
-- Schema: first_name,last_name,age,phone_number,email,credit_score
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Devlin','Gregorowicz',20,'066-582-9402','dgregorowicz0@istockphoto.com','648');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Molly','Caldwall',30,'182-192-5822','mcaldwall1@moonfruit.com','555');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Clerc','Standidge',37,'302-100-1374','cstandidge2@joomla.org','704');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Codi','Herries',47,'406-234-7644','cherries3@odnoklassniki.ru','742');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Livia','Lambkin',25,'520-790-3126','llambkin4@webs.com','794');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Rodrick','Threadgill',64,'397-948-7107','rthreadgill5@nature.com','441');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Lauryn','Pethrick',63,'815-517-0123','lpethrick6@newyorker.com','498');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Pam','Habishaw',41,'046-979-7546','phabishaw7@bloomberg.com','306');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Avie','Everson',68,'752-659-8000','aeverson8@squidoo.com','707');
insert into person (first_name,last_name,age,phone_number,email,credit_score
) values('Hermina','Blyth',19,'283-706-9469','hblyth9@hud.gov','335');



-- TABLE: pet
-- Schema: animal,pet_name
insert into pet (animal,pet_name
) values('Cat','Eddie');
insert into pet (animal,pet_name
) values('Cat','Akim');
insert into pet (animal,pet_name
) values('Parrot','Ric');



-- TABLE: pay_card
-- Schema: first_name,last_name,card_num,exp_date,cvv,pin
insert into pay_card (first_name,last_name,card_num,exp_date,cvv,pin
) values('Kevyn','Mayoh','5108754076799230','32/3204','966','6781');
insert into pay_card (first_name,last_name,card_num,exp_date,cvv,pin
) values('Matteo','Isacq','5048372799732009','04/6381','163','2611');



-- TABLE: venmo
-- Schema: handle
insert into venmo (handle
) values('@kcarriage0');
insert into venmo (handle
) values('@mantoons1');



-- TABLE: ach
-- Schema: acct_num,routing_num,bank_name
insert into ach (acct_num,routing_num,bank_name
) values('06381556560670632','576862305','TD Bank');
insert into ach (acct_num,routing_num,bank_name
) values('96590697692043733','264977341','BoA');



-- TABLE: payment_method
-- Schema: person_id,card_id,venmo_id,ach_id
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(1,1,NULL,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(8,2,NULL,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(6,NULL,1,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(1,NULL,2,NULL);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(4,NULL,NULL,1);
insert into payment_method (person_id,card_id,venmo_id,ach_id
) values(5,NULL,NULL,2);



-- TABLE: apartment
-- Schema: prop_id,apt,square_footage,bed_count,bath_count,rent
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'C103','878',3,'1.5','1900');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'A337','1536',2,'1.5','3600');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'B342','1105',3,'1.5','1300');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'C365','1249',1,'3.5','3000');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'B75','997',1,'1.5','2400');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'D300','1563',4,'1.5','3900');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'A433','1796',1,'2.5','4600');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'D376','884',4,'2.5','1100');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(2,'A445','1425',5,'2.5','4100');
insert into apartment (prop_id,apt,square_footage,bed_count,bath_count,rent
) values(1,'A71','2016',2,'2.5','6000');



-- TABLE: prop_amenity
-- Schema: prop_id,amenity,cost
insert into prop_amenity (prop_id,amenity,cost
) values(1,'Swimming Pool',44);
insert into prop_amenity (prop_id,amenity,cost
) values(2,'Gym',32);
insert into prop_amenity (prop_id,amenity,cost
) values(2,'City Shuttle',28);



-- TABLE: apt_amenity
-- Schema: prop_id,apt,amenity,cost
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A337','Furnished',51);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B342','In-house Laundry',38);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B342','Furnished',74);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'B342','TV+Cable Included',49);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'C365','TV+Cable Included',42);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'D300','TV+Cable Included',29);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'D300','Balcony',40);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(1,'D300','In-house Laundry',32);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'D376','TV+Cable Included',49);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'D376','Balcony',33);
insert into apt_amenity (prop_id,apt,amenity,cost
) values(2,'A445','In-house Laundry',38);



-- TABLE: visited
-- Schema: person_id,date_visited,prop_id,apt
insert into visited (person_id,date_visited,prop_id,apt
) values(1,to_date('10/29/2021', 'MM/DD/YYYY'),2,'A445');
insert into visited (person_id,date_visited,prop_id,apt
) values(2,to_date('01/25/2022', 'MM/DD/YYYY'),1,'C365');
insert into visited (person_id,date_visited,prop_id,apt
) values(4,to_date('05/15/2021', 'MM/DD/YYYY'),2,'A337');
insert into visited (person_id,date_visited,prop_id,apt
) values(5,to_date('05/30/2021', 'MM/DD/YYYY'),1,'B75');
insert into visited (person_id,date_visited,prop_id,apt
) values(5,to_date('02/08/2022', 'MM/DD/YYYY'),2,'A337');
insert into visited (person_id,date_visited,prop_id,apt
) values(6,to_date('06/20/2021', 'MM/DD/YYYY'),2,'D376');
insert into visited (person_id,date_visited,prop_id,apt
) values(6,to_date('12/18/2021', 'MM/DD/YYYY'),1,'B342');
insert into visited (person_id,date_visited,prop_id,apt
) values(7,to_date('07/10/2021', 'MM/DD/YYYY'),2,'D376');
insert into visited (person_id,date_visited,prop_id,apt
) values(7,to_date('09/26/2021', 'MM/DD/YYYY'),2,'A337');
insert into visited (person_id,date_visited,prop_id,apt
) values(7,to_date('10/28/2021', 'MM/DD/YYYY'),2,'A445');
insert into visited (person_id,date_visited,prop_id,apt
) values(8,to_date('02/11/2022', 'MM/DD/YYYY'),1,'B342');
insert into visited (person_id,date_visited,prop_id,apt
) values(8,to_date('10/30/2021', 'MM/DD/YYYY'),2,'A433');
insert into visited (person_id,date_visited,prop_id,apt
) values(8,to_date('06/22/2021', 'MM/DD/YYYY'),2,'D376');
insert into visited (person_id,date_visited,prop_id,apt
) values(9,to_date('07/25/2021', 'MM/DD/YYYY'),1,'A71');
insert into visited (person_id,date_visited,prop_id,apt
) values(10,to_date('03/13/2022', 'MM/DD/YYYY'),1,'A71');



-- TABLE: prev_addr
-- Schema: person_id,street_name,city,state,zipcode
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(10,'60 Macpherson Trail','El Paso','TX','69429');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(5,'785 Oak Valley Place','Boston','MA','20075');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(4,'36631 Basil Junction','Detroit','MI','90014');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(2,'1808 Service Avenue','Tucson','AZ','47692');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(7,'44 Esker Street','Boston','MA','18190');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(8,'229 La Follette Way','Sacramento','CA','63697');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(2,'46443 Summer Ridge Terrace','Dallas','TX','93722');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(9,'36 Arkansas Point','Hyattsville','MD','70139');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(3,'1 Hermina Avenue','Torrance','CA','26764');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(1,'29 Lawn Terrace','Fort Wayne','IN','76368');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(7,'830 Rowland Road','Billings','MT','71641');
insert into prev_addr (person_id,street_name,city,state,zipcode
) values(10,'9385 Cambridge Junction','Long Beach','CA','07986');



-- TABLE: renter_info
-- Schema: person_id,ssn,preferred_payment
insert into renter_info (person_id,ssn,preferred_payment
) values(2,'597-83-1351',2);
insert into renter_info (person_id,ssn,preferred_payment
) values(8,'650-72-7933',6);
insert into renter_info (person_id,ssn,preferred_payment
) values(1,'754-13-3580',3);
insert into renter_info (person_id,ssn,preferred_payment
) values(8,'735-53-4041',4);
insert into renter_info (person_id,ssn,preferred_payment
) values(2,'880-54-6772',4);



-- TABLE: lease
-- Schema: prop_id,apt,start_date,term_length,rent_amount
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(1,'B75',to_date('11/18/2021', 'MM/DD/YYYY'),18,'2400');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(2,'A445',to_date('07/28/2021', 'MM/DD/YYYY'),24,'4100');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(1,'A71',to_date('08/04/2021', 'MM/DD/YYYY'),30,'6000');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(2,'C103',to_date('10/17/2021', 'MM/DD/YYYY'),18,'1900');
insert into lease (prop_id,apt,start_date,term_length,rent_amount
) values(2,'A337',to_date('08/04/2021', 'MM/DD/YYYY'),30,'3600');



-- TABLE: pet_on_lease
-- Schema: lease_id,pet_id
insert into pet_on_lease (lease_id,pet_id
) values(3,1);
insert into pet_on_lease (lease_id,pet_id
) values(4,2);
insert into pet_on_lease (lease_id,pet_id
) values(5,3);



-- TABLE: person_on_lease
-- Schema: lease_id,person_id
insert into person_on_lease (lease_id,person_id
) values(1,8);
insert into person_on_lease (lease_id,person_id
) values(2,1);
insert into person_on_lease (lease_id,person_id
) values(3,2);
insert into person_on_lease (lease_id,person_id
) values(4,2);
insert into person_on_lease (lease_id,person_id
) values(5,8);



COMMIT;
