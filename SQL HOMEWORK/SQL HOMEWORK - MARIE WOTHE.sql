##SQL HOMEWORK (WHATEVER NUMBER IT IS)
##NAME: MARIE WOTHE

USE sakila;

## Question 1A##
SELECT first_name, last_name
From actor;

## Question 1B##
ALTER TABLE actor
ADD actor_name VARCHAR(55);

SELECT 
	first_name,
    last_name,
    CONCAT(first_name,' ',last_name) as actor_name
FROM actor;

## Question 2A##
SELECT * FROM actor WHERE first_name = "JOE";

## Question 2B##
SELECT * FROM actor WHERE last_name LIKE "%GEN%";

## Question 2C##
SELECT * FROM actor WHERE last_name LIKE "%LI%"
ORDER BY 
	last_name,
    first_name;
    
## Question 2D##
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

## Question 3A##
ALTER TABLE actor
ADD description BLOB(100);

## BLOB stands for Binary Large Object and treats 
##the text like a number rather than a string. 

## Question 3B##
ALTER TABLE actor
DROP COLUMN description;

##Question 4A##
SELECT last_name,
COUNT(last_name) AS count_of
FROM actor
GROUP BY last_name;

## Question 4B##
SELECT last_name,
COUNT(last_name) AS count_of 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)>=2;

## Question 4C##
##Find actor
SELECT * FROM actor WHERE first_name = "GROUCHO";
##Edit row
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

##Question 4D##
UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id = 172;

## Question 5A##
SHOW CREATE TABLE address; 

## Question 6A##
SELECT staff.first_name, staff.last_name, address.address
FROM address
INNER JOIN staff on address.address_id=staff.address_id;

## Question 6B##
SELECT staff.staff_id, staff.first_name, staff.last_name, SUM(pay.amount) as total_checkout
FROM payment AS pay
INNER JOIN staff ON staff.staff_id=pay.staff_id 
WHERE pay.payment_date>'2005-07-31' AND pay.payment_date<'2005-09-01'
GROUP BY staff_id;

## Question 6C##
SELECT film.title, film.film_id, COUNT(film_actor.film_id) as actor_count
FROM film_actor 
INNER JOIN film ON film.film_id=film_actor.film_id
GROUP BY film_actor.film_id ASC;

## Question 6D##
##Find ID
SELECT * FROM film WHERE title LIKE 'hunchback%';
##Count copies
SELECT COUNT(film_id) 
FROM inventory
WHERE film_id = 439;

##Question 6E##
SELECT c.last_name, SUM(pay.amount) as total_spent
FROM payment as pay 
INNER JOIN customer c ON c.customer_id=pay.customer_id
GROUP BY c.last_name;

## Question 7A ##
SELECT * FROM film 
WHERE title LIKE 'k%' OR 'q%' IN
(
	SELECT title
	FROM film
	WHERE language_id IN
	(
		SELECT language_id
		FROM language
		WHERE language_id = 1
	)
);

## Question 7B ##
SELECT * FROM actor
WHERE actor_id IN
(
	SELECT actor_id
	FROM film
	WHERE title = 'Alone Trip'
);

## Question 7C ##
## c.email, c.address_id, a.city_id, city.country_id, country _id for Canada##
SELECT c.first_name, c.last_name, c.email
FROM customer c
INNER JOIN address a ON (a.address_id=c.address_id)
INNER JOIN city ON (city.city_id=a.city_id)
INNER JOIN country  ON (country.country_id=city.country_id)
WHERE country.country_id=20;

## Question 7D ##
SELECT * FROM film
WHERE film_id in
(
	SELECT film_id
    FROM category
    WHERE category_id = 8
);

## Question 7E ## 
SELECT f.title, COUNT(*) as rental_count
FROM film f
INNER JOIN inventory i ON (i.film_id = f.film_id)
INNER JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY f.title;

## Question 7F ##  
SELECT i.store_id, SUM(pay.amount) as revenue_by_store
FROM payment as pay
INNER JOIN rental r ON (r.rental_id=pay.rental_id)
INNER JOIN inventory i ON (i.inventory_id=r.inventory_id)
GROUP BY i.store_id;

## Question 7G ## 
SELECT s.store_id, city.city, c.country
FROM store s
INNER JOIN address a ON (a.address_id=s.address_id)
INNER JOIN city ON (city.city_id=a.city_id)
INNER JOIN country c ON (c.country_id=city.country_id);

## Question 7H ##
SELECT c.name, SUM(pay.amount) as genre_revenue
FROM payment as pay
INNER JOIN rental r ON (r.rental_id=pay.rental_id)
INNER JOIN inventory i ON (i.inventory_id=r.inventory_id)
INNER JOIN film_category f ON (i.film_id = f.film_id)
INNER JOIN category c ON (c.category_id=f.category_id)
GROUP BY c.category_id
ORDER BY genre_revenue DESC
LIMIT 5;

## Question 8A ##
CREATE VIEW five_top_genres AS
SELECT c.name, SUM(pay.amount) as genre_revenue
FROM payment as pay
INNER JOIN rental r ON (r.rental_id=pay.rental_id)
INNER JOIN inventory i ON (i.inventory_id=r.inventory_id)
INNER JOIN film_category f ON (i.film_id = f.film_id)
INNER JOIN category c ON (c.category_id=f.category_id)
GROUP BY c.category_id
ORDER BY genre_revenue DESC
LIMIT 5;

## Question 8B##
SELECT * FROM five_top_genres;

## Question 8C ##
DROP VIEW five_top_genres;