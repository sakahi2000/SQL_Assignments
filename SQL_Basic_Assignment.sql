-- 1. Create a table called employees with the following structure?
-- : emp_id (integer, should not be NULL and should be a primary key)Q
-- : emp_name (text, should not be NULL)Q
-- : age (integer, should have a check constraint to ensure the age is at least 18)Q
-- : email (text, should be unique for each employee)Q
-- : salary (decimal, with a default value of 30,000).

-- Write the SQL query to create the above table with all constraints.


create table Employees ( 
emp_id int NOT NULL primary key,
emp_name varchar(20),
age int check (age >= 18),
email varchar(50) unique,
salary decimal(10,2) default 30000
)

-- 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
-- examples of common types of constraints.
-- answer - 
		
-- 2. Purpose of Constraints & Data Integrity

-- Constraints are like the rules of a society—but for your database. They ensure that data follows order, accuracy, and consistency instead of turning into a wild west of random values. Without them, your database might happily let you enter a salary of -5000 or two employees with the same ID. That’s chaos!

-- How constraints help maintain data integrity:

-- They prevent invalid data from entering (e.g., no negative age allowed).

-- They ensure uniqueness (no two students with the same roll number).

-- They preserve relationships between tables (foreign keys).

-- Common types of constraints:

-- NOT NULL – Ensures a column cannot have NULL values.
-- Example: An employee must have a name.

-- UNIQUE – No duplicate values allowed in the column.
-- Example: Each email address must be unique.

-- PRIMARY KEY – Combines NOT NULL + UNIQUE. It uniquely identifies each row.
-- Example: Student Roll Number.

-- FOREIGN KEY – Maintains referential integrity between tables.
-- Example: Each order must belong to a valid customer.

-- CHECK – Ensures values meet a condition.
-- Example: Age must be >= 18.

-- DEFAULT – Provides a default value if none is supplied.
-- Example: Status defaults to "Active".


-- 3. NOT NULL & Primary Key Behavio

-- Why apply NOT NULL?
-- Because sometimes having no value just makes no sense. Imagine a student record without a name, or a product without a price—your queries will panic.

-- Can a primary key contain NULL values?
-- Absolutely not! A primary key must uniquely identify each record. If it could contain NULL, then… what would NULL mean? NULL is “unknown,” and two unknowns are not unique. It would break the very idea of “primary.”


-- 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
-- example for both adding and removing a constraint.

ALTER TABLE Employees
ADD CONSTRAINT chk_age CHECK (age >= 18);

ALTER TABLE Employees
DROP CONSTRAINT chk_age;

-- 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
-- Provide an example of an error message that might occur when violating a constraint.
-- answer
-- When you try to break the rules, the database becomes your strict school teacher: it doesn’t allow nonsense and throws errors.

-- Examples:

-- Inserting a NULL into a NOT NULL column → "Cannot insert NULL into column ‘name’."

-- Inserting duplicate values into a PRIMARY KEY → "Violation of PRIMARY KEY constraint. Cannot insert duplicate key in object."

-- Entering age = 12 when CHECK requires age ≥ 18 → "CHECK constraint violation."

-- Deleting a customer record that has related orders (foreign key) → "The DELETE statement conflicted with the REFERENCE constraint.
-- -- 6. You created a products table without constraints as follows:

-- CREATE TABLE products (

--     product_id INT,

--     product_name VARCHAR(50),

--     price DECIMAL(10, 2));  
-- Now, you realise that?
-- : The product_id should be a primary keyQ
-- : The price should have a default value of 50.00

 CREATE TABLE products (

   product_id INT primary key,

  product_name VARCHAR(50),

  price DECIMAL(10, 2) default 50);
  
 --  7. You have two tables:
 create database student;
 drop database Student;
 create table student(
 stud_id int,
 stud_name varchar(20),
 class_id int);
 create table class(
 class_id int, 
 class_name varchar(20));
 
 insert into student (stud_id,stud_name,class_id)
 values 
(1,'a',101),
(2,'b',102),
(3,'c',103);

insert into class (class_id,class_name)
values 
(101,'d'),
(102,'e'),
(103,'f');
 
SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c
ON s.class_id = c.class_id;

-- 8. Consider the following three tables:
-- Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
-- listed even if they are not associated with an order 
-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Customers
INSERT INTO customers VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

-- Products
INSERT INTO products VALUES 
(101, 'Laptop', 50000.00),
(102, 'Mouse', 500.00),
(103, 'Keyboard', 1500.00),
(104, 'Monitor', 12000.00);

