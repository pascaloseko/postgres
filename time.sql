DO $$
DECLARE
    start_at CONSTANT time := now();
BEGIN
    RAISE NOTICE 'Start executing block at %', start_at;
END $$;