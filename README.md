# Load PostgreSQL Sample Database

[Download sample database](http://www.postgresqltutorial.com/postgresql-sample-database/)

# Create database

> $ CREATE DATABASE dvdrental;

# Load the DVD rental database using psql tool

- Extract the zip file
- use the .tar file to load the database

> $ pg_restore -U postgres -d dvdrental /location/of/the/.tar