-- Orders
INSERT INTO orders VALUES
(201, 1, 101, 1),  -- Alice buys Laptop
(202, 2, 102, 2),  -- Bob buys 2 Mice
(203, 1, 103, 1);  -- Alice buys Keyboard

SELECT o.order_id, c.customer_name, p.product_name
FROM products p
LEFT JOIN orders o
  ON p.product_id = o.product_id
LEFT JOIN customers c
  ON o.customer_id = c.customer_id;


-- 9.Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
-- Products table
-- Products
SELECT p.product_name, 
       SUM(o.quantity * p.price) AS total_sales
FROM orders o
INNER JOIN products p
  ON o.product_id = p.product_id
GROUP BY p.product_name;

-- 10. Write a query to display the order_id, customer_name, and the quantity of products ordered by each
-- customer using an INNER JOIN between all three tables.

    CREATE TABLE order_details (
    detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id));
    

SELECT o.order_id, c.customer_name, od.quantity
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN order_details od
ON o.order_id = od.order_id;

-- SQL Commands

-- 1. Identify primary keys and foreign keys + differences

-- Primary Key (PK): Unique identifier for each row in a table. (e.g., customer.customer_id, film.film_id, actor.actor_id)

-- Foreign Key (FK): Column(s) that reference a primary key in another table. (e.g., rental.customer_id → references customer.customer_id)

-- Difference:

-- PK ensures uniqueness in its own table.

-- FK ensures referential integrity between two tables.

-- 2. List all details of actors
select * 
from actors;

-- 3. List all customer information
SELECT * 
FROM customer;

-- 4. List different countries
SELECT DISTINCT country 
FROM country;

-- 5. Display all active customers
SELECT * 
FROM customer
WHERE active = 1;

-- 6. Rental IDs for customer with ID = 1
SELECT rental_id 
FROM rental
WHERE customer_id = 1;

-- 7. Films with rental duration > 5
SELECT * 
FROM film
WHERE rental_duration > 5;

-- 8. Number of films with replacement cost between $15 and $20
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 
  AND replacement_cost < 20;
  
-- 9. Count of unique actor first names
SELECT COUNT(DISTINCT first_name) AS unique_actor_first_names
FROM actor;

-- 10. First 10 records from customer table
SELECT * 
FROM customer
LIMIT 10;

-- 11. First 3 customers whose first name starts with ‘b’
SELECT * 
FROM customer
WHERE first_name LIKE 'B%'
LIMIT 3;

-- 12. First 5 movies rated ‘G’
SELECT title 
FROM film
WHERE rating = 'G'
LIMIT 5;

-- 13. Customers whose first name starts with "a"
SELECT * 
FROM customer
WHERE first_name LIKE 'A%';

-- 14. Customers whose first name ends with "a"
SELECT * 
FROM customer
WHERE first_name LIKE '%a';

-- 15. First 4 cities that start and end with "a"
SELECT city 
FROM city
WHERE city LIKE 'A%a'
LIMIT 4;

-- 16. Customers whose first name has "NI" anywhere
SELECT * 
FROM customer
WHERE first_name LIKE '%NI%';

-- 17. Customers whose first name has "r" in second position
SELECT * 
FROM customer
WHERE first_name LIKE '_r%';

-- 18. Customers whose first name starts with "a" and is at least 5 characters
SELECT * 
FROM customer
WHERE first_name LIKE 'A%' 
  AND LENGTH(first_name) >= 5;

-- 19. Customers whose first name starts with "a" and ends with "o"
SELECT * 
FROM customer
WHERE first_name LIKE 'A%o';

-- 20. Films with PG and PG-13 rating (IN operator)
SELECT * 
FROM film
WHERE rating IN ('PG', 'PG-13');

-- 21. Films with length between 50 and 100
SELECT * 
FROM film
WHERE length BETWEEN 50 AND 100;

-- 22. Top 50 actors
SELECT * 
FROM actor
LIMIT 50;

-- 23. Distinct film IDs from inventory table
SELECT DISTINCT film_id 
FROM inventory;

-- FUNCTIONS

-- Question 1: Retrieve the total number of rentals made in the Sakila database.
SELECT COUNT(*) AS total_rentals
FROM rental;

-- Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT AVG(rental_duration) AS avg_rental_duration
FROM film;

-- Question 3: Display the first name and last name of customers in uppercase.
SELECT UPPER(first_name) AS first_name_upper,
       UPPER(last_name) AS last_name_upper
FROM customer;

