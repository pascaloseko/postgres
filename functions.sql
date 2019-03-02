-- EX 1 --
-- CREATE OR REPLACE FUNCTION get_sum(a NUMERIC, b NUMERIC) RETURNS NUMERIC AS $$
-- BEGIN
--     RETURN a + b;
-- END; $$
-- LANGUAGE PLPGSQL;

-- EX 2 --
-- CREATE OR REPLACE FUNCTION hi_lo(
--     a NUMERIC,
--     b NUMERIC,
--     c NUMERIC,
--             OUT hi NUMERIC,
--     OUT lo NUMERIC
-- ) AS $$
-- BEGIN
--     hi := GREATEST(a,b,c);
--     lo := LEAST(a,b,c);
-- END; $$
-- LANGUAGE PLPGSQL

-- EX 3 --
-- CREATE OR REPLACE FUNCTION square(
--     INOUT a NUMERIC
-- ) AS $$
-- BEGIN
--     a := a * a;
-- END; $$
-- LANGUAGE PLPGSQL

-- VARIADIC FUNCTIONS --
-- CREATE OR REPLACE FUNCTION sum_avg(
--     VARIADIC list NUMERIC[],
--     OUT total NUMERIC,
--     OUT average NUMERIC
-- ) AS $$
-- BEGIN
--     SELECT INTO total SUM(list[i])
--     FROM generate_subscripts(list, 1) g(i);

--     SELECT INTO average AVG(list[i])
--     FROM generate_subscripts(list, 1) g(i);
-- END; $$
-- LANGUAGE PLPGSQL

-- FUNCTION OVERLOADING --
-- CREATE OR REPLACE FUNCTION get_rental_duration(
--     p_customer_id INTEGER, 
--     p_from_date DATE DEFAULT '2005-01-01'
-- )
-- RETURNS INTEGER AS $$

-- DECLARE
--     rental_duration INTEGER;
-- BEGIN
--     -- get the rate based on film_id
--     SELECT INTO rental_duration SUM(
--         EXTRACT( DAY FROM return_date + '12:00:00' - rental_date)
--         )
--     FROM rental
--     WHERE customer_id=p_customer_id AND rental_date >= p_from_date;

--     RETURN rental_duration;
-- END; $$
-- LANGUAGE PLPGSQL

-- Function That Returns A Table --
CREATE OR REPLACE FUNCTION get_film(p_pattern VARCHAR, p_year INT)
RETURNS TABLE(
    film_title VARCHAR,
    film_release_year INT
) AS $$
DECLARE
    var_r record;
BEGIN
    FOR var_r IN(
        SELECT title,release_year FROM film WHERE title ILIKE p_pattern
        AND release_year = p_year
        )
    LOOP
        film_title := upper(var_r.title);
        film_release_year := var_r.release_year;
    RETURN NEXT;
    END LOOP;
END; $$
LANGUAGE PLPGSQL
