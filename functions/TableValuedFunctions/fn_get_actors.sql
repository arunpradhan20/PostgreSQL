CREATE OR REPLACE FUNCTION fn_get_actors(searchBy search_type,param_firstName varchar(45))
RETURNS table
(
	actor_id integer,
	first_name varchar(45),
	last_name varchar(45)
)
AS
$$
BEGIN
	IF searchBy = 'startsWith' THEN
		RETURN QUERY
		SELECT 
			act.actor_id,
			act.first_name,
			act.last_name
		 FROM actor act
		WHERE UPPER(act.first_name) like UPPER(param_firstName) || '%';
		
	ELSIF searchBy ='endsWith' THEN
		RETURN QUERY
		SELECT 
			act.actor_id,
			act.first_name,
			act.last_name
		 FROM actor act
		WHERE UPPER(act.first_name) like '%' || UPPER(param_firstName);
		
	ELSIF searchBy = 'contains' THEN
		RETURN QUERY
		SELECT 
			act.actor_id,
			act.first_name,
			act.last_name
		 FROM actor act
		WHERE UPPER(act.first_name) like '%' || UPPER(param_firstName) || '%';
	END IF;
END;
$$
language plpgsql;


--Test:
--select * from fn_get_actors('startsWith','e');
--select * from fn_get_actors('endsWith','e');
--select * from fn_get_actors('contains','ic');

