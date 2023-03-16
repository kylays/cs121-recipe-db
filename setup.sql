-- CS 121 Final Project
-- Kyla Yu-Swanson and Riya Shrivastava 

DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS recipe;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS compound_ingredient;
DROP TABLE IF EXISTS ingredient_amounts;
DROP TABLE IF EXISTS cost;

CREATE TABLE users (
  -- a username specified by the user, must be unique
  user_id             VARCHAR(100),
  first_name          VARCHAR(100),
  last_name           VARCHAR(100),
  password_phrase     VARCHAR(100) NOT NULL
  PRIMARY KEY (user_id)
);

CREATE TABLE chefs (
  user_id             VARCHAR(100) NOT NULL,
  -- a rating such as amateur, professional, homecook, ect.
  experience_level    VARCHAR(100),
  -- a chef's area of expertise, such as pasty chefs being experts in pastries
  specialization      VARCHAR(100),
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users
)

CREATE TABLE recipes (
  recipe_id         INT AUTO_INCREMENT,
  recipe_name       VARCHAR(100) NOT NULL,
  subcategory       VARCHAR(100) NOT NULL,
  directions        VARCHAR(5000) NOT NULL,
  PRIMARY KEY (recipe_id)
);

CREATE TABLE categories (
  category           VARCHAR(100) NOT NULL,
  subcategory        VARCHAR(100) NOT NULL,
  PRIMARY KEY (category, subcategory),
  FOREIGN KEY (subcategory) REFERENCES recipes
);

CREATE TABLE ingredient_amounts (
  recipe_id         INT NOT NULL,
  ingredient_name   VARCHAR(100) NOT NULL,
  quantity          NUMERIC(5, 3) NOT NULL,
  -- unit may be null for items such as egg where the egg is a unit
  unit              VARCHAR(50),
  PRIMARY KEY (recipe_id, ingredient_name),
  FOREIGN KEY (recipe_id) REFERENCES recipes
);

-- This is an extra feature that may or may not be implemented.
CREATE TABLE ratings (
  recipe_id         INT NOT NULL,
  user_id           VARCHAR(100) NOT NULL,
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
CREATE INDEX recipe_id_idx ON recipes (recipe_id);