-- Exercise 1 — Tasks
-- Find the title of each film
SELECT title FROM movies;
-- Find the director of each film
SELECT director FROM movies;
-- Find the title and director of each film
SELECT title, director FROM movies;
-- Find the title and year of each film
SELECT title, year FROM movies;
-- Find all the information about each film
SELECT * FROM movies;


-- Exercise 2 — Tasks
-- Find the movie with a row id of 6
SELECT * FROM movies WHERE id = 6
-- Find the movies released in the years between 2000 and 2010
SELECT * FROM movies WHERE year BETWEEN 2000 and 2010
-- Find the movies not released in the years between 2000 and 2010
SELECT * FROM movies WHERE year NOT BETWEEN 2000 AND 2010
-- Find the first 5 Pixar movies and their release year
SELECT * FROM movies LIMIT 5


-- Exercise 3 — Tasks
-- Find all the Toy Story movies
SELECT * FROM movies WHERE title LIKE 'Toy Story%'
-- Find all the movies directed by John Lasseter
SELECT * FROM movies WHERE director LIKE 'John Lasseter'
-- Find all the movies (and director) not directed by John Lasseter
SELECT * FROM movies WHERE director NOT LIKE 'John Lasseter'
-- Find all the WALL-* movies
SELECT * FROM movies where title LIKE 'WALL-_'


-- Exercise 4 — Tasks
-- List all directors of Pixar movies (alphabetically), without duplicates
SELECT DISTINCT director
FROM movies
ORDER BY director ASC;
-- List the last four Pixar movies released (ordered from most recent to least)
SELECT *
FROM movies
ORDER BY year DESC LIMIT 4
-- List the first five Pixar movies sorted alphabetically
SELECT *
FROM movies
ORDER BY title ASC LIMIT 5
-- List the next five Pixar movies sorted alphabetically
SELECT *
FROM movies
ORDER BY Title ASC LIMIT 5 OFFSET 5


-- Review 1 — Tasks
-- List all the Canadian cities and their populations
SELECT city, population FROM north_american_cities WHERE country = 'Canada'
-- Order all the cities in the United States by their latitude from north to south
SELECT * FROM north_american_cities WHERE country = 'United States' ORDER BY latitude DESC
-- List all the cities west of Chicago, ordered from west to east
SELECT * FROM north_american_cities WHERE longitude < -87.629798 ORDER BY longitude
-- List the two largest cities in Mexico (by population)
SELECT * FROM north_american_cities WHERE country = "Mexico" ORDER BY population DESC LIMIT 2
-- List the third and fourth largest cities (by population) in the United States and their population
SELECT * FROM north_american_cities WHERE country = "United States" ORDER BY population DESC LIMIT 2 OFFSET 2


-- Exercise 6 — Tasks
-- Find the domestic and international sales for each movie 
SELECT title, domestic_sales, international_sales FROM movies INNER JOIN boxoffice ON movies.id = boxoffice.movie_id
-- Show the sales numbers for each movie that did better internationally rather than domestically
SELECT title, domestic_sales, international_sales FROM movies INNER JOIN boxoffice ON movies.id = boxoffice.movie_id WHERE international_sales > domestic_sales
-- List all the movies by their ratings in descending order
SELECT title, domestic_sales, international_sales FROM movies INNER JOIN boxoffice ON movies.id = boxoffice.movie_id ORDER BY rating DESC


-- Exercise 7 — Tasks
-- Find the list of all buildings that have employees
SELECT DISTINCT building FROM employees
-- Find the list of all buildings and their capacity
SELECT * FROM buildings
-- List all buildings and the distinct employee roles in each building (including empty buildings)
SELECT DISTINCT building_name, role FROM buildings LEFT JOIN employees ON buildings.building_name = employees.building


-- Exercise 8 — Tasks
-- Find the name and role of all employees who have not been assigned to a building
SELECT name, role FROM employees WHERE building IS NULL
-- Find the names of the buildings that hold no employees
SELECT DISTINCT building_name FROM buildings LEFT JOIN employees ON buildings.building_name = employees.building WHERE employees.building IS NULL


-- Exercise 9 — Tasks
-- List all movies and their combined sales in millions of dollars
SELECT DISTINCT title, (domestic_sales + international_sales) / 1000000 AS combined_sales 
    FROM movies INNER JOIN boxoffice WHERE boxoffice.movie_id = movies.id;
