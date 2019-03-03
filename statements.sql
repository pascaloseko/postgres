-- IF statement --
-- DO $$
-- DECLARE
--     a integer := 10;
--     b integer := 20;
-- BEGIN
--     IF a > b THEN
--         RAISE NOTICE 'a is greater than b';
--     END IF;

--     IF a < b THEN
--         RAISE NOTICE 'a is less than b';
--     END IF;

--     IF a = b THEN
--         RAISE NOTICE 'a is equal to b';
--     END IF;
-- END; $$

-- IF THEN ELSE statement --
-- DO $$
-- DECLARE
--     a integer := 10;
--     b integer := 20;
-- BEGIN
--     IF a > b THEN
--         RAISE NOTICE 'a is greater than b';
--     ELSE
--         RAISE NOTICE 'a is less than b';
--     END IF;
-- END; $$

-- IF THEN ELSIF THEN ELSE statement --
-- DO $$
-- DECLARE
--     a integer := 10;
--     b integer := 10;
-- BEGIN
--     IF a > b THEN
--         RAISE NOTICE 'a is greater than b';
--     ELSIF a < b THEN
--         RAISE NOTICE 'a is less than b';
--     ELSE
--         RAISE NOTICE 'a is equal to b';
--     END IF;
-- END; $$

-- CASE Statement --
-- CREATE OR REPLACE FUNCTION get_price_segment(p_film_id integer)
-- RETURNS VARCHAR(50) AS $$
-- DECLARE
--     rate NUMERIC;
--     price_segment VARCHAR(50);
-- BEGIN
--     -- get the rate based on film_id
--     SELECT INTO rate rental_rate
--     FROM film
--     WHERE film_id=p_film_id;

--     CASE rate
--         WHEN 0.99 THEN price_segment = 'Mass';
--         WHEN 2.99 THEN price_segment = 'Mainstream';
--         WHEN 4.99 THEN price_segment = 'High end';
--     ELSE
--         price_segment = 'Unspecified';
--     END CASE;
--     RETURN price_segment;
-- END; $$
-- LANGUAGE plpgsql

-- Searched CASE statement --
-- CREATE OR REPLACE FUNCTION get_customer_service(p_customer_id integer)
-- RETURNS VARCHAR(25) AS $$
-- DECLARE
--     total_payment NUMERIC;
--     service_level VARCHAR(25);
-- BEGIN
--     -- get the total_payment based on customer id
--     SELECT INTO total_payment SUM(amount)
--     FROM payment
--     WHERE customer_id = p_customer_id;

--     CASE
--         WHEN total_payment > 200 THEN service_level = 'Platinum';
--         WHEN total_payment > 100 THEN service_level = 'Gold';
--         ELSE
--             service_level = 'Silver';
--     END CASE;
--     RETURN service_level;
-- END; $$
-- LANGUAGE plpgsql

--  LOOP statement --
-- CREATE OR REPLACE FUNCTION fibonacci(n integer)
-- RETURNS INTEGER AS $$
-- DECLARE
--     c INTEGER := 0; -- c
--     i INTEGER := 0;
--     j INTEGER := 1;
-- BEGIN
--     IF (n < 1) THEN
--         RETURN 0;
--     END IF;

--     LOOP
--         EXIT WHEN c = n;
--         c := c + 1;
--         SELECT j, i + j INTO i, j;
--     END LOOP;
--     RETURN i;
-- END; $$
-- LANGUAGE plpgsql

-- WHILE loop --
-- CREATE OR REPLACE FUNCTION fibonacci (n INTEGER) 
--  RETURNS INTEGER AS $$ 
-- DECLARE
--    c INTEGER := 0 ; -- counter
--    i INTEGER := 0 ; 
--    j INTEGER := 1 ;
-- BEGIN
 
--  IF (n < 1) THEN
--  RETURN 0 ;
--  END IF; 
 
--  WHILE c <= n LOOP
--  c := c + 1 ; 
--  SELECT j, i + j INTO i, j ;
--  END LOOP ; 
 
--  RETURN i ;
-- END ; $$
-- LANGUAGE plpgsql

-- FOR loop statement --
-- Loop through 1 to 5 and print out a message in each iteration. The counter takes 1, 2, 3, 4, 5
-- DO $$
-- BEGIN
--     FOR counter IN 1..5
--     LOOP
--         RAISE NOTICE 'Counter: %', counter;
--     END LOOP;
-- END; $$

-- Loop through 5 to 1 and print a message in each iteration. The counter takes 5, 4, 3, 2, 1
-- DO $$
-- BEGIN
--     FOR counter IN REVERSE 5..1
--     LOOP
--         RAISE NOTICE 'Counter: %', counter;
--     END LOOP;
-- END; $$

-- Loop through 1 to 6, and print out the counter in each loop iteration. The counter takes 1, 3, 5. 
-- In each iteration, PostgreSQL adds 2 to the counter.
-- DO $$
-- BEGIN
--     FOR counter IN 1..6 BY 2
--     LOOP
--         RAISE NOTICE 'Counter: %', counter;
--     END LOOP;
-- END; $$

-- FOR loop for looping through a query result
-- CREATE OR REPLACE FUNCTION for_loop_through_query(
--     n INTEGER DEFAULT 10
-- )
-- RETURNS VOID AS $$
-- DECLARE
--     rec RECORD;
-- BEGIN
--     FOR rec IN SELECT title
--         FROM film
--         ORDER BY title
--         LIMIT n
--     LOOP
--         RAISE NOTICE '%', rec.title;
--     END LOOP;
-- END; $$
-- LANGUAGE plpgsql

-- FOR loop for looping through a query result of a dynamic query
CREATE OR REPLACE FUNCTION for_loop_through_dyn_query(
    sort_type INTEGER,
    n INTEGER
)
RETURNS VOID AS $$
DECLARE
    rec RECORD;
    query TEXT;
BEGIN

    query := 'SELECT title, release_year FROM film ';
    IF sort_type = 1 THEN
        query := query || 'ORDER BY title ';
    ELSIF sort_type = 2 THEN
        query := query || 'ORDER BY release_year ';
    ELSE
        RAISE EXCEPTION 'Invalid sort_type: %', sort_type;
    END IF;

    query := query || 'LIMIT $1';

    FOR rec IN EXECUTE query USING n
    LOOP
        RAISE NOTICE '% - %', rec.release_year, rec.title;
    END LOOP;

END; $$
LANGUAGE plpgsql
