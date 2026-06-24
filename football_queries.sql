-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup Template
-- DESCRIPTION: Pseudo-DDL Template for Table Creation & Data Insertion
-- INSTRUCTIONS: Replace 'TYPE' and the constraint placeholders with your own
--               actual data types, relational keys, and check criteria.
-- =========================================================================

-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
--user table--
create table users(
  user_id serial primary key,
  full_name varchar(255) not null,
  email varchar(255) unique not null,
  role varchar(255),
  phone_number varchar(255) default null
);
--constraint role check--
alter table users
add constraint role_check 
check(role in ('Ticket Manager', 'Football Fan'));  
    
    -- Write your constraint to make 'user_id' the Primary Key
    -- Write your constraint to ensure 'email' values are never duplicated
    -- Write your check constraint to restrict 'role' to specific allowed strings


-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
--match table--
create table matches(
  match_id serial primary key,
  fixture varchar(255) not null,
  tournament_category varchar(255) not null,
  base_ticket_price numeric(10,2) ,
  match_status varchar(255) not null
);
---constraint restrict 'match status' ---
alter table matches
add constraint match_status_chk 
check( match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'));

---constraint check 'negative price'---
alter table matches
  add constraint base_price_neg
  check(base_ticket_price >= 0);
    -- Write your constraint to make 'match_id' the Primary Key
    -- Write your check constraint to prevent negative ticket prices
    -- Write your check constraint to restrict 'match_status' values


-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
--booking table--
create table bookings(
  booking_id int primary key,
  user_id int references users(user_id) on delete cascade,
  match_id int references matches(match_id)on delete cascade,
  seat_number varchar(255) not null,
  payment_status varchar(255),
  total_cost numeric(10,2)
);
  
----constraint 'total cost' no neg----
alter table bookings
  add constraint total_cost_neg
  check(total_cost >= 0) ;

----constraint 'payment status'-----
alter table bookings
add constraint payment_status_chk 
check( payment_status in ('Pending', 'Confirmed', 'Cancelled', 'Refunded')); 
    
    -- Write your constraint to make 'booking_id' the Primary Key
    -- Write your Foreign Key constraint linking 'user_id' to the Users table
    -- Write your Foreign Key constraint linking 'match_id' to the Matches table
    -- Write your check constraint to ensure 'total_cost' is non-negative
    -- Write your check constraint to restrict 'payment_status' values



-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
insert into users(full_name, email, role, phone_number) 
values 
  ('Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
  ('Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
  ('Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
  ('Jannat Ara', 'jannat@mail.com', 'Football Fan', null );

ALTER SEQUENCE users_user_id_seq RESTART WITH 1;

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
insert into matches(fixture, tournament_category, base_ticket_price, match_status)
values
  ('Real Madrid vs Barcelona', 'Champions League', 150, 'Available'),
  ('Man City vs Liverpool', 'Premier League', 120, 'Selling Fast'),
  ('Bayern Munich vs PSG', 'Champions League', 130, 'Available'),
  ('AC Milan vs Inter Milan', 'Serie A', 90, 'Sold Out'),
  ('Juventus vs Roma', 'Serie A', 80, 'Available');
  ('Juventus vs PSG', 'Serie A', 80, 'Available');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
insert into bookings (booking_id, user_id, match_id,
                      seat_number, payment_status, total_cost)
values
  (501, 1, 1, 'A-12', 'Confirmed', 150),
  (502, 1, 2, 'B-04', 'Confirmed', 120),
  (503, 2, 1, 'A-13', 'Confirmed', 150),
  (504, 2, 1, NULL, NULL, 150),
  (505, 3, 2, 'C-20', 'Pending', 120);


--==============================================================================================
--==============================================================================================

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


