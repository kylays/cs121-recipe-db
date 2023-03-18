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
TODO Riya instructions on how to use the app

## Unfinished Features
* Chefs as creators of recipes
* Missing data for ingredients being gluten-free, vegan, or vegetarian

###############################################################################

# Notes For Kyla and Riya

kyla
* ER diagram - DONE
* DDL - DONE --- i think? 
  - TODO cross check with func deps
* load-data + csv files - DONE, can add more records if want
* passwords - DONE
* grant permissions - DONE probably
  - TODO maybe go back and change this after app.py done
* procedural sql: 1 procedure + extra procedure + extra functions + 1 UDF - DONE except testing
  - TODO test these
* functional dependencies
  - TODO --- need to do this to make sure that the DDL is okay, might need to change ddl and then csv files accordingly
  - IN PROGRESS, on iPad
* queries
  - TODO - make a few just to test the database

riya
* procedural sql: 1 trigger (need idea for this and implementation)
* app.py
  - error handling: (i think this would be in app.py)
    * username already taken
    * user does not exist
    * ingredient not found for calling random_recipe_with UDF
* queries.sql
  - 2 need to match with the relational algebra
* relational algebra
  - in the reflection doc

together
* queries 
  - lets try to do at least 10
  - 2 need to match with the relational algebra
* reflection.pdf (do this weekend, in google drive) 
  - https://docs.google.com/document/d/1sf-P4GP-IBW1mACQ5GmScX0fa16A8PcXLH8FJR66p2U/edit?usp=sharing 
  - functional dependencies
      * kyla, since relates to DDL
  - relational algebra
      * riya, since relates to queries
  - other
* README.md instructions