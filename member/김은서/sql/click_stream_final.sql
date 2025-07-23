CREATE TABLE click_stream (
    session_id VARCHAR(100),
    event_name VARCHAR(50),
    event_time DATETIME(6),
    event_id VARCHAR(100),
    traffic_source VARCHAR(50),
    event_metadata TEXT
);

LOAD DATA LOCAL INFILE 'C:/Users/user/Desktop/workspace/Datathon/data/click_stream.csv'
INTO TABLE click_stream
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(session_id, event_name, event_time, event_id, traffic_source, event_metadata);

CREATE OR REPLACE VIEW view_click_stream_add_to_cart AS
SELECT
    session_id,
    event_name,
    event_time,
    event_id,
    traffic_source,
    event_metadata,

    -- product_id
    CASE
        WHEN event_name = 'ADD_TO_CART' THEN
            REPLACE(
                TRIM(BOTH '\'' FROM
                    SUBSTRING_INDEX(SUBSTRING_INDEX(event_metadata, 'product_id', -1), ',', 1)
                ),
                ': ',
                ''
            )
    END AS product_id,

    -- quantity
    CASE
        WHEN event_name = 'ADD_TO_CART' THEN
            REPLACE(
                TRIM(BOTH '\'' FROM
                    SUBSTRING_INDEX(SUBSTRING_INDEX(event_metadata, 'quantity', -1), ',', 1)
                ),
                ': ',
                ''
            )
    END AS quantity,

    -- item_price
    CASE
        WHEN event_name = 'ADD_TO_CART' THEN
            REPLACE(
                TRIM(BOTH '\'' FROM
                    SUBSTRING_INDEX(SUBSTRING_INDEX(event_metadata, 'item_price', -1), '}', 1)
                ),
                ': ',
                ''
            )
    END AS item_price
FROM click_stream
WHERE event_name = 'ADD_TO_CART';

CREATE OR REPLACE VIEW view_click_stream_booking AS
SELECT
    session_id,
    event_name,
    event_time,
    event_id,
    traffic_source,
    event_metadata,

    CASE
        WHEN event_name = 'BOOKING' THEN
            TRIM(BOTH '\'' FROM
                REPLACE(
                    SUBSTRING_INDEX(SUBSTRING_INDEX(event_metadata, 'payment_status', -1), '}', 1),
                    ': ',
                    ''
                )
            )
        ELSE NULL
    END AS payment_status
FROM click_stream
WHERE event_name = 'BOOKING';

CREATE OR REPLACE VIEW view_click_stream_search AS
SELECT
    session_id,
    event_name,
    event_time,
    event_id,
    traffic_source,
    event_metadata,
    
    CASE
        WHEN event_name = 'SEARCH' THEN
            TRIM(BOTH '\'' FROM
                REPLACE(
                    SUBSTRING_INDEX(SUBSTRING_INDEX(event_metadata, 'search_keywords', -1), '}', 1),
                    ': ',
                    ''
                )
            )
        ELSE NULL
    END AS search_keywords
FROM click_stream
WHERE event_name = 'SEARCH';

CREATE OR REPLACE VIEW view_click_stream_add_promo AS
SELECT
    session_id,
    event_name,
    event_time,
    event_id,
    traffic_source,
    event_metadata,

    CASE
        WHEN event_name = 'ADD_PROMO' THEN
            TRIM(BOTH '\'' FROM
                REPLACE(
                    SUBSTRING_INDEX(SUBSTRING_INDEX(event_metadata, 'promo_code', -1), ',', 1),
                    ': ',
                    ''
                )
            )
        ELSE NULL
    END AS promo_code,

    CASE
        WHEN event_name = 'ADD_PROMO' THEN
            TRIM(BOTH '\'' FROM
                TRIM(BOTH '}' FROM
                    REPLACE(
                        SUBSTRING_INDEX(event_metadata, 'promo_amount', -1),
                        ': ',
                        ''
                    )
                )
            )
        ELSE NULL
    END AS promo_amount
FROM click_stream
WHERE event_name = 'ADD_PROMO';

