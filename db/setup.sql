SET client_min_messages TO WARNING;

CREATE TABLE settings (
    id SERIAL4 PRIMARY KEY,
    metric boolean DEFAULT TRUE NOT NULL 
);

CREATE TABLE physical_activity_levels (
    id SERIAL4 PRIMARY KEY,
    physical_activity_level VARCHAR(255),
    descriptor VARCHAR(255),
    bmr_multiplier FLOAT
);

CREATE TABLE foods (
    id SERIAL4 PRIMARY KEY,
    food_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE profiles (
    id SERIAL4 PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(255),
    height VARCHAR(255),
    weight VARCHAR(255),
    physical_activity_level_id INT REFERENCES physical_activity_levels(id) ON DELETE CASCADE
);

CREATE TABLE meal_times (
    id SERIAL4 PRIMARY KEY,
    meal_name VARCHAR(255)
);

CREATE TABLE food_logs (
    id SERIAL4 PRIMARY KEY,
    profile_id INT REFERENCES profiles(id) ON DELETE CASCADE,
    food_id INT REFERENCES foods(id) ON DELETE CASCADE,
    meal_time_id INT REFERENCES meal_times(id) ON DELETE CASCADE,
    weight FLOAT,
    calories INT,
    datestamp DATE,
    timestamp TIME,
    pretty_name VARCHAR(1000)
);


INSERT INTO physical_activity_levels (
    physical_activity_level,
    descriptor,
    bmr_multiplier
) VALUES 
( 'Extremely Inactive', 'Physical movement impaired', 1.40 ),
( 'Sedentary', 'Little not no exercise', 1.52 ),
( 'Moderately Active', 'Active job or running one hour daily', 1.85 ),
( 'Vigorously Active', 'Demanding physical job or swimming two hours daily', 2.15),
( 'Extremely Active', 'Professional Athlete', 2.40 );

INSERT INTO meal_times (
    meal_name
) VALUES
('Breakfast'),
('Lunch'),
('Dinner'),
('Snack')