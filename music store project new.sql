create database music_store;
use music_store;


--  Q1: Who is the senior most employee based on job title?
select * from employee;
SELECT title, last_name, first_name 
FROM employee
ORDER BY levels DESC
LIMIT 1;


 -- Q2: Which countries have the most Invoices? 

SELECT COUNT(*) AS c, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY c DESC;


--  Q3: What are top 3 values of total invoice? 

SELECT total 
FROM invoice
ORDER BY total DESC
limit 3;



--  Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals 

SELECT billing_city,SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY billing_city
ORDER BY InvoiceTotal DESC
LIMIT 1;


 -- Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.

-- by own-- 
select * from invoice;

select customer_id ,sum(total) as total 
from invoice 
group by customer_id
order by total desc
limit 1;

-- wrong-- 
SELECT customer.customer_id, first_name, last_name, SUM(invoice) AS total_spending
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id 
ORDER BY total_spending DESC
LIMIT 1;
-- right-- 
SELECT customer.customer_id, first_name, last_name, SUM(total) AS total_spending
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id , customer.first_name, customer.last_name
ORDER BY total_spending DESC
LIMIT 1;


--  Question Set 2 - Moderate 

 -- Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A. 


SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;


 -- Q2: Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands. 

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album2 ON album2.album_id = track.album_id
JOIN artist ON artist.artist_id = album2.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id , artist.name
ORDER BY number_of_songs DESC
LIMIT 10;


 -- Q3: Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. own

select * from track;
select avg(milliseconds) from track;

select name , milliseconds from track 
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;
