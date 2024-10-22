/*
    create at least 3 tables : restaurant
    - transactions
    - staff
    - menu
    - ingredient
    - ...
    write sql queries at least 3 queires
    - with clause / subquery
    - aggregate function & group by
    - where ..
*/

-- Create staff table --
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name TEXT,
    position TEXT,
    salary INT 
);

-- Insert data into staff table --
INSERT INTO staff (staff_id, staff_name, position, salary) VALUES 
    (1, 'Nick', 'Chef', 100000),
    (2, 'Matilda', 'Manager', 50000),
    (3, 'James', 'Waiter', 25000), 
    (4, 'Janie', 'Waitress', 20000);

.mode table
.header on 

SELECT * FROM staff;

-- Create menu table --
CREATE TABLE menu (
    menu_id INT PRIMARY KEY,
    item_name TEXT,
    price INT,
    category TEXT
);

-- Insert data into menu table --
INSERT INTO menu (menu_id, item_name, price, category) VALUES 
    (1, 'Spaghetti Carbonara', 220, 'Food'),
    (2, 'Fish & Chips', 190, 'Food'),
    (3, 'Prawn Pad Thai', 150, 'Food'),
    (4, 'Thai Basil Beef', 120, 'Food'),
    (5, 'Fresh Spring Rolls', 90, 'Food'),
    (6, 'Coconut Cake', 90, 'Dessert'),
    (7, 'Chocolate Tart', 90, 'Dessert'),
    (8, 'Orange Juice', 80, 'Drinks'),
    (9, 'Beer', 90, 'Drinks'),
    (10, 'Water', 20, 'Drinks');

.mode table
.header on 

SELECT * FROM menu;

-- Create customer table --
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    firstname TEXT,
    lastname TEXT,
    phone INT,
    email TEXT
);

-- Insert data into customer table --
INSERT INTO customer (customer_id, firstname, lastname, phone, email) VALUES 
    (1, 'Buddy', 'Marry', 0123456789, 'buddy.m@gmail.us' ), 
    (2, 'Calisa', 'Scoth', 0224466880, 'calisa.s@gmail.uk'),
    (3, 'Olivia', 'Wong', 0135790135, 'olivia.w@gmail.hk'),
    (4, 'Utada', 'Hikaru', 0987654321, 'utada.h@gmail.jp'),
    (5, 'Suzy', 'Kim', 0505505005, 'suzy.k@gmail.kr');

.mode table
.header on 

SELECT * FROM customer;

-- Create orders table --
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    staff_id INT,
    customer_id INT,
    menu_id INT,
    total_amount REAL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
);

-- Insert data into orders table --
INSERT INTO orders (order_id, staff_id, customer_id, menu_id, total_amount) VALUES 
    (1, 3, 1, 2, 190),
    (2, 4, 2, 3, 150),
    (3, 2, 3, 4, 120),
    (4, 3, 4, 6, 90),
    (5, 4, 5, 1, 220);

.mode table
.header on 

SELECT * FROM orders;

-- Create transactions table --
CREATE TABLE transactions  (
    transaction_id INT PRIMARY KEY,
    order_id INT,
    total_amount REAL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert data into transactions table --
INSERT INTO transactions (transaction_id, order_id, total_amount) VALUES 
    (1, 1, (190*0.07)+190),
    (2, 2, (150*0.07)+150),
    (3, 3, (120*0.07)+120),
    (4, 4, (90*0.07)+90),
    (5, 5, (220*0.07)+220);

.mode table
.header on 

SELECT * FROM transactions;

/*INSERT INTO transactions (transaction_id, order_id, total_amount) VALUES 
    (1, 1, 203.30),
    (2, 2, 160.50),
    (3, 3, 128.40),
    (4, 4, 96.30),
    (5, 5, 235.40);
    
.mode table
.header on 

SELECT * FROM transactions;
*/

--Query--
--WITH clause--
WITH 
    order_info AS (
        SELECT 
            trn.transaction_id AS transaction_id,
            ord.order_id AS order_no,
            sta.staff_name AS staff_name,
            cus.firstname AS customer_name,
            men.item_name AS order_menu,
            trn.total_amount AS total_amount_with_vat_7
        FROM transactions AS trn
        JOIN orders AS ord 
          ON trn.order_id = ord.order_id
        JOIN staff AS sta 
          ON ord.staff_id = sta.staff_id
        JOIN customer AS cus 
          ON ord.customer_id = cus.customer_id
        JOIN menu AS men 
          ON ord.menu_id = men.menu_id
    )
SELECT order_no, staff_name, customer_name, order_menu, total_amount_with_vat_7
FROM order_info;

--Subquery--
SELECT 
    staff_name,
    position,
    salary
FROM (
    SELECT *
    FROM staff
    WHERE salary > 30000.00
);

--Aggregate Function--
SELECT 
    COUNT(*) AS total_transactions,
    SUM(total_amount),
    AVG(total_amount),
    MIN(total_amount),
    MAX(total_amount)
FROM transactions;

--WHERE clause--
SELECT 
    item_name,
    price
FROM menu
WHERE price > 100.00
GROUP BY item_name
ORDER BY price DESC;

SELECT 
    item_name,
    price
FROM menu
WHERE price > 100.00
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
    position,
    salary
FROM staff
WHERE salary < 100000.00
GROUP BY 1
ORDER BY 2;

SELECT
    firstname || ' ' || lastname AS fullname,
    phone,
    email
FROM customer
WHERE email LIKE '%gmail.us';

SELECT
    firstname || ' ' || lastname AS fullname,
    phone,
    email
FROM customer
WHERE email REGEXP '.+@gmail.jp$';
