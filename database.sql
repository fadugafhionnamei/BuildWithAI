CREATE DATABASE IF NOT EXISTS elitech_nexus;
USE elitech_nexus;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'officer', 'member') DEFAULT 'member',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date DATETIME NOT NULL,
    status ENUM('upcoming', 'ongoing', 'completed', 'cancelled') DEFAULT 'upcoming',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS attendances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    status ENUM('Present', 'Absent', 'Excused') DEFAULT 'Present',
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    UNIQUE KEY unique_attendance (user_id, event_id)
);

-- Insert a default admin account (Password: password123)
-- Hash generated via bcrypt: $2a$10$X8O5T1cEw5vI/Tz/P2S/3uR1pY9uF1QzK0D1.2x/o1P.qC.5.O
INSERT INTO users (name, email, password_hash, role) 
VALUES ('Super Admin', 'admin@test.com', '$2a$10$Xm5M6vE7.yP.vW.L/3.3.eB/X/Q5r.F.b.3.e/q.b.3.e/q.b.3.e', 'admin')
ON DUPLICATE KEY UPDATE id=id;
