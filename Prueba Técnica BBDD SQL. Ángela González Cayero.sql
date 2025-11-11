USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.   DISTINT justamente para no mostrar los duplicados.
SELECT * 
FROM film;

-- CÓDIGO ----------------------------------
SELECT DISTINCT title AS títulos_de_las_películas           
FROM film;



-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT * 
FROM film;

-- CÓDIGO ----------------------------------
SELECT title AS título_de_las_películas, rating AS clasificacion_de_supervision 
FROM film
WHERE rating = 'PG-13';



-- 3. Encuentra el título y la descripción de todas las películas que contengan la cadena de caracteres "amazing" en su descripción.
SELECT * 
FROM film;

-- CÓDIGO ----------------------------------
SELECT title AS nombre_de_las_películas, description AS descripción
FROM film
WHERE description LIKE "%amazing%";



-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT * 
FROM film;

-- CÓDIGO ----------------------------------
SELECT title AS nombre_de_las_peliculas, length AS duración_de_las_peliculas 
FROM film
WHERE length > 120;



-- 5. Recupera los nombres y apellidos de todos los actores.
SELECT *
FROM actor;

-- CÓDIGO 1. Si quiero que aparezcan en cada columna ----------------------------------
SELECT first_name AS nombre, last_name AS apellido
FROM actor;

-- CÓDIGO 2. Si quiero que aparezcan en una sola columna ------------------------------
SELECT CONCAT(first_name, ' ', last_name) AS nombre_y_apellido
FROM actor;

 

-- 6. Encuentra el nombre y apellidos de los actores que tengan "Gibson" en su apellido.
SELECT *
FROM actor;

-- CÓDIGO ----------------------------------
SELECT first_name AS nombre, last_name AS apellido
FROM actor
WHERE last_name = "Gibson";



-- 7. Encuentra los nombres y apellidos de los actores que tengan un actor_id entre 10 y 20.
SELECT *
FROM actor;

-- CÓDIGO ----------------------------------
SELECT first_name AS nombre, last_name AS apeliido, actor_id 
FROM actor
WHERE actor_id BETWEEN 10 AND 20;



-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT * 
FROM film;

-- CÓDIGO ----------------------------------
SELECT title AS titulo_de_las_peliculas, rating AS supervision_de_un_adulto_ni_R_ni_PG13
FROM film
WHERE rating NOT IN ('R', 'PG-13'); 
-- NOTA: Aunque has dicho clasificación, pero como en una consulta anterior ya habia puesto que rating es supervisión para adultos, he querido mantener el mismo alias, aunque es la clasificación de la supervisión para adultos. =)



-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
SELECT *
FROM film; 

-- CÓDIGO ----------------------------------
SELECT rating AS supervisión_de_un_adulto, COUNT(*) recuento_de_las_peliculas
FROM film
GROUP BY rating;



-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas por cliente.
SELECT *
FROM customer;

SELECT *
FROM rental;

-- CÓDIGO ----------------------------------
SELECT c.customer_id AS id_del_cliente, c.first_name AS nombre, c.last_name AS apellido, COUNT(r.rental_id) AS cantidad_de_peliculas_alquiladas_por_cliente
FROM customer c
INNER JOIN rental r 
    ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY cantidad_de_peliculas_alquiladas_por_cliente DESC;



-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
-- NOTA. Tenemos que unir las tablas: rental, category, inventory, film_category.
SELECT *
FROM rental;

SELECT *
FROM inventory;

SELECT *
FROM film_category;

SELECT *
FROM category;

-- CÓDIGO ----------------------------------
SELECT c.name AS nombre_de_la_categoria, COUNT(r.rental_id) AS cantidad_de_peliculas_alquiladas_por_categoria
FROM Rental r
INNER JOIN inventory i 
ON i.inventory_id = r.inventory_id
INNER JOIN Film_category fc 
ON fc.film_id = i.film_id 
INNER JOIN category c 
ON c.category_id = fc.category_id 
GROUP BY nombre_de_la_categoria
ORDER BY cantidad_de_peliculas_alquiladas_por_categoria DESC;



-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
-- NOTA. Tenemos que unir las tablas: film (length), film (rating) (nota: = clasificación = supervisión_de_un_adulto)
SELECT *
FROM film;

-- CÓDIGO ----------------------------------
SELECT rating AS clasificacion, AVG (length) AS promedio_de_duracion_de_las_peliculas
FROM film
GROUP BY rating
ORDER BY promedio_de_duracion_de_las_peliculas DESC;



-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
-- NOTA: Tenemos que unir las tablas: film (film_id y title), film_actor (actor_id) y actor (actor_id).
SELECT *
FROM film;

SELECT * 
FROM film_actor;

SELECT *
FROM actor;

-- CÓDIGO ----------------------------------
SELECT a.first_name AS nombre, a.last_name, f.title AS título
FROM actor a
INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
INNER JOIN film f
ON f.film_id = fa.film_id
WHERE f.title = "Indian Love";



-- 14. Muestra el título de todas las películas que contengan la cadena de caracteres "dog" o "cat" en su descripción.
-- NOTA: Tenemos que buscar en la tabla film (title y descripcion)
SELECT *
FROM film;

