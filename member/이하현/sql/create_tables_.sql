USE my_database;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile =1;
DROP TABLE IF EXISTS product;
CREATE TABLE product (
product_id INT,
gender VARCHAR(10),
masterCategory VARCHAR(50),
subCategory VARCHAR(50),
articleType VARCHAR(50),
baseColour VARCHAR(30),
season VARCHAR(10),
year INT,
`usage` VARCHAR(20),
productDisplayName VARCHAR(100)
);

LOAD DATA LOCAL INFILE '/Users/hapresent/Desktop/데이터톤/archive/product_nullfix.csv'
INTO TABLE product
FIELDS TERMINATED BY ','
-- 구분자
ENCLOSED BY '"'
-- 문자열 구분자
LINES TERMINATED BY '\n'
-- 줄바꿈 문자
IGNORE 1 ROWS;
-- 헤더는 테이블에 넣지 않음.

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

LOAD DATA LOCAL INFILE '/Users/hapresent/Desktop/데이터톤/archive/transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
-- 구분자
ENCLOSED BY '"'
-- 문자열 구분자
LINES TERMINATED BY '\n'
-- 줄바꿈 문자
IGNORE 1 ROWS;
-- 헤더는 테이블에 넣지 않음.

DROP TABLE IF EXISTS click_stream;
CREATE TABLE click_stream (
session_id VARCHAR(50),
event_name VARCHAR(20),
event_time VARCHAR(30),
event_id VARCHAR(40),
traffic_source VARCHAR(10),
event_metadata VARCHAR(70)
);
LOAD DATA LOCAL INFILE '/Users/hapresent/Desktop/데이터톤/archive/click_stream.csv' 
INTO TABLE click_stream
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;
-- 헤더는 테이블에 넣지 않음.


CREATE TABLE Customer (
customer_id INT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
username VARCHAR(100),
email VARCHAR(100),
gender ENUM('M', 'F') DEFAULT 'F',
birthdate DATE,
device_type VARCHAR(100),
device_id VARCHAR(100),
device_version VARCHAR(100),
home_location_lat DECIMAL(22,20),
home_location_long DECIMAL(18,15),
home_location VARCHAR(100),
home_country VARCHAR(100),
first_join_date DATE
);
LOAD DATA LOCAL INFILE '/Users/hapresent/Desktop/데이터톤/archive/customer.csv' 
INTO TABLE customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;
-- 헤더는 테이블에 넣지 않음.
