SET client_min_messages TO WARNING;

CREATE TABLE settings (
    id SERIAL4 PRIMARY KEY,
    metric boolean DEFAULT TRUE NOT NULL 
);

CREATE TABLE profiles (
    id SERIAL4 PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(255),
    height VARCHAR(255),
    weight VARCHAR(255)
);