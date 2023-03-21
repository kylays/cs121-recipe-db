DROP USER IF EXISTS appadmin@localhost;
DROP USER IF EXISTS appclient@localhost;

CREATE USER 'appadmin'@'localhost' IDENTIFIED BY 'adminpw';
CREATE USER 'appclient'@'localhost' IDENTIFIED BY 'clientpw';

-- admine priviliges
GRANT ALL PRIVILEGES ON recipedb.* TO 'appadmin'@'localhost';

-- client priviliges
GRANT ALL PRIVILEGES ON recipedb.* TO 'appclient'@'localhost';

FLUSH PRIVILEGES;
