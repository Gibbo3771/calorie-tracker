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

INSERT INTO calorie_intakes (
    profile_id,
    calories,
    datestamp
) VALUES
( 1, 200, to_date('2019-03-25', 'YYYYMMDD')),
( 1, 300, to_date('2019-03-25', 'YYYYMMDD')),
( 1, 500, to_date('2019-03-25', 'YYYYMMDD')),
( 1, 500, to_date('2019-03-25', 'YYYYMMDD'));
