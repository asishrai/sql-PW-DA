USE MAVENMOVIES;

-- Question 1: Retrieve the total number of rentals made in the Sakila database. --
-- ans 
 select  COUNT(*) AS total_rentals
FROM rental;

-- que 2  Find the average rental duration (in days) of movies rented from the Sakila database.
-- ans 
SELECT AVG(rental_duration)
FROM film;

-- que 3 Question 3: Display the first name and last name of customers in uppercase.
-- ans 
SELECT UPPER(first_name) , UPPER(last_name) 
FROM customer;

-- que 4 Question 4: Extract the month from the rental date and display it alongside the rental ID.
-- ans 
SELECT rental_id, MONTH(rental_date) 
FROM rental;

-- Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
-- ans 
SELECT customer_id, COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id;

-- que 6 Find the total revenue generated by each store.
select * from store ;


-- que 7 Display the title of the movie, customer s first name, and last name who rented it Hint: Use JOIN between the film, inventory, rental, and customer tables -- 
select * from film ; -- film_id , title 
select * from inventory ; -- film_id 
select * from rental ; -- customer id , inventory id , rental id 
select * from customer ; -- first name , last name , customer id .
 
SELECT film.title, customer.first_name, customer.last_name
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id;


-- que 8  Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
-- ans  
SELECT actor.first_name, actor.last_name
FROM actor
inner JOIN film_actor ON actor.actor_id = film_actor.actor_id
inner JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Some Movie';

-- que9 Determine the total number of rentals for each category of movies.
-- ans 
select* from film ;
select* from film_category ; 
select* from inventory ; 
-- ans 
SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id;

-- que 10  Find the average rental rate of movies in each language.
-- ans 
SELECT l.name AS language_name, AVG(f.rental_rate) AS average_rental_rate
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.language_id;

-- que 11 Retrieve the customer names along with the total amount they've spent on rentals.
-- ans 
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_amount_spent_on_rental
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;


-- que 12 List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- ans 
select* from city ;

SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ct.city = ' london'
ORDER BY c.last_name, c.first_name, f.title;

-- que 13 Display the top 5 rented movies along with the number of times they've been rented.
-- ans 

SELECT f.title AS movie_title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 5 ;

-- que 14 Question 6: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- ans 
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
WHERE s.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT s.store_id) = 2;