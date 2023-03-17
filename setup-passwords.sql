-- File for Password Management section of Final Project

DROP FUNCTION IF EXISTS make_salt;
DROP PROCEDURE IF EXISTS sp_add_user;
DROP PROCEDURE IF EXISTS sp_add_user_with_name;
DROP PROCEDURE IF EXISTS sp_add_chef;
DROP FUNCTION IF EXISTS authenticate;
DROP PROCEDURE IF EXISTS sp_change_password;

-- (Provided) This function generates a specified number of characters for using as a
-- salt in passwords.
DELIMITER !
CREATE FUNCTION make_salt(num_chars INT) 
RETURNS VARCHAR(20) NOT DETERMINISTIC
BEGIN
    DECLARE salt VARCHAR(20) DEFAULT '';

    -- Don't want to generate more than 20 characters of salt.
    SET num_chars = LEAST(20, num_chars);

    -- Generate the salt!  Characters used are ASCII code 32 (space)
    -- through 126 ('z').
    WHILE num_chars > 0 DO
        SET salt = CONCAT(salt, CHAR(32 + FLOOR(RAND() * 95)));
        SET num_chars = num_chars - 1;
    END WHILE;

    RETURN salt;
END !
DELIMITER ;

-- NOTE: user_info is defined in setup.sql as users

-- [Problem 1a]
-- Adds a new user to the user_info table, using the specified password (max
-- of 20 characters). Salts the password with a newly-generated salt value,
-- and then the salt and hash values are both stored in the table.
DELIMITER !
CREATE PROCEDURE sp_add_user(new_username VARCHAR(20), password VARCHAR(20))
BEGIN
  DECLARE salt CHAR(8);
  SELECT make_salt(8) INTO salt;
  INSERT INTO users(user_id, pw_hash, pw_salt) 
    VALUES (new_username, SHA2(CONCAT(password, salt), 256), salt);
END !
DELIMITER ;

-- Adds a new user with a first and last name if a user wants to use their name.
DELIMITER !
CREATE PROCEDURE sp_add_user_with_name(
  new_username  VARCHAR(20), 
  password      VARCHAR(20),
  first_name    VARCHAR(25),
  last_name     VARCHAR(25))
BEGIN
  DECLARE salt CHAR(8);
  SELECT make_salt(8) INTO salt;
  INSERT INTO users(user_id, first_name, last_name, pw_hash, pw_salt) 
    VALUES (
      new_username, 
      first_name, 
      last_name, 
      SHA2(CONCAT(password, salt), 256), 
      salt);
END !
DELIMITER ;

-- Makes a user into a chef by adding their information to the chefs table.
DELIMITER !
CREATE PROCEDURE sp_add_chef( 
  username         VARCHAR(20), 
  exp_level        VARCHAR(100),
  specialization   VARCHAR(100))
BEGIN
  INSERT INTO chefs(user_id, exp_level, specialization) 
    VALUES (username, exp_level, specialization);
END !
DELIMITER ;

-- [Problem 1b]
-- Authenticates the specified username and password against the data
-- in the user_info table.  Returns 1 if the user appears in the table, and the
-- specified password hashes to the value for the user. Otherwise returns 0.
DELIMITER !
CREATE FUNCTION authenticate(username VARCHAR(20), password VARCHAR(20))
RETURNS TINYINT DETERMINISTIC
BEGIN
  DECLARE salt CHAR(8);
  DECLARE pw_hashed BINARY(64);
  SELECT pw_salt INTO salt FROM users WHERE user_id = username;
  SELECT pw_hash INTO pw_hashed FROM users WHERE user_id = username;
  IF SHA2(CONCAT(password, salt), 256) = pw_hashed THEN RETURN 1; ELSE RETURN 0; 
  END IF;
END !
DELIMITER ;

-- [Problem 1c]
-- Add at least two users into your user_info table so that when we run this file,
-- we will have examples users in the database.
CALL sp_add_user('Newt9', 'password123!');
CALL sp_add_user_with_name('ChefJohn', '3a+ingShr1mp', 'John', 'Doe');
CALL sp_add_chef('ChefJohn', 'Professional', 'Sous-chef');
CALL sp_add_user_with_name('kyuswans', 'ch0co1at3', 'Kyla', 'Yu-Swanson');
CALL sp_add_user_with_name('AppleMan1', '*mac0S*', 'Steve', 'Jobs');

-- [Problem 1d]
-- Optional: Create a procedure sp_change_password to generate a new salt and change the given
-- user's password to the given password (after salting and hashing)
DELIMITER !
CREATE PROCEDURE sp_change_password(username VARCHAR(20), new_password VARCHAR(20))
BEGIN
  DECLARE user_exists TINYINT;
  DECLARE salt CHAR(8);
  SELECT EXISTS(SELECT user_id FROM users WHERE user_id = username) 
    INTO user_exists;
  SELECT make_salt(8) INTO salt;
  IF user_exists THEN 
    UPDATE users SET 
      pw_hash = SHA2(CONCAT(new_password, salt), 256), 
      pw_salt = salt 
    WHERE user_id = username;
  END IF;
END !
DELIMITER ;
