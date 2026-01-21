-- создаю базу данных если она не существует
CREATE DATABASE IF NOT EXISTS some_db;
-- создаю пользователя с паролем (только localhost для безопасности)
CREATE USER IF NOT EXISTS 'webuser'@'localhost' IDENTIFIED BY 'mega_pass_777';
-- даю минимальные необходимые права на БД этому пользователю
GRANT SELECT, INSERT, UPDATE, DELETE ON some_db.* TO 'webuser'@'localhost';
-- применяем изменение прав
FLUSH PRIVILEGES;

-- используем только что созданную ДБ
USE some_db;

-- создаю таблицу для хранения текстовых данных
CREATE TABLE IF NOT EXISTS some_table (
    id INT PRIMARY KEY AUTO_INCREMENT, -- уникальный ID с AUTO_INCREMENT
    text VARCHAR(255) -- текст
);

-- тестовые данные 
INSERT IGNORE INTO some_table (id,text) VALUES (1,'Привет'),(2,'Мир'),(3,'Эту строчку не видим'); 