-- Create additional databases
CREATE DATABASE IF NOT EXISTS mywebapp;
CREATE DATABASE IF NOT EXISTS logging;

-- Create users with specific privileges
CREATE USER IF NOT EXISTS 'webuser'@'%' IDENTIFIED BY 'userpassword';
CREATE USER IF NOT EXISTS 'readonly'@'%' IDENTIFIED BY 'readonlypass';

-- Grant privileges to webuser
GRANT ALL PRIVILEGES ON mywebapp.* TO 'webuser'@'%';
GRANT SELECT ON logging.* TO 'webuser'@'%';

-- Grant read-only access to readonly user
GRANT SELECT ON mywebapp.* TO 'readonly'@'%';
GRANT SELECT ON logging.* TO 'readonly'@'%';

-- Create sample table in mywebapp database
USE mywebapp;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL
);

-- Create sample table in logging database
USE logging;

CREATE TABLE IF NOT EXISTS access_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ip_address VARCHAR(45) NOT NULL,
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    endpoint VARCHAR(255) NOT NULL,
    user_agent TEXT
);

-- Insert some initial data as an example
USE mywebapp;
INSERT INTO users (username, email, password_hash) VALUES 
('admin', 'admin@example.com', 'hashed_password_placeholder'),
('testuser', 'testuser@example.com', 'another_hashed_password');

-- Flush privileges to ensure changes take effect
FLUSH PRIVILEGES;