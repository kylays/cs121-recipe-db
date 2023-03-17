CREATE USER 'appadmin'@'localhost' IDENTIFIED BY 'adminpw';
CREATE USER 'appclient'@'localhost' IDENTIFIED BY 'clientpw';

-- admine priviliges 
GRANT ALL PRIVILEGES ON recipe-db.* TO 'appadmin'@'localhost';

-- client priviliges
GRANT SELECT ON recipe-db.* TO 'appclient'@'localhost';

FLUSH PRIVILEGES;