CREATE USER 'test_user'@'localhost' identified with mysql_native_password by 'passwordtest';
GRANT ALL PRIVILEGES ON geodata._cities TO 'test_user'@'localhost';
FLUSH privileges;