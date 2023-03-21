"""
Student name(s): Kyla Yu-Swanson, Riya Shrivastava
Student email(s): kyuswans@caltech.edu, rshrivas@caltech.edu
High-level program overview:
This is a command line program that can be run to simulate our recipes
database.
"""

import sys  # to print error messages to sys.stderr
import mysql.connector
# To get error codes from the connector, useful for user-friendly
# error-handling
import mysql.connector.errorcode as errorcode

# Debugging flag to print errors when debugging that shouldn't be visible
# to an actual client. ***Set to False when done testing.***
DEBUG = True


# ----------------------------------------------------------------------
# SQL Utility Functions
# ----------------------------------------------------------------------
def get_conn():
    """"
    Returns a connected MySQL connector instance, if connection is successful.
    If unsuccessful, exits.
    """
    try:
        conn = mysql.connector.connect(
          host='localhost',
          user='appadmin',
          # Find port in MAMP or MySQL Workbench GUI or with
          # SHOW VARIABLES WHERE variable_name LIKE 'port';
          port='3306',  # this may change!
          password='adminpw',
          database='recipedb' # replace this with your database name
        )
        print('Successfully connected.')
        return conn
    except mysql.connector.Error as err:
        # Remember that this is specific to _database_ users, not
        # application users. So is probably irrelevant to a client in your
        # simulated program. Their user information would be in a users table
        # specific to your database; hence the DEBUG use.
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR and DEBUG:
            sys.stderr('Incorrect username or password when connecting to DB.')
        elif err.errno == errorcode.ER_BAD_DB_ERROR and DEBUG:
            sys.stderr('Database does not exist.')
        elif DEBUG:
            sys.stderr(err)
        else:
            # A fine catchall client-facing message.
            sys.stderr('An error occurred, please contact the administrator.')
        sys.exit(1)

# ----------------------------------------------------------------------
# Functions for Logging Users In
# ----------------------------------------------------------------------

def login():
    """
    Login function that asks for a user ID and password. Checks first if the
    user exists, and then checks the password. If the password is correct,
    displays the corresponding menu options.
    """

    while True:
        input1 = input('Enter User ID: ')
        input2 = input('Enter Password: ')
        is_user = try_login(input1, input2)
        if is_user:
            is_admin = check_admin(input1)
            if is_admin:
                show_admin_options()
            else:
                show_user_options()
        else:
            print('Wrong user ID or password. Try again.')


def try_login(user_id, password):
    """
    Checks if the user ID + password combination exists
    """

    is_user = False

    cursor = conn.cursor()
    sql = "SELECT authenticate('%s', '%s');" % (user_id, password)

    try:
        cursor.execute(sql)
        row = cursor.fetchone()
        if row[0]== 1:
            is_user = True

    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, please try another login.')
    return is_user


def check_admin(user_id):
    """
    Checks if the user is admin. This means the user exists in the chefs table
    and can add to the recipe database.

    NOTE: user_info is defined in setup.sql as users, not as a procedure. We
    have defined chefs to be "admins" in our database, but they are also
    users.
    """

    is_admin = False

    cursor = conn.cursor()
    sql = 'SELECT * FROM chefs WHERE user_id = "%s";' % (user_id)

    try:
        cursor.execute(sql)
        row = cursor.fetchone() # select next row
        # the user_id exists in the chefs table, else row would be NULL
        if row:
            is_admin = True

    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, please try another login.')
    return is_admin


# ----------------------------------------------------------------------
# Functions for Command-Line Options/Query Execution
# ----------------------------------------------------------------------

# Returns quantity, measurements, and ingredients for a given recipe
def find_all_ingredients_recipe(recipe_name_input):
    param1 = recipe_name_input
    cursor = conn.cursor()
    sql = 'SELECT ingredient_name, quantity, unit FROM recipes JOIN ingredient_amounts USING(recipe_id) WHERE recipe_name = “%s”;' % (param1)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row) # tuple unpacking!
            # do stuff with row data
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, try another recipe.')