-- List all movies and their ratings in percent
SELECT DISTINCT title, (rating * 10) AS percentages 
    FROM movies INNER JOIN boxoffice WHERE movies.id = boxoffice.movie_id
-- List all movies that were released on even number years
SELECT DISTINCT * FROM movies WHERE year % 2 = 0


-- Exercise 10 — Tasks
-- Find the longest time that an employee has been at the studio
SELECT max(years_employed) FROM employees
-- For each role, find the average number of years employed by employees in that role
select avg(years_employed),role FROM employees GROUP BY role
-- Find the total number of employee years worked in each building
SELECT building, sum(years_employed) AS total FROM employees GROUP BY building


-- Exercise 11 — Tasks
-- Find the number of Artists in the studio (without a HAVING clause)
SELECT role, count() AS num_artists FROM employees WHERE role = 'Artist'
-- Find the number of Employees of each role in the studio
SELECT role, count() FROM employees GROUP BY role
-- Find the total number of years employed by all Engineers
SELECT role, sum(years_employed) AS total_yrs_employed_engineer FROM employees GROUP by role HAVING role = "Engineer"
SELECT role, sum(years_employed) AS total_yrs_employed_engineer FROM employees where = "Engineer"


-- Exercise 12 — Tasks
-- Find the number of movies each director has directed
SELECT director, count(title) AS total FROM movies GROUP BY director 
-- Find the total domestic and international sales that can be attributed to each director
SELECT director, sum(domestic_sales + international_sales) AS total_sales 
    FROM boxoffice INNER JOIN movies ON boxoffice.movie_id = movies.id GROUP BY director


-- Exercise 13 — Tasks
-- Add the studio's new production, Toy Story 4 to the list of movies (you can use any director)
INSERT INTO movies (id, title, director, year, length_minutes) 
    VALUES(4, 'Toy Story 4', 'Josh Cooley', 2019, 100)
-- Toy Story 4 has been released to critical acclaim! It had a rating of 8.7, and made 340 million domestically and 270 million internationally. Add the record to the BoxOffice table.
INSERT INTO boxoffice (movie_id, rating, domestic_sales, international_sales) VALUES (4, 8.7, 340000000, 270000000)


-- Exercise 14 — Tasks
-- The director for A Bug's Life is incorrect, it was actually directed by John Lasseter
UPDATE movies
SET director = 'John Lasseter'
WHERE title = "A Bug's Life"
-- The year that Toy Story 2 was released is incorrect, it was actually released in 1999
UPDATE movies
SET year = 1999
WHERE title = "Toy Story 2"
-- Both the title and director for Toy Story 8 is incorrect! The title should be "Toy Story 3" and it was directed by Lee Unkrich
UPDATE movies
SET title = "Toy Story 3", 
    director = "Lee Unkrich"
WHERE title ="Toy Story 8"


-- Exercise 15 — Tasks
-- This database is getting too big, lets remove all movies that were released before 2005.
DELETE FROM movies
WHERE year < 2005
-- Andrew Stanton has also left the studio, so please remove all movies directed by him.
DELETE FROM movies
WHERE director = "Andrew Stanton"


-- Exercise 16 — Tasks
-- Create a new table named Database with the following columns:
-- – Name A string (text) describing the name of the database
-- – Version A number (floating point) of the latest version of this database
-- – Download_count An integer count of the number of times this database was downloaded
-- This table has no constraints.
CREATE TABLE Database (
    name TEXT, 
    version FLOAT, 
    download_count INTEGER
)


-- Exercise 17 — Tasks
-- Add a column named Aspect_ratio with a FLOAT data type to store the aspect-ratio each movie was released in.
ALTER TABLE movies 
ADD Aspect_ratio FLOAT
-- Add another column named Language with a TEXT data type to store the language that the movie was released in. Ensure that the default for this language is English.
ALTER TABLE movies
ADD Language TEXT
DEFAULT English


-- Exercise 18 — Tasks
-- We've sadly reached the end of our lessons, lets clean up by removing the Movies table
DROP TABLE IF EXISTS Movies
-- And drop the BoxOffice table as well
DROP TABLE IF EXISTS BoxOffice

