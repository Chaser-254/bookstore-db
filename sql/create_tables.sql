-- Book Table
-- This table stores information about books.
-- It includes a foreign key reference to the publisher and language tables.
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    publisher_id INT,
    language_id INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- author table
-- This table stores information about authors.
-- It includes a foreign key reference to the book table.
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

--book_author table with (many-to-many relationship)
-- This table stores the relationship between books and authors.
-- It includes foreign key references to both the book and author tables.
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- book_language table
-- This table stores information about languages.
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50)
);

-- publisher table
-- This table stores information about publishers.
-- It includes a primary key and some basic information about the publisher.
-- It does not include a foreign key reference to any other table.
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    contact_email VARCHAR(100)
);

-- customer table
-- This table stores information about customers.
-- It includes a primary key and some basic information about the customer.
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

-- address_status table
-- This table stores information about address statuses.
-- It includes a primary key and some basic information about the status.
-- It does not include a foreign key reference to any other table.
-- It is used to track the status of customer addresses.
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- country table
-- This table stores information about countries.
-- It includes a primary key and some basic information about the country.
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);

-- address table
-- This table stores information about addresses.
-- It includes a primary key and some basic information about the address.
-- It also includes a foreign key reference to the country table.
-- It is used to track the addresses of customers.
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- customer_address table
-- This table stores the relationship between customers and addresses.
-- It includes foreign key references to both the customer and address tables.
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- shipping_method table
-- This table stores information about shipping methods.
-- It includes a primary key and some basic information about the method.
-- It does not include a foreign key reference to any other table.
-- It is used to track the shipping methods available for orders.
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100)
);

-- order_status table
-- This table stores information about order statuses.
-- It includes a primary key and some basic information about the status.
-- It does not include a foreign key reference to any other table.
-- It is used to track the status of customer orders.
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- customer_order table
-- This table stores information about customer orders.
-- It includes a primary key and some basic information about the order.
-- It also includes foreign key references to the customer, shipping method, and order status tables.
-- It is used to track the orders placed by customers.
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- order_line table
-- This table stores the details of each order line item.
-- It includes a foreign key reference to the order table and the book table.
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- order_history table
-- This table stores the history of order status changes.
-- It includes a foreign key reference to the order table and the status table.
-- It also includes a timestamp for when the status change occurred.
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);