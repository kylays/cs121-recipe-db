-- This files has queries that are used to test setup-routines.sql
-- Assumes that the setup steps in README.md have been followed to load the data

-- TESTER FOR <trigger> (replace with actual name)
-- TODO

-- TESTS FOR random_recipe
-- should all give different recipe_id numbers
SELECT 
  random_recipe(),
  random_recipe(),
  random_recipe(),
  random_recipe(),
  random_recipe();

-- TESTS FOR add_favorite
CALL add_favorite('kyuswans', 100);
-- verify that this returns (kyuswans, 100)
SELECT * FROM favorites WHERE user_id = 'kyuswans' AND recipe_id = 100;

-- TESTS FOR delete_favorite
CALL delete_favorite('kyuswans', 100);
-- verify that this returns empty set
SELECT * FROM favorites WHERE user_id = 'kyuswans' AND recipe_id = 100;

-- TESTS FOR num_ingredients (should all return 1) 
SELECT count_ingredients(1) = 9;
SELECT count_ingredients(2) = 10;
SELECT count_ingredients(3) = 10;

-- TESTS FOR random_recipe_with 
-- should all give different recipe_id numbers
SELECT 
  random_recipe_with('egg'),
  random_recipe_with('egg'),
  random_recipe_with('egg'),
  random_recipe_with('egg'),
  random_recipe_with('egg');

-- should all return 1
SET @tmprecipe = random_recipe_with('egg');
SELECT 'egg' IN 
(SELECT ingredient_name
FROM ingredient_amounts 
WHERE recipe_id = @tmprecipe) AS contains_egg;

SET @tmprecipe = random_recipe_with('rice');
SELECT 'rice' IN 
(SELECT ingredient_name
FROM ingredient_amounts 
WHERE recipe_id = @tmprecipe) AS contains_rice;

SET @tmprecipe = random_recipe_with('hamburger');
SELECT 'hamburger' IN 
(SELECT ingredient_name
FROM ingredient_amounts 
WHERE recipe_id = @tmprecipe) AS contains_hamburger;

SET @tmprecipe = NULL;