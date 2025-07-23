CREATE DATABASE Datathon;
SHOW databases;
USE datathon;
SHOW VARIABLES LIKE 'local_infile';



ALTER TABLE click_stream MODIFY COLUMN event_time DATETIME(6);



DROP TABLE customer;

CREATE TABLE customer (
    customer_id INT NOT NULL,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    username VARCHAR(40),
    email VARCHAR(60),
    gender CHAR(1),
    birthdate DATE,
    device_type VARCHAR(10),
    device_id VARCHAR(40),
    device_version VARCHAR(45),
    home_location_lat DECIMAL(25, 25),
    home_location_long DECIMAL(25, 25),
    home_location VARCHAR(20),
    home_country VARCHAR(10),
    first_join_date DATE,
    PRIMARY KEY (customer_id)
);

LOAD DATA LOCAL INFILE 'C:/Users/user/Desktop/workspace/Datathon/data/customer.csv'
INTO TABLE customer
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE product;

CREATE TABLE product (
product_id INT,
gender VARCHAR(10),
masterCategory VARCHAR(50),
subCategory VARCHAR(50),
articleType VARCHAR(50),
baseColour VARCHAR(30),
season VARCHAR(10),
year INT,
`usage` VARCHAR(20),  #usage는 sql에서 단어로 인식x, ``로 감싸줌
productDisplayName VARCHAR(100)
);

LOAD DATA LOCAL INFILE 'C:/Users/user/Desktop/workspace/Datathon/data/product_cleaned(2).csv'
INTO TABLE product
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE transactions (
    created_at DATETIME,
    customer_id INT,
    booking_id VARCHAR(50),
    session_id VARCHAR(50),
    product_metadata TEXT,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    promo_amount INT,
    promo_code VARCHAR(50),
    shipment_fee INT,
    shipment_date_limit DATETIME,
    shipment_location_lat DOUBLE,
    shipment_location_long DOUBLE,
    total_amount INT
);

LOAD DATA LOCAL INFILE 'C:/Users/user/Desktop/workspace/Datathon/data/transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
