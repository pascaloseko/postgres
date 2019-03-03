-- A PL/pgSQL cursor allows us to encapsulate a query and process each individual row at a time
-- The following get_film_titles(integer) function accepts an argument that represents the release year
-- of a film inside the function, we query all films whose release year equals to the released year passed to
-- a function.We use the cursor to loop through the rows and concatenate the title and release year of film
-- that has the title contains the ful word
CREATE OR REPLACE FUNCTION get_film_titles(p_year INTEGER)
RETURNS TEXT AS $$
DECLARE
    titles TEXT DEFAULT '';
    rec_film RECORD;
    cur_films CURSOR(p_year INTEGER)
    FOR SELECT title, release_year
    FROM film
    WHERE release_year=p_year;
BEGIN
    -- Open the cursor
    OPEN cur_films(p_year);

    LOOP
    -- fetch rows into the film
        FETCH cur_films INTO rec_film;
    -- exit when no more row to fetch
        EXIT WHEN NOT FOUND;

    -- build the output
        IF rec_film.title LIKE '%ful%' THEN
            titles := titles || ',' || rec_film.title || ':' || rec_film.release_year;
        END IF;
    END LOOP;

    -- close the cursor
    CLOSE cur_films;

    RETURN titles;
END; $$
LANGUAGE plpgsql