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
  - TODO users, chefs
* passwords - DONE
* grant permissions - DONE probably
  - TODO maybe go back and change this after app.py done
* queries 
  - TODO after finish load-data
* procedural sql: 1 procedure + extra procedure + extra functions + 1 UDF - DONE except testing
  - udf and procedure ideas in proposal, need to make trigger idea
  - actually the procedure specified there is a function... its okay i made 2 procedures
  - favorites table added -- make a function that lets users add favorite recipes (procedural sql)
    (this will be the extra thing we need bc partners)
  - TODO test these

riya
* procedural sql: 1 trigger (need idea for this and implementation)
* app.py
  - error handling: (i think this would be in app.py)
    * username already taken
    * user does not exist

together
* reflection.pdf (do this weekend)
  - functional dependencies
  - relational algebra
  - other
* README.md instructions