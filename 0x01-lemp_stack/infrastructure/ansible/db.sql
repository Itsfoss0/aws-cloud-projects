DROP DATABASE IF EXISTS example_database;
CREATE DATABASE IF NOT EXISTS example_database;
CREATE TABLE example_database.todo_list (
    item_id INT AUTO_INCREMENT,
    content VARCHAR(255),
    PRIMARY KEY(item_id)
);
INSERT INTO example_database.todo_list (content)
VALUES ("My first important item");