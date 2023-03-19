DROP FUNCTION fn_get_actors_movies;
CREATE OR REPLACE FUNCTION fn_get_actors_movies(param_firstName varchar(45),param_lastName varchar(45))
RETURNS table
(
	first_name varchar(45),
	last_name varchar(45),
	title varchar(255),
	release_year year,
	rating mpaa_rating,
	description text
)
AS
$$
BEGIN
		RETURN QUERY
		SELECT a.first_name,
			   a.last_name,
			   f.title Movie,
			   f.release_year,
			   f.rating,
			   f.description
		FROM actor a,
			 film f,
			 film_actor fa
		WHERE a.actor_id=fa.actor_id
		  AND fa.film_id=f.film_id
		  AND UPPER(a.first_name) LIKE UPPER('%'||param_firstName||'%')
		  AND UPPER(a.last_name) LIKE UPPER('%'||param_lastName||'%');
END;
$$
language plpgsql;


--Test:
--select * from fn_get_actors_movies('Pene','PIN');
--select * from fn_get_actors_movies('char','e');