-- Question 4: Extract the month from the rental date and display it alongside the rental ID.
SELECT rental_id,
       MONTH(rental_date) AS rental_month
FROM rental;

-- Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id,
       COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

-- Question 6: Find the total revenue generated by each store.
SELECT store_id,
       SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

-- Question 7: Determine the total number of rentals for each category of movies.
SELECT fc.category_id,
       COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY fc.category_id;

-- Question 8: Find the average rental rate of movies in each language.
SELECT l.language_id,
       l.name AS language_name,
       AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.language_id, l.name;


-- JOIN

-- Question 9: Display the title of the movie, customer's first name, and last name who rented it
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

-- Explanation:
-- 1. film → inventory: to find which copies of the film exist.
-- 2. inventory → rental: to find who rented which copy.
-- 3. rental → customer: to get customer details.

--------------------------------------------------------

-- Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind"
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

-- Explanation:
-- 1. actor → film_actor: to see which actor acted in which film.
-- 2. film_actor → film: to filter by film title.

--------------------------------------------------------

-- Question 11: Retrieve customer names along with the total amount they've spent on rentals
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN rental r ON p.rental_id = r.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- Explanation:
-- 1. customer → payment: to see payments made by each customer.
-- 2. payment → rental: ensure the payment corresponds to a rental.
-- 3. SUM(): to calculate total amount spent.
-- 4. GROUP BY: to calculate per customer.

--------------------------------------------------------

-- Question 12: List titles of movies rented by each customer in a particular city (e.g., 'London')
SELECT ci.city, c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
ORDER BY c.customer_id, f.title;

-- Explanation:
-- 1. customer → address → city: to filter customers by city.
-- 2. customer → rental → inventory → film: to find which movies each customer rented.
-- 3. WHERE: to filter by city ('London').


-- Question 13: Display the top 5 rented movies along with the number of times they've been rented
SELECT f.title, COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC
LIMIT 5;

-- Explanation:
-- 1. film → inventory → rental: to find all rentals of each film.
-- 2. COUNT(r.rental_id): counts how many times each film was rented.
-- 3. GROUP BY film: to aggregate rentals per film.
-- 4. ORDER BY DESC: to get most rented first.
-- 5. LIMIT 5: only top 5 results.

--------------------------------------------------------

-- Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2)
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;

-- Explanation:
-- 1. customer → rental → inventory: to find which customer rented from which store.
-- 2. WHERE i.store_id IN (1,2): only consider stores 1 and 2.
-- 3. GROUP BY customer: to aggregate rentals per customer.
-- 4. HAVING COUNT(DISTINCT i.store_id) = 2: ensures customer rented from both stores.

-- Windows Function:

-- 1. Rank the customers based on the total amount they've spent on rentals
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Explanation:
-- RANK() gives a rank based on total spending, with ties receiving the same rank.

--------------------------------------------------------

-- 2. Calculate the cumulative revenue generated by each film over time
SELECT 
    f.film_id,
    f.title,
    r.rental_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.film_id, r.rental_date;

-- Explanation:
-- SUM() OVER(PARTITION BY ... ORDER BY ...) calculates running total of revenue per film over time.

--------------------------------------------------------

-- 3. Determine the average rental duration for each film, considering films with similar lengths
SELECT 
    f.film_id, 
    f.title, 
    f.length,
    AVG(r.rental_duration) OVER (PARTITION BY f.length) AS avg_rental_duration_for_length
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.length;

-- Explanation:
-- PARTITION BY f.length groups films with similar lengths and calculates average rental duration.

--------------------------------------------------------

-- 4. Identify the top 3 films in each category based on their rental counts
SELECT *
FROM (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rn
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.cate);

-- Normalisation & CTE
-- 1. First Normal Form (1NF)

-- Question: Identify a table in the Sakila database that violates 1NF and explain how to normalize it.

-- Example Table: Suppose we have a table customer_orders like this:

-- customer_id	customer_name	rented_movies
-- 1	John Doe	Titanic, Matrix
-- 2	Jane Smith	Gone with the Wind

-- Problem:

-- The rented_movies column contains multiple values in a single cell.

-- This violates 1NF, which requires each column to have atomic (indivisible) values.

-- Solution (Normalization to 1NF):

-- Break the multi-valued column into separate rows:

-- customer_id	customer_name	rented_movie
-- 1	John Doe	Titanic
-- 1	John Doe	Matrix
-- 2	Jane Smith	Gone with the Wind

-- Now each column contains atomic values, satisfying 1NF.

