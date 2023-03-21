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

-- Find all recipes in the user's favorites that contain exactl 3 eggs. This
-- is an example of a query where a user wants so make a familiar dish
-- they love with a specific ingredient constraint
SELECT recipe_name
FROM favorites NATURAL JOIN recipes NATURAL JOIN  ingredient_amounts
WHERE ingredient_name LIKE '%egg%' AND quantity = 3
ORDER BY recipe_name ASC;

-- Find recipes that have vegan and gluten free ingredients. This is an
-- example of a query where a user wants to cook a recipe with specific
-- ingredient constraints due to dietary restrictions
SELECT recipe_name
FROM recipes NATURAL JOIN ingredient_amounts NATURAL JOIN  ingredients
WHERE vegan = 1 AND gluten_free = 1
ORDER BY recipe_name ASC;

-- Find recipes for appetizers that are dips. This is an example of a query
-- where the user need to create a specific type of dish for an event
SELECT recipe_name
FROM recipes JOIN categories USING(subcategory)
WHERE subcategory = 'dip'
ORDER BY recipe_name ASC;

-- Find the review for a specifc recipe. This is an example of a query where
-- the user is looking for reviews on a specific recipe they want to make
SELECT review
FROM recipes JOIN ratings using (recipe_id)
WHERE recipe_name LIKE "banana cake";

-- This query returns the user_id and the number of reviews of the user who
-- submitted the most reviews. This is an example of a query where a user
-- wants to see who else is active in the database.
SELECT user_id, COUNT(recipe_id)
FROM ratings JOIN users USING(user_id)
GROUP BY user_id;
