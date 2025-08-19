
-- ============================================
--   ONLINE BOOK STORE PROJECT (PostgreSQL)
-- ============================================

-- =======================
--  TABLE CREATION
-- =======================


CREATE TABLE books(
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(100),
    Published_Year INT,
    Price NUMERIC(10,2),
    Stock INT
);

CREATE TABLE customers(
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(100),
    City VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Orders(
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES customers(Customer_ID),
    Book_ID INT REFERENCES books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10,2)
);

-- NOTE: Import data into books, customers, and orders tables via CSV
