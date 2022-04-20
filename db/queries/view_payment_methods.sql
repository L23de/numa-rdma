-- Venmo Given Person ID
select payment_method.id, handle 
from payment_method join venmo on venmo_id = venmo.id 
where person_id = ?;

-- ACH Given Person ID
select payment_method.id, bank_name, acct_num, routing_num 
from payment_method join ach on ach_id = ach.id 
where person_id = ?;

-- Card Given Person ID
select payment_method.id, first_name, last_name, card_num, exp_date, cvv, pin 
from payment_method join pay_card on card_id = pay_card.id 
where person_id = ?;