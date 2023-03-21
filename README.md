# CS 121 final project: recipedb app

## About
This project was created as part of the course CS 121 Relational Databases at
Caltech. The project implements a recipe database and a user-interface to
allow regular and admin (chef) users to connect to the database.
* Contributors: Kyla Yu-Swanson and Riya Shrivastava
* Data source: https://github.com/cweber/cookbook and self-generated

## How to load the database on command-line
Make sure you have MySQL downloaded and available through your
device's command-line. First, create a database in mySQL:
```
mysql> CREATE DATABASE recipedb;
mysql> USE recipedb;
```

Not including the "mysql>" prompt, run the following lines of code on your
command-line after creating and using an appropriate database (Note that if
you are using windows you should run `source load-data-windows.sql` instead of
`source load-data.sql`):
```
mysql> source setup.sql;
mysql> source load-data.sql;
mysql> source setup-passwords.sql;
mysql> source setup-routines.sql;
mysql> source grant-permissions.sql;
mysql> source queries.sql;
```

## Instructions for python program
Hello! Here are instructions to use a command line program that can be run to simulate our recipes
database. As a user or chef, you will have various options to interact with the database.

Please install the Python MySQL Connector using pip3 if not installed already.

After loading the data and verifying you are in the correct database, run the following to open the Python application:

```
mysql> quit;

$ python3 app.py
```

You will be prompted to login. The following users are registered:
user ID: Newt9 | password: password123!

The following chefs are registered:
user ID: ChefJohn | password: 3a+ingShr1mp
user ID: AppleMan1 | password: *mac0S*

Note that all chefs are users as well. Chefs are additionally able to add recipes to the database.

Here is a suggested guide to using app_.py:
* Select option [a] to find quantity, measurements, and ingredients for a given recipe.
* Select option [b] to find all recipes for a given ingredient.
* Select option [c] to find all recipes in a specific category.
* Select option [d] to find all recipes with less than 5 ingredients.
* Select option [e] to find the average number of stars rating of a recipe (identified by ID).
* Select option [f] to find all recipes that have a certain ingredient in the name
* Select option [g] to find your favorite recipes that have a specific quantity of an ingredient
* Select option [h] to find reviews for a specific recipe
* Select option [i] to add a new recipe to your favorites
* Select option [j] to remove a recipe from your favorites.
[FOR CHEFS ONLY]
* Select option [k] to add a recipe to the database

Additional notes:
* No files are written to the user's system.
* We only have basic checks to validate user input and actions, these could be made more rigorous
* Our error handling mainly has to do with inputs and we are not showing specifc mySQL errors in the Python interface

## Unfinished Features
* Chefs as creators of recipes
* Missing data for ingredients being gluten-free, vegan, or vegetarian

###############################################################################

# Notes For Kyla and Riya

## kyla
* ER diagram - DONE
* DDL - DONE
* load-data.sql + csv files - DONE, can add more records if want to
* passwords - DONE
* grant permissions - DONE
* procedural sql: 1 procedure + 1 UDF + 1 trigger - DONE
* functional dependencies - DONE
* 5 queries - DONE

## riya
* app.py - DONE
- NOTE changed grant permssions to ALL PRIVELEDGES on both clients and users to allow user to add to their favorites. app.py ensures only chafs can add to the recipe database
* 5 queries.sql
  - DONE
* relational algebra
  - DONE

## together
* reflection.pdf
* README.md instructions
