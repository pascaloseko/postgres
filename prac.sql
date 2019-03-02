DO $$
DECLARE
    created_at time := NOW();
BEGIN
    RAISE NOTICE '%', created_at;
    PERFORM pg_sleep(10);
    RAISE NOTICE '%', created_at;
END $$;