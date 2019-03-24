USE sakila;

#1a
SELECT first_name, last_name FROM actor 

#1b
SELECT UCASE(LEFT(first_name, 1)), first_name FROM actor;

#2a
SELECT first_name, last_name, actor_id FROM actor
WHERE first_name LIKE 'JOE'

#2b
SELECT last_name FROM actor
WHERE last_name LIKE '%gen%';

#2c
SELECT last_name, first_name FROM actor
WHERE last_name LIKE '%li%';

#2d
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a
ALTER TABLE `sakila`.`actor` 
ADD COLUMN `description` TINYBLOB NULL AFTER `last_update`;

#3b
SELECT * FROM actor
ALTER TABLE `sakila`.`actor` 
DROP COLUMN `description`;

#4a
SELECT COUNT(last_name), last_name FROM actor
GROUP BY last_name;


#4b
SELECT COUNT(last_name), last_name FROM actor
GROUP BY last_name 
HAVING COUNT(last_name)>2;

#4c
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE 'williams'
UPDATE actor 
SET first_name = "HARPO" WHERE actor_id = 172;

#4d
select actor_id, first_name, last_name from actor where last_name LIKE 'williams'
UPDATE actor 
set first_name = "GROUCHO" where actor_id = 172;

#5a
DESCRIBE address;
SHOW CREATE TABLE address;

#6a
select * from address;
select * from staff;

SELECT first_name, last_name, address FROM staff
JOIN address ON
address.address_id = staff.address_id;
SELECT * from address

#6b

select * from staff
select * from payment;

select first_name, last_name, staff.staff_id, SUM(amount), payment_date FROM staff
join payment on
payment.staff_id = staff.staff_id
WHERE payment_date LIKE '2005-08%'
Group by staff_id;

select * from inventory

#6c

select COUNT(actor_id), title FROM film
join film_actor 
on film_actor.film_id = film.film_id
GROUP BY title;

#6d?
select * from film
select * from inventory

select title, count(inventory.film_id) from film
join film
on film.film_id = inventory.film_id
where title LIKE '%hunchback im%';


#6e
select * from payment
select * from customer

SELECT customer.customer_id, first_name, last_Name, rental_id, SUM(payment.amount) from customer
inner join payment
on payment.customer_id = customer.customer_id
GROUP BY customer_id

#7a
ON c.customer_id= p.customer_id

select * from language;

select title from film 
having title like 'k%' or title like 'q%' 
and title in
(select title from film where language_id = 1);

#7b

SELECT first_name, last_name FROM actor WHERE actor_id IN
(SELECT actor_id FROM film_actor WHERE film_id IN
(SELECT film_id FROM film WHERE title LIKE 'alone trip'));

#7c

select * from customer
select * from address
select * from city
select * from country

SELECT customer.first_name, customer.last_name, customer.email FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON city.city_id = address.city_id
JOIN country
ON country.country_id = city.country_id
WHERE country = 'Canada';



#7d

select * from film
select * from film_category
select * from category

SELECT title, description FROM film
WHERE film_id IN
(SELECT film_id FROM film_category WHERE category_id IN
(SELECT category_id FROM category WHERE name = 'Family'));


#7e

select * from rental
select * from inventory
select * from store

SELECT film.title, COUNT(rental.rental_id) FROM rental
JOIN inventory on (rental.inventory_id = inventory.inventory_id)
JOIN film ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY COUNT(rental_id) DESC;


#7f ??????????????????????????

select * from store
select * from payment
select * from rental

SELECT store_id, SUM(payment.amount) FROM store
JOIN rental ON (payment.rental_id = rental.rental_id)
JOIN inventory ON (inventory.inventory_id = rental.inventory_id)
JOIN store ON (store.store_id = inventory.store_id);
GROUP BY store.store_id;

#7g

select * from city
select * from country

SELECT store.store_id, city.city, country.country FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id;

#7h

select * from category

SELECT name, SUM(payment.amount) FROM category
JOIN film_category ON (category.category_id = film_category.category_id)
JOIN inventory ON (film_category.film_id = inventory.film_id)
JOIN rental ON (inventory.inventory_id=rental.inventory_id)
JOIN payment ON (rental.rental_id = payment.rental_id)
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC;

#8a

CREATE VIEW genre_by_revenue AS
SELECT name, SUM(payment.amount) FROM category
JOIN film_category ON (category.category_id = film_category.category_id)
JOIN inventory ON (film_category.film_id = inventory.film_id)
JOIN rental ON (inventory.inventory_id=rental.inventory_id)
JOIN payment ON (rental.rental_id = payment.rental_id)
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC;


#8b

SELECT * FROM genre_by_revenue;

#8c

DROP VIEW genre_by_revenue;