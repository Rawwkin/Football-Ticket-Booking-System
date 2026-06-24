# Football Ticket Booking System

## Project Overview

This project implements a simplified Football Ticket Booking System database using PostgreSQL. The system manages football fans, tournament matches, and ticket booking transactions. It demonstrates database design principles, entity relationships, referential integrity, and SQL query writing.

## ERD
https://drive.google.com/file/d/1QHA0u0NbH0UlnlR0TJ_i1tsS_Z1DMPKC/view?usp=sharing

## Database Structure

The system consists of three main tables:

### Users

Stores information about football fans and ticket managers, including names, email addresses, roles, and contact numbers.

### Matches

Stores football match information such as fixtures, tournament categories, ticket prices, and match availability status.

### Bookings

Records ticket purchases by linking users with matches while tracking seat allocation, payment status, and total booking cost.

## Entity Relationships

* One User can have many Bookings (1:N)
* Many Bookings can belong to one Match (N:1)
* Each Booking represents a unique association between one User and one Match for a specific seat reservation

## Features Demonstrated

* Primary Key and Foreign Key implementation
* Referential Integrity
* ERD Design using Crow's Foot notation
* SQL Filtering and Pattern Matching
* NULL Handling with COALESCE
* INNER JOIN and LEFT JOIN operations
* Aggregate Functions and Subqueries
* Pagination using LIMIT and OFFSET

## Technologies Used

* PostgreSQL
* Draw.io / Lucidchart (ERD Design)
* SQL

## Learning Outcomes

This project demonstrates practical database modeling and intermediate SQL concepts including joins, subqueries, aggregations, filtering, and relationship management within a football ticket booking platform.
