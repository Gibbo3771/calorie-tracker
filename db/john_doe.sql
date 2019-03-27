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


INSERT INTO foods (
    food_name
) VALUES 
('Fillet steak'),
('Rump steak'),
('Chicken breast'),
('Egg'),
('Brown bread'),
('Rice'),
('Ben and Jerrys Cookie Dough'),
('Maximuscle millnaire shortcake'),
('Mars bar'),
('Yazoo banana'),
('Goodfellas pizza');

INSERT INTO food_logs (
    profile_id,
    food_id,
    calories,
    datestamp,
    timestamp
) VALUES
( 1, 1, 200, CURRENT_DATE, localtime(0)),
( 1, 5,300, CURRENT_DATE, localtime(0)),
( 1, 7,500, CURRENT_DATE, localtime(0)),
( 1, 1, 500, CURRENT_DATE, localtime(0));