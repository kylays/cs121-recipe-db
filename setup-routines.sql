-- Inserts an ingredient into the ingredients table when the ingredient is 
-- added as part of a recipe if the ingredient was not already in the database.
DELIMITER !
CREATE TRIGGER trg_before_ingredient_amounts_insert BEFORE INSERT
  ON ingredient_amounts FOR EACH ROW
BEGIN
  DECLARE present TINYINT;
  SELECT 
    NEW.ingredient_name IN (SELECT ingredient_name FROM ingredients) 
    INTO present;
  IF NOT present THEN 
    INSERT INTO ingredients(ingredient_name) VALUES (NEW.ingredient_name);
  END IF;
END !
DELIMITER ;

-- Returns a random recipe_id
DELIMITER !
CREATE FUNCTION random_recipe()
RETURNS INT NOT DETERMINISTIC
BEGIN
  DECLARE recipe INT;
  SELECT recipe_id INTO recipe 
  FROM recipes JOIN ingredient_amounts USING(recipe_id)
  ORDER BY RAND()  
  LIMIT 1;  
  RETURN recipe;
END !
DELIMITER ;

-- Adds a recipe to the favorites table to save it as a user's favorite recipe.
DELIMITER !
CREATE PROCEDURE add_favorite(username VARCHAR(20), recipe INT)
BEGIN
  INSERT INTO favorites(user_id, recipe_id) 
    VALUES (username, recipe);
END !
DELIMITER ;

-- EXTRA
-- Removes a favorite recipe from a user in the favorites table.
DELIMITER !
CREATE PROCEDURE delete_favorite(username VARCHAR(20), recipe INT)
BEGIN
  DELETE FROM favorites WHERE user_id = username AND recipe_id = recipe;
END !
DELIMITER ;

-- Returns the number of ingredients in a recipe.
DELIMITER !
CREATE FUNCTION count_ingredients(recipe INT)
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE num INT;
  SELECT COUNT(*) INTO num FROM ingredient_amounts WHERE recipe_id = recipe;
  RETURN num;
END !
DELIMITER ;

-- Returns a random recipe containing a speicified ingredient
DELIMITER !
CREATE FUNCTION random_recipe_with(ingredient VARCHAR(20))
RETURNS INT NOT DETERMINISTIC
BEGIN
  DECLARE recipe INT;
  SELECT recipe_id INTO recipe 
  FROM recipes JOIN ingredient_amounts USING(recipe_id)
  WHERE ingredient_name = ingredient
  ORDER BY RAND()  
  LIMIT 1;  
  RETURN recipe;
END !
DELIMITER ;