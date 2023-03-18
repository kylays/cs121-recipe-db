LOAD DATA LOCAL INFILE 'data/users.csv' INTO TABLE users
FIELDS TERMINATED 
  BY ',' ENCLOSED 
  BY '"' LINES TERMINATED 
  BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'data/chefs.csv' INTO TABLE chefs
FIELDS TERMINATED 
  BY ',' ENCLOSED 
  BY '"' LINES TERMINATED 
  BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'data/categories.csv' INTO TABLE categories
FIELDS TERMINATED 
  BY ',' ENCLOSED 
  BY '"' LINES TERMINATED 
  BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'data/recipes.csv' INTO TABLE recipes
FIELDS TERMINATED 
  BY ',' ENCLOSED 
  BY '"' LINES TERMINATED 
  BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'data/favorites.csv' INTO TABLE favorites
FIELDS TERMINATED 
  BY ',' ENCLOSED 
  BY '"' LINES TERMINATED 
  BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'data/ingredients.csv' INTO TABLE ingredients
FIELDS TERMINATED 
  BY ',' ENCLOSED 
  BY '"' LINES TERMINATED 
  BY '\r\n' IGNORE 1 ROWS;

-- Note this has warnings due to the NULL data we did not have time to make
LOAD DATA LOCAL INFILE 'data/ingredient_amounts.csv' INTO TABLE ingredient_amounts
FIELDS TERMINATED 
  BY ',' ENCLOSED 
  BY '"' LINES TERMINATED 
  BY '\r\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'data/ratings.csv' INTO TABLE ratings
FIELDS TERMINATED 
  BY ',' ENCLOSED 
  BY '"' LINES TERMINATED 
  BY '\r\n' IGNORE 1 ROWS;
