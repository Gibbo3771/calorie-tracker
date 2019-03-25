SET client_min_messages TO WARNING;

INSERT INTO profiles (
first_name,
last_name, 
date_of_birth,
gender, 
height, 
weight,
physical_activity_level_id
) VALUES (
    'John',
    'Doe',
    to_date('1947-07-30', 'YYYYMMDD'),
    'Male',
    '188',
    '111',
    4
);

INSERT INTO calorie_intakes (
    profile_id,
    calories,
    datestamp
) VALUES
( 1, 200, CURRENT_DATE),
( 1, 300, CURRENT_DATE),
( 1, 500, CURRENT_DATE),
( 1, 500, CURRENT_DATE);
