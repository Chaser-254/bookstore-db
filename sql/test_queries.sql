-- Get all books by a specific author
SELECT b.title FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
WHERE a.last_name = 'Rowling';

-- List customer orders
SELECT co.order_id, c.first_name, c.last_name
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id;