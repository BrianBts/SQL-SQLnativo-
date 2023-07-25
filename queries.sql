CREATE TABLE movies (
  id INTEGER PRIMARY KEY,
  name TEXT DEFAULT NULL,
  year INTEGER DEFAULT NULL,
  rank REAL DEFAULT NULL
);

CREATE TABLE actors (
  id INTEGER PRIMARY KEY,
  first_name DEFAULT NULL,
  las_name DEFAULT NULL, 
  gender TEXT DEFAULT NULL
);

CREATE TABLE roles(
  actor_id INTEGER,
  movie_id INTEGER,
  role_name TEXT DEFAULT NULL
);

SELECT name, 
year FROM movies 
WHERE year=1902 AND rank>5;
name                  year

-- Año de Nacimiento
-- Encontrá todas las películas hechas en el año en que naciste.
SELECT * FROM movies WHERE year = 1996;

-- 1982
-- ¿Cuantás películas tiene nuestra base de datos para el año 1982?

SELECT COUNT (*) FROM movies m WHERE year = 1982;

-- Stacktors
-- Encontrá los actores que tienen "stack" en su apellido.

SELECT * FROM actors WHERE last_name LIKE '%stack%';

-- Juego del Nombre de la Fama
-- ¿Cúales son los 10 nombres mFondo del Barril
-- ¿Cuántas películas tiene IMBD de cada género ordenado por el más popular?
SELECT last_name,COUNT (*) FROM actors
GROUP BY last_name
ORDER BY COUNT(*) DESC
LIMIT 10;

-- ¿Cuales son los full_names más populares?

SELECT first_name || last_name, COUNT (*) FROM actors
GROUP BY first_name || last_name
ORDER BY COUNT(*) DESC
LIMIT 10;

-- Prolífico
-- Listá el top 100 de actores más activos y el número de roles en los que participó.

-- SELECT actor_id, COUNT(*) FROM roles
-- GROUP BY acttor_id
-- ORDER BY COUNT(*) DESC
-- LIMIT 10;

SELECT first_name || last_name, COUNT(*) as pruebaRoles_num
FROM roles 
JOIN actors 
ON roles.actor_id = actors.id
GROUP BY roles.actor_id
ORDER BY pruebaRoles_num DESC
LIMIT 100;

-- Fondo del Barril
-- ¿Cuántas películas tiene IMBD de cada género ordenado por el más popular?

--preguntar
--preguntar
--preguntar

SELECT genre, COUNT (*) 
FROM  movies_genres

JOIN movies
ON movies.id = movies_genres.movie_id
GROUP BY genre

ORDER BY COUNT (*) ASC;

-- Braveheart
-- Lista el nombre y apellido de todos los actores que actuaron en la película 'Braveheart' de 1995, ordenados alfabéticamente por sus apellidos.

SELECT first_name || last_name FROM movies
JOIN roles ON roles.movie_id = movies.id
JOIN actors ON roles.actor_id = actors.id
WHERE movies.name = 'Braveheart' AND movies.year = '1995'
ORDER BY last_name ASC;

-- Noir Bisiesto
-- Listá todos los directores que dirigieron una película de género 'Film-Noir' en un año bisiesto (hagamos de cuenta que todos los años divisibles por 4 son años bisiestos, aunque no sea verdad en la vida real).

-- Tu query deberá retornar el nombre del director, el nombre de la película y el año, ordenado por el nombre de la película.

-- bisiesto; WHERE years % 4 = 0
--directors_genres
--movies_directors
--movies


SELECT directors.first_name, directors.last_name, movies.name, movies.year
FROM movies_directors
JOIN directors
ON movies_directors.director_id = directors.id
JOIN directors_genres
ON movies_directors.director_id = directors_genres.director_id
JOIN movies
ON movies_directors.movie_id = movies.id
JOIN movies_genres
ON movies_directors.movie_id = movies_genres.movie_id
WHERE movies_genres.genre = 'Film-Noir' AND movies.year%4=0
GROUP BY movies.name
ORDER BY movies.name ASC;

-- Kevin Bacon
-- (Contexto)

-- Listá todos los actores que hayan trabajado con Kevin Bacon en una película de Drama (incluí el nombre de la película) y excluí al Sr. Bacon de los resultados.

--actors
--movies

SELECT movies.name, actors.first_name || " " || actors.last_name AS full_name

  FROM actors 

  JOIN roles 
    ON roles.actor_id = actors.id

  JOIN movies  
    ON roles.movie_id = movies.id

  JOIN movies_genres 
    ON movies_genres.movie_id = movies.id
    AND movies_genres.genre = 'Drama'

  WHERE movies.id IN (

    SELECT movies.id
    FROM movies 
    JOIN roles 
      ON roles.movie_id = movies.id

    JOIN actors 
      ON roles.actor_id = actors.id

    WHERE actors.first_name = 'Kevin'
      AND actors.last_name = 'Bacon'
    )

    AND full_name != 'Kevin Bacon'

    ORDER BY movies.name ASC
    LIMIT 20;

-- Actores Inmortales
-- ¿Cúales son los actores que actuaron en un film antes de 1900 y también en un film después del 2000?

-- NOTA: no estamos pidiendo todos los actores pre-1900 y post-2000, sino aquellos que hayan trabajado en ambas eras.

SELECT actors.first_name, actors.last_name, actors.id 
FROM roles
JOIN actors ON roles.actor_id = actors.id

WHERE actor_id IN (
SELECT actor_id 
FROM roles
WHERE movie_id IN (
SELECT id
FROM movies
WHERE year < 1900
))

AND actor_id IN (
SELECT actor_id 
FROM roles
WHERE movie_id IN (
SELECT id
FROM movies
WHERE year > 2000
))

GROUP BY first_name, last_name, id;

-- Ocupados en Filmación
-- Buscá actores que hayan tenido cinco, o más, roles distintos en la misma película luego del año 1990.

-- Escribí un query que retorne el nombre del actor, el nombre de la película y el número de roles distintos que hicieron en esa película (que va a ser ≥5).

--tablas actores, roles y peliculas

SELECT actors.first_name, actors.last_name, movies.name, movies.year

FROM roles
JOIN actors ON roles.actor_id = actors.id

JOIN movies
ON roles.movies_id = movies.id


LIMIT 10;


-- ♀
-- Contá los números de películas que tuvieron sólo actrices. Dividilas por año.

-- Empezá por incluir películas sin reparto pero, luego, estrechá tu búsqueda a películas que tuvieron reparto.


SELECT movies.year 




