-- This files has queries that are used to test setup-routines.sql
-- Assumes that the setup steps in README.md have been followed to load the data

-- TESTER FOR trg_before_ingredient_amounts_insert
-- Should verify that the new ingredient 'fake ingredient' is added to 
-- ingredients when it is added to ingredient_amounts
SELECT * FROM ingredients WHERE ingredient_name = 'fake ingredient';
SELECT * FROM ingredient_amounts WHERE recipe_id = 1;
INSERT INTO ingredient_amounts(recipe_id, ingredient_name, quantity) 
  VALUES (1, 'fake ingredient', 42);
SELECT * FROM ingredient_amounts WHERE recipe_id = 1;
SELECT * FROM ingredients WHERE ingredient_name = 'fake ingredient';
DELETE FROM ingredient_amounts WHERE ingredient_name = 'fake ingredient';
DELETE FROM ingredients WHERE ingredient_name = 'fake ingredient';

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