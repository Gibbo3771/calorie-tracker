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

CREATE TABLE calorie_intakes (
    id SERIAL4 PRIMARY KEY,
    profile_id INT REFERENCES profiles(id) ON DELETE CASCADE,
    calories INT,
    datestamp DATE,
    timestamp TIME
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