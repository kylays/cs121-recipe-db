-- Example queries 

-- Find all ingredients in 'Baby Back Ribs'. This is an example of when a 
-- user is actively trying to make a recipe and needs all the measurements 
-- and ingredients.
SELECT ingredient_name, quantity, unit
FROM recipes JOIN ingredient_amounts USING(recipe_id)
WHERE recipe_name = 'baby back ribs';

-- Find all recipes that use the ingredient 'allspice'. This is an example of 
-- a query that would help users find recipes that they can make with the 
-- ingredients they already have.
SELECT recipe_id, recipe_name
FROM recipes JOIN ingredient_amounts USING(recipe_id)
WHERE ingredient_name = 'allspice'
ORDER BY recipe_name ASC;

-- Find all ingredients in recipes of the category 'Cake.' This is an example 
-- of when a user would try to find recipes to learn a certain cooking style.
SELECT DISTINCT ingredient_name
FROM recipes JOIN ingredient_amounts USING(recipe_id)
WHERE subcategory = 'cake'
ORDER BY ingredient_name ASC;

-- Find the recipes with less than five ingredients. This is an example of 
-- when a user wants to cook a simple dish. 
SELECT recipe_id, recipe_name, num_ingredients
FROM (SELECT 
      recipe_id, 
      recipe_name, 
      count_ingredients(recipe_id) AS num_ingredients
    FROM recipes 
    JOIN ingredient_amounts 
    USING(recipe_id)) AS subquery
WHERE num_ingredients < 5
ORDER BY recipe_name ASC;

-- Find the average number of stars rating of a recipe. Note that this 
-- query doesn't return very interesting data since this table is mostly empty.
SELECT AVG(stars) AS recipe_1_avg_stars
FROM ratings 
WHERE recipe_id = 1;

-- Find recipes that have chocolate in the name. This is an example of a query 
-- where a user is looking for a recipe for a food they know.
SELECT recipe_name 
FROM recipes
WHERE recipe_name LIKE '%chocolate%';