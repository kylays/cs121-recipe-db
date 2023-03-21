DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS chefs;
DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS ingredient_amounts;
DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS ingredients;
DROP TABLE IF EXISTS users;

-- Users can view (select permissions) the database's tables
CREATE TABLE users (
  -- a user_id specified by the user, must be unique and up to 20 characters
  user_id             VARCHAR(20),
  first_name          VARCHAR(25) DEFAULT 'Anonymous',
  last_name           VARCHAR(25) DEFAULT 'Anonymous',
  -- We use SHA-2 with 256-bit hashes. MySQL returns the hash
  -- value as a hexadecimal string, which means that each byte is
  -- represented as 2 characters. Thus, 256 / 8 * 2 = 64
  pw_hash             CHAR(64) NOT NULL,
  -- Salt will be 8 characters all the time, so we can make this 8.
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
  specialty           VARCHAR(100),
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON DELETE CASCADE
);

-- foods can be divided into categories such as appetizer, entree and
-- subcategories such as soup, salad
CREATE TABLE categories (
  subcategory        VARCHAR(100),
  category           VARCHAR(100),
  -- categories may have several subcategories, but each subcategory belongs
  -- to only one category
  PRIMARY KEY (subcategory)
);

CREATE TABLE recipes (
  recipe_id         INT AUTO_INCREMENT,
  -- recipes may have the same name but be different recipes
  recipe_name       VARCHAR(100) NOT NULL,
  -- each recipe belongs to a subcategory, which also belongs to a category
  subcategory       VARCHAR(100),
  directions        TEXT NOT NULL,
  PRIMARY KEY (recipe_id),
  FOREIGN KEY subcategory REFERENCES categories(subcategory)
);

-- stores the favorite recipes of users
CREATE TABLE favorites (
  user_id           VARCHAR(20) NOT NULL,
  recipe_id         INT,
  PRIMARY KEY (user_id, recipe_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON DELETE CASCADE,
  FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id)
);

CREATE TABLE ingredients (
  -- The name of an ingredient
  ingredient_name   VARCHAR(100) NOT NULL,
  -- Note that for the following three attributes, much of the source data is
  -- NULL since we didn't have time to generate all the data.
  -- Whether or not the ingredient is gluten-free, vegan, or vegetarian
  -- respectively
  gluten_free       TINYINT DEFAULT 0,
  vegan             TINYINT DEFAULT 0,
  vegetarian        TINYINT DEFAULT 0,
  PRIMARY KEY (ingredient_name)
);

CREATE TABLE ingredient_amounts (
  -- the recipe the ingredient belongs to
  recipe_id         INT NOT NULL,
  ingredient_name   VARCHAR(100) NOT NULL,
  quantity          NUMERIC(5, 3) NOT NULL,
  -- unit may be '' for items such as egg where the egg is a unit
  unit              VARCHAR(50),
  PRIMARY KEY (recipe_id, ingredient_name),
  FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
  FOREIGN KEY (ingredient_name) REFERENCES ingredients(ingredient_name)
    ON UPDATE CASCADE
);

-- This is an extra feature that may or may not be implemented completely.
CREATE TABLE ratings (
  -- the recipe being revivewed
  recipe_id         INT NOT NULL,
  -- the user who reviewed the recipe
  user_id           VARCHAR(20) NOT NULL,
  -- a rating out of 5
  stars             NUMERIC(5, 0) NOT NULL,
  -- the date and time at which the recipe rating and review were submitted
  rated_on          TIMESTAMP,
  -- an optional text review of the recipe
  review            TEXT,
  PRIMARY KEY (recipe_id, user_id),
  FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Index
CREATE INDEX recipe_name_idx ON recipes(recipe_name);
