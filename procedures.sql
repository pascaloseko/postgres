-- CREATE TABLE accounts (
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(100) NOT NULL,
--     balance DEC(15,2) NOT NULL
-- );
 
-- INSERT INTO accounts(name,balance)
-- VALUES('Bob',10000);
 
-- INSERT INTO accounts(name,balance)
-- VALUES('Alice',10000);

-- The following example creates stored procedure named transfer that transfer specific amount of 
-- money from one account to another.

CREATE OR REPLACE PROCEDURE transfer(INT, INT, DEC)
LANGUAGE plpgsql
AS $$
BEGIN
    -- substracting amount from the sender's moneey
    UPDATE accounts
    SET balance = balance - $3
    WHERE id = $2;

    COMMIT;
END; $$;