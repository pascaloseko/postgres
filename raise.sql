DO $$ 
DECLARE 
 counter integer := -1;
BEGIN 
   ASSERT counter = 0 
   MESSAGE 'Expect counter starts with 0';
END $$;