# Returns all recipes for a given ingredient
def find_all_recipes_ingredient(ingredient_name_input):
    param1 = ingredient_name_input
    cursor = conn.cursor()
    sql = 'SELECT recipe_id, recipe_name FROM recipes JOIN ingredient_amounts USING(recipe_id) WHERE ingredient_name = “%s” ORDER BY recipe_name ASC;' % (param1)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, try another ingredient.')


# Returns all recipes in a specific category
def find_all_recipes_category(category_input):
    param1 = category_input
    cursor = conn.cursor()
    sql = 'SELECT DISTINCT ingredient_name FROM recipes JOIN ingredient_amounts USING(recipe_id) WHERE subcategory = “%s” ORDER BY ingredient_name ASC;' % (param1)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, try another category.')


# Returns all recipes with 5 or less ingredients
def find_all_recipes_less_ingredients():
    cursor = conn.cursor()
    sql = 'SELECT recipe_id, recipe_name, num_ingredients FROM (SELECT recipe_id, recipe_name, count_ingredients(recipe_id) AS num_ingredients FROM recipes JOIN ingredient_amounts USING(recipe_id)) AS subquery WHERE num_ingredients < 5 ORDER BY recipe_name ASC;'
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, try another option.')


# Returns the average number of stars rating of a recipe (identified by ID)
def recipe_average_stars(recipe_id_input):
    param1 = recipe_id_input
    cursor = conn.cursor()
    sql = 'SELECT AVG(stars) AS recipe_1_avg_stars FROM ratings WHERE recipe_id = “%d”;' % (param1)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, try another recipe ID.')


# Returns all recipes that have a certain ingredient in the name
def find_all_recipes_specific_ingredient(ingredient_name_input):
    param1 = ingredient_name_input
    cursor = conn.cursor()
    sql = 'SELECT recipe_name FROM recipes WHERE recipe_name LIKE “%s”;' % (param1)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, try another ingredient.')


# Returns user's favorite recipes that have a specific quantity of an ingredient
def find_favorite_recipes_specific_ingredient_quantity(ingredient_name_input, quantity_input):
    param1 = ingredient_name_input
    param2 = quantity_input
    cursor = conn.cursor()
    sql = 'SELECT recipe_name FROM favorites NATURAL JOIN recipes NATURAL JOIN  ingredient_amounts WHERE ingredient_name LIKE ‘”%s” AND quantity = “%d” ORDER BY recipe_name ASC;' % (param1, param2)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, try another ingredient and quantity combination.')


# Returns reviews for a specific recipe
def recipe_review(recipe_name_input):
    param1 = recipe_name_input
    cursor = conn.cursor()
    sql = 'SELECT review FROM recipes JOIN ratings using (recipe_id) WHERE recipe_name LIKE “%”s;' % (param1)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, try another recipe.')


# Allows chefs to add a new recipe to the database
def add_recipe(recipe_name_input, subcategory_input, directions_input):
    cursor = conn.cursor()
    sql = 'INSERT INTO accident(recipe_name, subcategory, directions) VALUES (“%s”, “%s”, “%s”);' % (recipe_name_input, subcategory_input, directions_input)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, please make sure your inputs are correct, or try again. You must make sure to include a recipe name and directions.')


# Allows users to add a new recipe to their favorites
def add_recipe_to_favorites(user_id_input, recipe_id_input):
    cursor = conn.cursor()
    sql = 'INSERT INTO favorites VALUES (“%s”, “%d”);' % (user_id_input, recipe_id_input)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, please make sure your inputs are correct, or try again. You must make sure to include your user ID and a valid recipe ID.')


# Allows users to remove a recipe from their favorites
def delete_recipe_from_favorites(user_id_input, recipe_id_input):
    cursor = conn.cursor()
    sql = 'DELETE FROM favorites WHERE user_id = "%s" AND recipe_id = "%d";' % (user_id_input, recipe_id_input)
    try:
        cursor.execute(sql)
        rows = cursor.fetchall()
        for row in rows:
            (col1val) = (row)
            print(row)
    except mysql.connector.Error as err:
        if DEBUG:
            sys.stderr(err)
            sys.exit(1)
        else:
            sys.stderr('An error occurred, please make sure your inputs are correct, or try again. You must make sure to include your user ID and a valid recipe ID .')