-- 2. Second Normal Form (2NF)

-- Question: Choose a table and determine if it is in 2NF.

-- Example Table: film_actor

-- actor_id	film_id	actor_name	film_title

-- Problem:

-- The table has a composite primary key (actor_id, film_id).

-- Columns actor_name and film_title depend only on part of the key, not the full key.

-- actor_name depends only on actor_id

-- film_title depends only on film_id

-- Solution (Normalization to 2NF):

-- Split the table:

-- film_actor → Only keys

-- actor_id	film_id

-- actor → Actor details

-- actor_id	actor_name

-- film → Film details

-- film_id	film_title

-- This removes partial dependencies, achieving 2NF.

-- 3. Third Normal Form (3NF)

-- Question: Identify a table violating 3NF and explain the transitive dependency.

-- Example Table: customer

-- customer_id	first_name	last_name	address	city_name	country_name

-- Problem:

-- city_name depends on address (transitive dependency)

-- country_name depends on city_name (transitive dependency)

-- Solution (Normalization to 3NF):

-- Split into multiple tables:

-- customer → Customer details

-- customer_id	first_name	last_name	address_id

-- address → Address details

-- address_id	address	city_id

-- city → City details

-- city_id	city_name	country_id

-- country → Country details

-- country_id	country_name

-- This removes transitive dependencies, achieving 3NF.

-- 4. Normalization Process Example (1NF → 2NF)

-- Example: Table customer_rentals (unnormalized form):

-- customer_id	customer_name	film_title1	film_title2	film_title3

-- Step 1: 1NF

-- Make each movie a separate row:

-- customer_id	customer_name	film_title
-- 1	John Doe	Titanic
-- 1	John Doe	Matrix
-- 2	Jane Smith	Gone with Wind

-- Step 2: 2NF

-- Remove partial dependencies (if customer_name depends only on customer_id):

-- Customer Table

-- customer_id	customer_name

-- Rental Table

-- customer_id	film_title

-- Now the tables are in 2NF.

-- 5. CTE Basics

-- Question: Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in.

WITH actor_film_count AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT *
FROM actor_film_count
ORDER BY film_count DESC;


-- Explanation:

-- The CTE (actor_film_count) calculates the number of films per actor.

-- The final SELECT retrieves the list ordered by the number of films.

