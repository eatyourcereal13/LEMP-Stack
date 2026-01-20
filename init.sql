CREATE DATABASE IF NOT EXISTS some_db;
CREATE USER IF NOT EXISTS 'webuser'@'localhost' IDENTIFIED BY 'mega_pass_777';
GRANT SELECT, INSERT, UPDATE, DELETE ON some_db.* TO 'webuser'@'localhost';
FLUSH PRIVILEGES;

USE some_db;

CREATE TABLE IF NOT EXISTS some_table (
    id INT PRIMARY KEY AUTO_INCREMENT,
    text VARCHAR(255)
);
INSERT IGNORE INTO some_table (id,text) VALUES (1,'Привет'),(2,'Мир'),(3,'Эту строчку не видим');