# ----------------------------------------------------------------------
# Command-Line Functionality
# ----------------------------------------------------------------------
def show_options():
    """
    Displays options users can choose in the application
    """
    print('  (l) - login')
    print('  (q) - quit')
    print()
    while True:
        ans = input('Enter an option: ')[0].lower()
        if ans == 'q':
            quit_ui()
        elif ans == 'l':
            login()
        else:
            print('Select a valid option.')


def show_user_options():
    """
    Displays options for users
    """
    print('What would you like to do? Type and option (with the input parameter seperated by only a comma, no space)')
    print('  (a, recipe_name) - Find quantity, measurements, and ingredients for a given recipe')
    print('  (b, ingredient_name) - Find all recipes for a given ingredient')
    print('  (c, category) - Find all recipes in a specific category')
    print('  (d) - Find all recipes with less than 5 ingredients')
    print('  (e, recipe_id) - Find the average number of stars rating of a recipe (identified by ID)')
    print('  (f, ingredient_name) -  Find all recipes that have a certain ingredient in the name')
    print('  (g, ingredient_name, quantity) - Find your favorite recipes that have a specific quantity of an ingredient')
    print('  (h, recipe_name) - Find reviews for a specific recipe')
    print('  (i, user_id, recipe_id) - Add a new recipe to your favorites')
    print('  (j, user_id, recipe_id) - Remove a recipe from your favorites')
    print('  (q) - Quit')
    print()

    while True:
        ans = input('Enter an option: ').lower()

        if ans == 'q':
            quit_ui()
        elif ans[0] == 'a':
            sub = ans.split(',')
            find_all_ingredients_recipe(sub[1].strip())
        elif ans == 'b':
            sub = ans.split(',')
            find_all_recipes_ingredient(sub[1].strip())
        elif ans == 'c':
            sub = ans.split(',')
            find_all_recipes_category(sub[1].strip())
        elif ans == 'd':
            find_all_recipes_less_ingredients()
        elif ans == 'e':
            sub = ans.split(',')
            recipe_average_stars(sub[1].strip())
        elif ans == 'f':
            sub = ans.split(',')
            find_all_recipes_specific_ingredient(sub[1].strip())
        elif ans[0] == 'g':
            sub = ans.split(',')
            find_favorite_recipes_specific_ingredient_quantity(sub[1].strip(), sub[2].strip())
        elif ans[0] == 'h':
            sub = ans.split(',')
            recipe_review(sub[1].strip())
        elif ans[0] == 'i':
            sub = ans.split(',')
            add_recipe_to_favorites(sub[1].strip(), sub[2].strip())
        elif ans[0] == 'j':
            sub = ans.split(',')
            delete_recipe_from_favorites(sub[1].strip(), sub[2].strip())
        else:
            print('Please select a valid option.')


# chefs are additionally able to insert recipes
def show_admin_options():
    """
    Displays options for users
    """
    print('  (k, recipe_name, subcategory, directions) - Add a new recipe to the database')
    print('  (l - Go to user options')
    print('  (q) - Quit')
    print()

    while True:
        ans = input('Enter an option: ').lower()
        if ans == 'q':
            quit_ui()
        elif ans[0] == 'k':
            sub = ans.split(',')
            add_recipe(sub[1].strip(), sub[2].strip(), sub[3].strip())
        elif ans[0] == 'l':
            show_user_options()
        else:
            print('Please select a valid option.')


def quit_ui():
    """
    Quits the program, printing a good bye message to the user.
    """
    print('Good bye!')
    exit()


def main():
    """
    Main function for starting things up.
    """
    show_options()


if __name__ == '__main__':
    # This conn is a global object that other functions can access.
    # You'll need to use cursor = conn.cursor() each time you are
    # about to execute a query with cursor.execute(<sqlquery>)
    conn = get_conn()
    main()
