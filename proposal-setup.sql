-- CS 121 Final Project
-- Kyla Yu-Swanson and Riya Shrivastava 

DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS recipe;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS compound_ingredient;
DROP TABLE IF EXISTS ingredient_amounts;
DROP TABLE IF EXISTS cost;

CREATE TABLE user (
  user_id             VARCHAR(100),
  password_phrase     VARCHAR(100) NOT NULL,
  -- 0 or 1 for if the user is a chef (admin)
  chef               TINYINT DEFAULT 0 NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE recipe (
  recipe_id       INTEGER AUTO_INCREMENT,
  recipe_name     VARCHAR(100) NOT NULL,
  subcategory        VARCHAR(100) NOT NULL,
  directions      VARCHAR(5000) NOT NULL,
  PRIMARY KEY (recipe_id)
);

CREATE TABLE categories (
  category           VARCHAR(100) NOT NULL,
  subcategory        VARCHAR(100) NOT NULL,
  -- Note: there is no primary key since the categoryies and subcategories 
  -- aren't unqiue. Each category has several subcategories.
  FOREIGN KEY (subcategory) REFERENCES recipe
);

CREATE TABLE ingredient (
  ingredient_id        INTEGER AUTO_INCREMENT,
  ingredient_name      VARCHAR(100) NOT NULL,
  PRIMARY KEY (ingredient_id)
);

CREATE TABLE ingredient_amounts (
  recipe_id         INTEGER,
  ingredient_id     INTEGER,
  quantity          NUMERIC(5, 2) NOT NULL,
  unit              VARCHAR(50),
  -- Note there is no primary key; it doesn't work for how this data is stored.
  FOREIGN KEY (recipe_id) REFERENCES recipe,
  FOREIGN KEY (ingredient_id) REFERENCES ingredient
);

-- This is an extra feature that may or may not be implemented.
CREATE TABLE cost (
  ingredient_id     INTEGER,
  -- in dollars
  price             NUMERIC(5, 2) NOT NULL,
  quantity          NUMERIC(5, 2) NOT NULL,
  unit              VARCHAR(50),
  PRIMARY KEY (ingredient_id),
  FOREIGN KEY (ingredient_id) REFERENCES ingredient
);

-- This is an extra feature that may or may not be implemented.
CREATE TABLE ratings (
  recipe_id         INTEGER,
  -- out of 5
  stars             NUMERIC(5, 0) NOT NULL,
  rated_on          TIMESTAMP,
  user_id           VARCHAR(100) NOT NULL,
  review            VARCHAR(1000),
  PRIMARY KEY (recipe_id),
  FOREIGN KEY (recipe_id) REFERENCES recipe,
  FOREIGN KEY (user_id) REFERENCES user
);
