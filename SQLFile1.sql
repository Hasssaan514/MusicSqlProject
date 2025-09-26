

-- /* Q1: Who is the senior most employee based on job title? */

SELECT TOP 1 * FROM employee
ORDER BY levels DESC

/* Q2: Which countries have the most Invoices? */

SELECT COUNT(*) AS total_no_invoices, billing_country FROM invoice
GROUP BY billing_country
ORDER BY billing_country DESC

-- SELECT *, billing_country FROM invoice


-- /* Q3: What are top 3 values of total invoice? */

SELECT TOP 3 * FROM invoice
ORDER BY total desc

OR

SELECT TOP 3 total FROM invoice
ORDER BY total desc


/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */
SELECT * FROM invoice
SELECT TOP 1 billing_city, SUM(total) AS total_no_invoices FROM invoice
GROUP BY billing_city
ORDER BY billing_city desc





/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/
SELECT * FROM customer 
SELECT TOP 1
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    SUM(invoice.total) AS total
FROM customer
JOIN invoice 
    ON customer.customer_id = invoice.customer_id
GROUP BY 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name
ORDER BY total DESC;



/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

/*Method 1 */

SELECT * FROM genre 

SELECT DISTINCT customer.first_name, customer.last_name, customer.email FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id
JOIN invoice_line ON invoice_line.invoice_id=invoice.invoice_id
JOIN track ON track.track_id=invoice_line.track_id
JOIN genre ON genre.genre_id=track.genre_id
WHERE genre.name='Rock'
ORDER BY email



/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */
SELECT * FROM album
SELECT * FROM artist
SELECT * FROM track

-- METHOD 1:
SELECT TOP 10 artist.name, COUNT(artist.artist_id) AS total_no_of_songs 
FROM track
JOIN album ON track.album_id=album.album_id 
JOIN artist ON artist.artist_id=album.artist_id 
JOIN genre ON genre.genre_id=track.genre_id 
WHERE genre.name='Rock' 
GROUP BY artist.artist_id, artist.name
ORDER BY total_no_of_songs desc; 


-- METHOD 2:

SELECT 
    artist.artist_id, 
    artist.name, 
    COUNT(track.track_id) AS total_no_of_songs
FROM track
JOIN album ON track.album_id = album.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY total_no_of_songs DESC;


-- Artist ID(22)  has 114 songs 
-- Artist ID(150) has 112 songs 




/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name, milliseconds AS track_length FROM track 
WHERE 
milliseconds > ( 
SELECT AVG(milliseconds) 
FROM track 
)  
ORDER BY TRACK_LENGTH desc 






--
/* Question Set 2 - ADVANCED */ 

-- FIND how much amount spent by each customer on artists? Write a query a return customer name, artsist name, and total spent 


-- SELECT * FROM invoice_line 

-- METHOD 1:


SELECT 
    customer.first_name, 
    customer.last_name, 
    artist.name AS artist_name,
    SUM(invoice_line.unit_price * invoice_line.quantity) AS total_price 
FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id 
JOIN invoice_line ON invoice.invoice_id=invoice_line.invoice_id 
JOIN track ON track.track_id=invoice_line.track_id 
JOIN album ON track.album_id=album.album_id 
JOIN artist ON album.artist_id=artist.artist_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name, artist.name
ORDER BY total_price desc



-- METHOD 2 with CT: 
WITH best_selling_artist AS (
	SELECT TOP 1 artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY artist.artist_id, artist.name
	ORDER BY total_sales desc 
	
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY amount_spent DESC;








