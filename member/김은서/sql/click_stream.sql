DROP TABLE click_stream;
DROP TABLE click_stream_cart;

SET SESSION net_read_timeout = 600;
SET SESSION net_write_timeout = 600;
SET SESSION max_execution_time = 300000;

CREATE TABLE click_stream (
session_id VARCHAR(50),
event_name VARCHAR(20),
event_time VARCHAR(30),
event_id VARCHAR(40),
traffic_source VARCHAR(10),
event_metadata TEXT
);

LOAD DATA LOCAL INFILE 'C:/Users/user/Desktop/workspace/Datathon/data/click_stream.csv'
INTO TABLE click_stream
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(session_id, event_name, event_time, event_id, traffic_source, event_metadata);

CREATE TEMPORARY TABLE session_ids AS
SELECT DISTINCT session_id FROM click_stream;

SELECT COUNT(DISTINCT session_id) AS unique_session_count
FROM click_stream;


-- event_name 목록
SELECT DISTINCT event_name
FROM click_stream;

SELECT count(*)
FROM (
    SELECT event_metadata
    FROM click_stream
    WHERE event_metadata IS NOT NULL AND event_metadata != ''
) AS sub;

SELECT session_id, event_name, event_metadata
FROM (
    SELECT *
    FROM click_stream
    WHERE event_metadata IS NOT NULL AND event_metadata != ''
    limit 200
) AS limit_sub;

CREATE TABLE click_stream_cart LIKE click_stream;

INSERT INTO click_stream_cart
SELECT * FROM click_stream
WHERE event_name = 'ADD_TO_CART'
  AND event_metadata IS NOT NULL
  AND event_metadata != ''
LIMIT 50000 OFFSET 0;

INSERT INTO click_stream_cart
SELECT * FROM click_stream
WHERE event_name = 'ADD_TO_CART'
  AND event_metadata IS NOT NULL
  AND event_metadata != ''
LIMIT 50000 OFFSET 50000;

INSERT INTO click_stream_cart
SELECT * FROM click_stream
WHERE event_name = 'ADD_TO_CART'
  AND event_metadata IS NOT NULL
  AND event_metadata != ''
LIMIT 50000 OFFSET 100000;

select *
from click_stream_cart
;

SELECT distinct event_name
FROM (
    SELECT *
    FROM click_stream
    WHERE event_metadata IS NOT NULL AND event_metadata != ''
) as sub;

SELECT session_id, event_name, event_metadata
FROM (
select *
from click_stream
WHERE event_name = 'ADD_TO_CART'
  AND event_metadata IS NOT NULL
  AND event_metadata != ''
  limit 100
  ) as sub;
  
  SELECT session_id, event_name, event_metadata
FROM (
select *
from click_stream
WHERE event_name = 'BOOKING'
  AND event_metadata IS NOT NULL
  AND event_metadata != ''
  limit 100
  ) as sub;
  
  SELECT distinct event_metadata
FROM (
select *
from click_stream
WHERE event_name = 'BOOKING'
  AND event_metadata IS NOT NULL
  AND event_metadata != ''
  limit 100
  ) as sub;
  
SELECT session_id, event_name, event_metadata
FROM (
select *
from click_stream
WHERE event_name = 'SEARCH'
  AND event_metadata IS NOT NULL
  AND event_metadata != ''
  limit 100
  ) as sub;
  
SELECT session_id, event_name, event_metadata
FROM (
select *
from click_stream
WHERE event_name = 'ADD_PROMO'
  AND event_metadata IS NOT NULL
  AND event_metadata != ''
  limit 100
  ) as sub;
  
CREATE TABLE click_stream_add_to_cart AS
SELECT *
FROM click_stream
WHERE event_name = 'ADD_TO_CART';

SELECT count(*)
FROM click_stream_add_to_cart;

CREATE VIEW click_stream_add_to_cart_view AS
SELECT *
FROM click_stream
WHERE event_name = 'ADD_TO_CART';

desc click_stream_add_to_cart_view;

select *
from click_stream_add_to_cart
limit 2000;