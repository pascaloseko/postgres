DO $$
DECLARE
    VAT CONSTANT NUMERIC := 0.1;
    net_price NUMERIC := 20.5;
BEGIN
    RAISE NOTICE 'The selling price is %', net_price * (1 + VAT);
END $$;