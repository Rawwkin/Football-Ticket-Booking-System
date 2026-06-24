--Query : 1 
select match_id , fixture, base_ticket_price from  matches 
where tournament_category = 'Champions League'
and match_status = 'Available'

--Query : 2
select user_id,full_name,email from users
where full_name like 'Tanvir%'
or full_name ilike '%haque%'

--Query : 3 (Coalcase)
select booking_id, user_id, match_id,
 coalesce(payment_status,'Action Required') as systematic_status
 from bookings where payment_status is null; 
  
select booking_id, user_id, match_id,
case 
   when payment_status is null then 'Action Required'
 end as systematic_status
from bookings where payment_status is null;

--Query : 4
select booking_id,
     full_name,
     fixture,
     total_cost 
from bookings
inner join users on users.user_id = bookings.user_id
inner join matches on matches.match_id = bookings.match_id;
------****------
select booking_id, full_name, fixture, total_cost
from bookings
left join users on users.user_id = bookings.user_id
left join matches on matches.match_id = bookings.match_id;


--Query : 5
select 
    u.user_id,
    full_name,
    booking_id
from users u
full join bookings b on u.user_id = b.user_id


--Query : 6
select booking_id, match_id, total_cost from bookings
where total_cost > (
    select avg(total_cost) from bookings
)

--Query : 7
select match_id, fixture, base_ticket_price from matches
  where base_ticket_price < (
    select max(base_ticket_price) from matches
)
order by base_ticket_price desc
limit 2
-------------
select match_id, fixture, base_ticket_price from matches
order by base_ticket_price desc
limit 2
offset 1