-- ------------------------------------------------------
-- Question 6a: CTE with Joins
-- Create a CTE that combines information from the film and language tables
-- to display the film title, language name, and rental rate
-- ------------------------------------------------------
WITH film_language AS (
    SELECT 
        f.film_id,
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT *
FROM film_language
ORDER BY film_title;

-- Explanation:
-- 1. Join film and language tables on language_id.
-- 2. CTE 'film_language' stores film title, language, and rental rate.
-- 3. Final SELECT retrieves all rows from the CTE.

------------------------------------------------------

-- Question 6b: CTE for Aggregation
-- Write a query using a CTE to find the total revenue generated by each customer
-- using the customer and payment tables
------------------------------------------------------
WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM customer_revenue
ORDER BY total_revenue DESC;

-- Explanation:
-- 1. Join customer and payment tables.
-- 2. SUM(amount) calculates total spending per customer.
-- 3. CTE simplifies aggregation and allows reuse if needed.

------------------------------------------------------

-- Question 6c: CTE with Window Functions
-- Utilize a CTE with a window function to rank films based on rental duration
------------------------------------------------------
WITH film_rank AS (
    SELECT 
        f.film_id,
        f.title,
        f.rental_duration,
        RANK() OVER (ORDER BY f.rental_duration DESC) AS rental_rank
    FROM film f
)
SELECT *
FROM film_rank
ORDER BY rental_rank;

-- Explanation:
-- 1. RANK() assigns ranks to films based on rental duration.
-- 2. Films with same rental_duration receive same rank.
-- 3. CTE 'film_rank' stores ranking logic separately.

------------------------------------------------------

-- Question 6d: CTE and Filtering
-- Create a CTE to list customers who have made more than two rentals
-- and join with customer table to retrieve additional details
------------------------------------------------------
WITH frequent_customers AS (
    SELECT 
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    fc.rental_count
FROM frequent_customers fc
JOIN customer c ON fc.customer_id = c.customer_id
ORDER BY fc.rental_count DESC;

-- Explanation:
-- 1. CTE 'frequent_customers' finds customers with more than 2 rentals.
-- 2. Join with customer table retrieves their names.
-- 3. ORDER BY rental_count DESC shows the most frequent customers first.

-- ------------------------------------------------------
-- Question EC: CTE for Date Calculations
-- Find the total number of rentals made each month, considering rental_date from the rental table
-- ------------------------------------------------------
WITH monthly_rentals AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT *
FROM monthly_rentals
ORDER BY rental_month;

-- Explanation:
-- 1. DATE_FORMAT(rental_date, '%Y-%m') extracts year and month from rental_date.
-- 2. COUNT(rental_id) counts total rentals per month.
-- 3. CTE 'monthly_rentals' stores this aggregation for easy querying.

------------------------------------------------------

-- Question EE: CTE and Self-Join
-- Generate a report showing pairs of actors who have appeared in the same film together
-- using the film_actor table
------------------------------------------------------
WITH actor_pairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id
        AND fa1.actor_id < fa2.actor_id  -- avoid duplicate pairs and self-pairs
)
SELECT 
    f.title AS film_title,
    a1.first_name AS actor1_first_name,
    a1.last_name AS actor1_last_name,
    a2.first_name AS actor2_first_name,
    a2.last_name AS actor2_last_name
FROM actor_pairs ap
JOIN film f ON ap.film_id = f.film_id
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY f.title;

-- Explanation:
-- 1. CTE 'actor_pairs' finds all actor pairs per film using self-join on film_actor.
-- 2. The condition fa1.actor_id < fa2.actor_id avoids duplicates like (A,B) and (B,A).
-- 3. Join with actor and film tables to get names and film titles.

------------------------------------------------------

-- Question 12: CTE for Recursive Search
-- Find all employees in the staff table who report to a specific manager (reports_to column)
------------------------------------------------------
WITH RECURSIVE staff_hierarchy AS (
    -- Anchor member: select the manager
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM staff
    WHERE staff_id = 1  -- replace 1 with specific manager ID
    UNION ALL
    -- Recursive member: select staff who report to previous level
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM staff s
    JOIN staff_hierarchy sh ON s.reports_to = sh.staff_id
)
SELECT *
FROM staff_hierarchy
ORDER BY staff_id;

-- Explanation:
-- 1. Anchor member selects the manager.
-- 2. Recursive member finds employees reporting to the previous level.
-- 3. UNION ALL combines anchor and recursive results to form full hierarchy.
-- ------------------------------------------------------
-- Question EC: CTE for Date Calculations
-- Find the total number of rentals made each month, considering rental_date from the rental table
-- ------------------------------------------------------
WITH monthly_rentals AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT *
FROM monthly_rentals
ORDER BY rental_month;

-- Explanation:
-- 1. DATE_FORMAT(rental_date, '%Y-%m') extracts year and month from rental_date.
-- 2. COUNT(rental_id) counts total rentals per month.
-- 3. CTE 'monthly_rentals' stores this aggregation for easy querying.

------------------------------------------------------

-- Question EE: CTE and Self-Join
-- Generate a report showing pairs of actors who have appeared in the same film together
-- using the film_actor table
------------------------------------------------------
WITH actor_pairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id
        AND fa1.actor_id < fa2.actor_id  -- avoid duplicate pairs and self-pairs
)
SELECT 
    f.title AS film_title,
    a1.first_name AS actor1_first_name,
    a1.last_name AS actor1_last_name,
    a2.first_name AS actor2_first_name,
    a2.last_name AS actor2_last_name
FROM actor_pairs ap
JOIN film f ON ap.film_id = f.film_id
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY f.title;

-- Explanation:
-- 1. CTE 'actor_pairs' finds all actor pairs per film using self-join on film_actor.
-- 2. The condition fa1.actor_id < fa2.actor_id avoids duplicates like (A,B) and (B,A).
-- 3. Join with actor and film tables to get names and film titles.

------------------------------------------------------

-- Question 12: CTE for Recursive Search
-- Find all employees in the staff table who report to a specific manager (reports_to column)
------------------------------------------------------
WITH RECURSIVE staff_hierarchy AS (
    -- Anchor member: select the manager
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM staff
    WHERE staff_id = 1  -- replace 1 with specific manager ID
    UNION ALL
    -- Recursive member: select staff who report to previous level
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM staff s
    JOIN staff_hierarchy sh ON s.reports_to = sh.staff_id
)
SELECT *
FROM staff_hierarchy
ORDER BY staff_id;

-- Explanation:
-- 1. Anchor member selects the manager.
-- 2. Recursive member finds employees reporting to the previous level.
-- 3. UNION ALL combines anchor and recursive results to form full hierarchy.
