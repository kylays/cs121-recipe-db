-- CS 121 Final Project
-- Kyla Yu-Swanson and Riya Shrivastava 

DROP DATABASE IF EXISTS recipe-db;
CREATE DATABASE recipe-db;
USE recipe-db;

DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS chefs;
DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS compound_ingredient;
DROP TABLE IF EXISTS ingredient_amounts;
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS cost;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  -- a user_id  specified by the user, must be unique
  user_id             VARCHAR(20),
  first_name          VARCHAR(25) DEFAULT 'Anonymous',
  last_name           VARCHAR(25) DEFAULT 'Anonymous',
  pw_hash             BINARY(64) NOT NULL,
  pw_salt             CHAR(8) NOT NULL,
  PRIMARY KEY (user_id)
);

-- if a user_id is in chefs, then the user is a chef and has chef privilges 
-- to add recipes to the database
CREATE TABLE chefs (
  user_id             VARCHAR(20) NOT NULL,
  -- a rating such as amateur, professional, homecook, ect.
  exp_level           VARCHAR(100),
  -- a chef's area of expertise, such as pasty chefs being experts in pastries
  specialization      VARCHAR(100),
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users
);

CREATE TABLE categories (
  category           VARCHAR(100) NOT NULL,
  subcategory        VARCHAR(100) NOT NULL,
  PRIMARY KEY (category, subcategory)
);

CREATE TABLE recipes (
  recipe_id         INT AUTO_INCREMENT,
  recipe_name       VARCHAR(100) NOT NULL,
  subcategory       VARCHAR(100) NOT NULL,
  directions        VARCHAR(5000) NOT NULL,
  -- the chef who created the recipe
  -- note: this user_id should never be displayed to the client, only the first 
  -- and last name of the chef (handle in app.py)
  -- user_id             VARCHAR(20),
  PRIMARY KEY (recipe_id),
  FOREIGN KEY (subcategory) REFERENCES categories,
  -- FOREIGN KEY (user_id) REFERENCES users
);

-- stores the favorite recipes of users
CREATE TABLE favorites (
  user_id           VARCHAR(20) NOT NULL,
  recipe_id         INT,
  PRIMARY KEY (user_id, recipe_id),
  FOREIGN KEY (user_id) REFERENCES users,
  FOREIGN KEY (subcategory) REFERENCES recipes
);

CREATE TABLE ingredient_amounts (
  recipe_id         INT NOT NULL,
  ingredient_name   VARCHAR(20) NOT NULL,
  quantity          NUMERIC(5, 3) NOT NULL,
  -- unit may be null for items such as egg where the egg is a unit
  unit              VARCHAR(50),
  PRIMARY KEY (recipe_id, ingredient_name),
  FOREIGN KEY (recipe_id) REFERENCES recipes
);

-- This is an extra feature that may or may not be implemented.
CREATE TABLE ratings (
  recipe_id         INT NOT NULL,
  user_id           VARCHAR(20) NOT NULL,
  -- a rating out of 5
  stars             NUMERIC(5, 0) NOT NULL,
  rated_on          TIMESTAMP,
  review            VARCHAR(1000),
  PRIMARY KEY (recipe_id, user_id),
  FOREIGN KEY (recipe_id) REFERENCES recipes,
  FOREIGN KEY (user_id) REFERENCES users
);

-- This is an extra feature that may or may not be implemented.
CREATE TABLE cost (
  ingredient_name   INT NOT NULL,
  quantity          NUMERIC(5, 3) NOT NULL,
  -- in dollars
  price             NUMERIC(5, 2) NOT NULL,
  unit              VARCHAR(50),
  PRIMARY KEY (ingredient_name, quantity),
  FOREIGN KEY (ingredient_name) REFERENCES ingredient_amounts
);

-- Indices 
CREATE INDEX recipe_name_idx ON recipes (recipe_name);