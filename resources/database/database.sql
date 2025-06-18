-- Create the database schema
CREATE SCHEMA IF NOT EXISTS `user_db`;

-- Select the schema for use
USE `user_db`;

-- Create the users table
CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address VARCHAR(250) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Optional: Insert initial user data (example only)
INSERT INTO user (name, email, address)
VALUES ("John Smith", "john@gmail.com", "23 Colobo 3");
