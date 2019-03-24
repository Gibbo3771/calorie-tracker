SET client_min_messages TO WARNING;

INSERT INTO profiles (
first_name,
last_name, 
date_of_birth,
gender, 
height, 
weight
) VALUES (
    'John',
    'Doe',
    to_date('1947-07-30', 'YYYYMMDD'),
    'Male',
    '188',
    '111'
);

DECLARE @i int = 0

WHILE @x < 50
BEGIN
    SET @x = @x + 1
    
END
