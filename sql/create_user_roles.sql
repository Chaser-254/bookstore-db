-- Sample MySQL User and Role Setup
CREATE USER 'bookstore_user'@'localhost' IDENTIFIED BY 'securepassword';
GRANT SELECT, INSERT, UPDATE, DELETE ON BookStore.* TO 'bookstore_user'@'localhost';