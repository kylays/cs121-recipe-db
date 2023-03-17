# CS 121 final project: recipedb app
TODO - instructions on how to use the app





kyla
* ER diagram 
  - DONE, sort of? I'm kind of unsure about it 
  - not sure if non chef users have features for er diagram?? do they have a table for preferences? tracking their usage???
  - also the er diagram has some relationships that i am unsure of (might just delete them if not going to implement them anyways bc extra)
* DDL 
  - DONE --- i think? have to look at ER diagram issues again, theres a few tables that I'm unsure about still
  - might need more comments
  - i feel like ingredients needs its own table with ingredient_name as a PK
* load-data + csv files 
  - (missing csv for the extra tables ratings, cost, chefs users, and favorites) -- have to self generate this data
  - TODO users, chefs, other tables maybe
* passwords - DONE
* grant permissions - DONE probably
  - TODO maybe go back and change this after app.py done
* procedural sql: 1 procedure + extra procedure + extra functions + 1 UDF - DONE except testing
  - udf and procedure ideas in proposal, need to make trigger idea
  - actually the procedure specified there is a function... its okay i made 2 procedures
  - favorites table added -- make a function that lets users add favorite recipes (procedural sql)
    (this will be the extra thing we need bc partners)
  - TODO test these
* functional dependencies
  - TODO --- need to do this to make sure that the DDL is okay, might need to change ddl and then csv files accordingly
* queries
  - TODO

riya
* procedural sql: 1 trigger (need idea for this and implementation)
* app.py
  - error handling: (i think this would be in app.py)
    * username already taken
    * user does not exist
    * ingredient not found for calling random_recipe_with UDF

together
* queries 
  - lets try to do at least 10
  - 2 need to match with the relational algebra
* reflection.pdf (do this weekend, in google drive) 
  - https://docs.google.com/document/d/1sf-P4GP-IBW1mACQ5GmScX0fa16A8PcXLH8FJR66p2U/edit?usp=sharing 
  - functional dependencies -- might need to change some of the tables... i really hope not
  - relational algebra
  - other
* README.md instructions