-- CÓDIGO ----------------------------------
SELECT title AS titulo, description AS descripcion
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';



-- 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
-- NOTA: Tenemos que buscar en la tabla actor(actor_id) y film_actor (actor_id, firt_name)
SELECT *
FROM actor;

SELECT *
FROM film_actor;

-- CÓDIGO ----------------------------------
SELECT a.actor_id AS actor, a.first_name AS nombre
FROM actor a
WHERE a.actor_id NOT IN
	(SELECT fa.actor_id
	 FROM film_actor fa);



-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
-- NOTA: Tenemos que buscar en la tabla film (release_year) = lanzamiento
SELECT *
FROM film;

-- CÓDIGO ----------------------------------
SELECT title AS titulo, release_year AS lanzamiento
FROM film
WHERE release_year BETWEEN 2005 AND 2010;



-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
-- NOTA: Tenemos que buscar en la tabla film(title), film_category y category. 
SELECT *
FROM film;

SELECT *
FROM film_category;

SELECT *
FROM category;

-- CÓDIGO ----------------------------------
SELECT f.title AS título_de_las_peliculas, c.name AS categorias
FROM film f
INNER JOIN film_category fc
ON fc.film_id = f.film_id
INNER JOIN category c
ON c.category_id = fc.category_id
WHERE c.name = 'Family';



-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
-- NOTA: Tenemos que buscar en las tablas film_actor y actor.
SELECT*
FROM film_actor;

SELECT * 
FROM actor; 

-- CÓDIGO ----------------------------------
SELECT a.first_name AS nombre, a.last_name AS apellido, COUNT(fa.film_id) AS peliculas
FROM actor a
INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10;



-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
-- NOTA: Tenemos que buscar en las tabla film (title, rating y length)
SELECT *
FROM film;

-- CÓDIGO ----------------------------------
SELECT title AS título_de_las_peliculas, rating AS clasificacion, length AS duración_minutos
FROM film
WHERE rating = "R" AND length > 120;



-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
-- NOTA: Tenemos que buscar en las tabla film(length), film_categody(film_id, category_id) y category(name).
SELECT *
FROM film;

SELECT *
FROM film_category;

SELECT *
FROM category;

-- CÓDIGO ----------------------------------
SELECT c.name AS categorias, AVG(length) AS promedio_de_duracion_de_las_peliculas
FROM category c
INNER JOIN film_category fc
ON fc.category_id = c.category_id
INNER JOIN film f
ON f.film_id = fc.film_id
GROUP BY c.name
HAVING AVG(f.length) > 120;



-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
-- NOTA: Tenemos que buscar en las tabla film(actor_id, first_name, last_name) y film_actor(actor_id, film_id)
SELECT* 
FROM actor;

SELECT*
FROM film_actor;

-- CÓDIGO ----------------------------------
SELECT a.first_name AS nombre, a.last_name AS apellido, COUNT(fa.film_id) AS cantidad_de_peliculas_en_las_que_han_actuado
FROM film_actor fa
INNER JOIN actor a
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) >= 5;



-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
-- NOTA: Tenemos que buscar en las tablas film(title), rental(rental_id, rental_date,return_date) e inventory(inventory_id, film_id)
SELECT * 
FROM film;

SELECT * 
FROM rental;

SELECT * 
FROM inventory;

-- CÓDIGO ----------------------------------
SELECT f.title AS titulos_de_las_peliculas
FROM film f
INNER JOIN inventory i 
ON i.film_id = f.film_id
WHERE i.inventory_id IN
    (SELECT r.inventory_id
    FROM rental r
    WHERE DATEDIFF(r.return_date, r.rental_date) > 5);



-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
-- NOTA: Tenemos que buscar en las tablas actor(actor_id, first_name, last_name), film_actor(actor_id,film_id), category (name) y film_category(film_id, category_id).
SELECT * 
FROM actor;

SELECT * 
FROM film_actor;

SELECT * 
FROM category;

SELECT * 
FROM film_category;

-- CÓDIGO ----------------------------------
SELECT a.first_name AS nombre, a.last_name AS apellido
FROM actor a
WHERE a.actor_id NOT IN 
	(SELECT fa.actor_id
    FROM film_actor fa
    INNER JOIN film_category fc 
    ON fc.film_id = fa.film_id
    INNER JOIN category c 
    ON c.category_id = fc.category_id 
    WHERE c.name = 'Horror');
    
    
    
-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
-- NOTA: Tenemos que buscar en las tablas film(title, length), film_category(film_id, category_id) y category(name = comedy).

SELECT *
FROM film;

SELECT *
FROM category;

SELECT *
FROM film_category;

-- CÓDIGO ----------------------------------
SELECT f.title AS título_de_las_películas, c.name AS categorias
FROM film f
INNER JOIN film_category fc
ON fc.film_id = f.film_id
INNER JOIN category c 
ON c.category_id = fc.category_id    
WHERE c.name = "Comedy" AND f.length > 180;




/*
 
  ********     ********
 **********   **********
************ ************
**************************
 *************************
  **********************
   ********************
     ****************
       ************
         ********
           ****
            
*/









    
    
    
    
