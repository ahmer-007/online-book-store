
-- Q1: Retrieve all books in the Fiction genre
SELECT * FROM books
WHERE genre ='Fiction';

-- Q2: Retrieve books published after 1950
SELECT * FROM books
WHERE published_year > 1950;

-- Q3: Retrieve customers who are located in Canada
SELECT * FROM customers
WHERE country='Canada';

-- Q4: Retrieve all orders placed in November 2023
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- Q5a: Find the total stock of all books combined
SELECT SUM(Stock) AS total_stock
FROM books;

-- Q5b: Show each book’s title with its stock
SELECT title, stock
FROM Books;

-- Q6a: Find the maximum book price
SELECT MAX(price) AS expensive_book
FROM books;

-- Q6b: Retrieve the book(s) with the maximum price including title and author
SELECT title, author, price
FROM books
WHERE price = (SELECT MAX(price) FROM BOOKS);

-- Q6c: Retrieve the top 5 most expensive books
SELECT title, price FROM books 
ORDER BY price DESC 
LIMIT 5;

-- Q7: Retrieve all orders where quantity > 1
SELECT * FROM orders
WHERE quantity > 1;

-- Q8: Retrieve all orders where total amount > 250
SELECT * FROM orders
WHERE total_amount > 250;

-- Q9a: Show all unique genres of books
SELECT DISTINCT genre AS unique_genre
FROM books;

-- Q9b: Count how many unique genres exist
SELECT COUNT(DISTINCT genre) AS total_unique_books
FROM books;

-- Q10a: Find the book with the lowest stock
SELECT MIN(stock) AS lowest_stock
FROM books;

-- Q10b: List the 10 books with the lowest stock
SELECT title, author, stock FROM books
ORDER BY stock ASC
LIMIT 10;

-- Q11: Calculate the total revenue (sum of all orders)
SELECT SUM(total_amount) AS total_revenue 
FROM orders;


-- ============================================
--   ADVANCED QUERIES
-- ============================================

-- Q12: Retrieve total number of books sold for each genre
SELECT b.genre, SUM(o.quantity) AS TOTAL_BOOKS_SOLD
FROM books b 
JOIN orders o ON o.book_id=b.book_id
GROUP BY b.genre;

-- Q13: Find average price of books in the Fantasy genre
SELECT AVG(price) AS average_price
FROM books
WHERE genre='Fantasy';

-- Q14: List customers who have placed at least 2 orders
SELECT c.customer_id, c.name,
       COUNT(o.order_id) AS TOTAL_ORDERS
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2
ORDER BY c.customer_id ASC;

-- Q15: Find the most frequently ordered book(s)
SELECT o.book_id, b.title, COUNT(o.order_id) AS ORDER_BOOKS
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_BOOKS DESC;

-- Q16a: Find the maximum priced Fantasy book (incorrect attempt)
SELECT MAX(price) AS top_exp_fan
FROM books
WHERE genre='Fantasy'
ORDER BY top_exp_fan DESC LIMIT 3; -- Note: MAX returns only one row

-- Q16b: Correct query - Show top 3 most expensive Fantasy books
SELECT * FROM books
WHERE genre='Fantasy'
ORDER BY price DESC LIMIT 3;

-- Q17: Retrieve total quantity of books sold by each author
SELECT b.author, SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.author;

-- Q18: List the cities of customers who spent more than 300
SELECT DISTINCT c.city, total_amount 
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 300;

-- Q19: Find the top 5 customers who spent the most
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC LIMIT 5;

-- Q20: Calculate remaining stock after fulfilling all orders
SELECT b.book_id, b.title, b.stock,
       COALESCE(SUM(o.quantity),0) AS ORDERS,
       b.stock - COALESCE(SUM(o.quantity),0) AS rem_stock
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id
ORDER BY b.book_id ASC;
