-- Moovies store data analysis project - answering business questions

USE Moovies;

-- Q1 - My partner and I want to come by each of the stores in person and meet the managers. 
      --Please send over the manager's name at each store, with the full address of each property 
	  --(street address, district, city and country)

SELECT 
      st.["store_id"],
      CONCAT(sf.["first_name"], ' ',sf.["last_name"]) as manager,
	  ad.["address"],
	  ad.["district"],
	  cy.["city"],
	  ct.["country"]
      FROM staff sf
	  JOIN store st
	  ON sf.["store_id"] = st.["store_id"]
	  JOIN address ad
	  ON st.["address_id"]= ad.["address_id"]
	  JOIN city cy
	  ON ad.["city_id"] = cy.["city_id"]
	  JOIN country ct
	  ON cy.["country_id"] = ct.["country_id"]
	  WHERE sf.["staff_id"] = st.["manager_staff_id"];


--Q2 -- I would like to have a better understanding of all the inventory that would come along with the business. 
     -- Please pull together a list of each inventory item you have stocked, including the store id number, 
	 -- inventory id, the name of the film, the film's rating, its rental rate and replacement cost.

SELECT 
      iv.["store_id"],
      iv.["inventory_id"],
	  fm.title,
	  fm.rating,
	  fm.rental_rate,
	  fm.replacement_cost
	  FROM inventory iv
	  JOIN film fm
	  ON iv.["film_id"] = fm.film_id;
	

-- Q3 -- From the previous list of films pulled in Q2, please roll that data up and provide a summarry level overview 
      -- of your inventory. We would like to know how many inventory items you have with each rating at each store.

SELECT 
      ["store_id"],
	  rating,
	  COUNT(["inventory_id"]) #Inventory
	  FROM (
	         SELECT 
                    iv.["store_id"],
                    iv.["inventory_id"],
	                fm.title,
	                fm.rating,
	                fm.rental_rate,
	                fm.replacement_cost
	                FROM inventory iv
	                JOIN film fm
	                ON iv.["film_id"] = fm.film_id
			 ) AS av
		GROUP BY ["store_id"], rating
		ORDER BY ["store_id"];

-- Q4 -- Similarly, we want to understand how diversified the inventory is in term of replacement cost. 
      -- We want to see how big of a hit it would be if a certain category of film became unpopular at a certain store. 
	  -- We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
	  -- sliced by store and film category.

	  SELECT 
	        iv.["store_id"] AS store_id,
			c.["name"] AS film_category,
			COUNT(*) AS #films,
	        ROUND(AVG(fm.replacement_cost),2) AS avg_rep_cost,
			CEILING(SUM(replacement_cost)) AS total_cost
	        FROM inventory iv
			JOIN film fm
			ON iv.["film_id"] = fm.film_id
			JOIN film_category fc
			ON fc.["film_id"]=fm.film_id
			JOIN category c
			ON c.["category_id"] = fc.["category_id"]
			GROUP BY iv.["store_id"],c.["name"]
			ORDER BY iv.["store_id"];

-- Q5 -- We want to make sure you folks have a good handle on who your customers are. Please provide a list of all customers name
      -- which store they go to, wheter or not they are currently active, their full addresses- street address, city and country

SELECT 
      CONCAT(ct.["first_name"], ' ', ct.["last_name"]) AS customer_name,
	  ct.["store_id"],
	  CASE 
	      WHEN ct.["active"] = 1 THEN 'active'
	      WHEN ct.["active"] = 0 THEN 'inactive'
		  ELSE ''
	  END AS customer_status,
	  ad.["address"],
	  cy.["city"],
	  cty.["country"]
      FROM customer ct
	  JOIN address ad
	  ON ct.["address_id"] = ad.["address_id"]
      JOIN city cy 
	  ON cy.["city_id"] = ad.["city_id"]
	  JOIN country cty
	  ON cy.["country_id"] = cty.["country_id"]
	  ORDER BY ct.["store_id"];

-- Q6 -- We would like to understand how much your customers are spending with you, and also know who your most valuable 
      -- customers are. Please pull together a list of customer names, their total lifetime rentals, and the sum of all 
	  -- payments you have collected from them. it would be great to see this ordered on total lifetime value with the most 
	  -- valuable customers at the top of the list.

SELECT 
      CONCAT(ct.["first_name"], ' ', ct.["last_name"]) AS customer_name,
	  COUNT(pmt.["rental_id"]) AS total_lifetime_rental,
	  SUM(CAST(pmt.["amount"] AS decimal)) AS total_lifetime_value
	  FROM customer ct
	  JOIN payment pmt
	  ON ct.["customer_id"] = pmt.["customer_id"]
	  GROUP BY CONCAT(ct.["first_name"], ' ', ct.["last_name"])
	  ORDER BY total_lifetime_value DESC;


-- Q7 -- My partner and I would like to get to know your board of advisors and any current investors. Could you please provide 
      -- a list of advisor and investor names in one table? could you please note whether they are an investor or and advisor , 
	  -- and for the investors, it would be good to include which company they work with.

SELECT
      CONCAT(["first_name"], ' ', ["last_name"]) AS name,
	  'investor' AS role,
	  ["company_name"] as company
	  FROM investor
UNION ALL
SELECT
      CONCAT(["first_name"], ' ', ["last_name"]) AS name,
	  'advisor' AS role,
	   '-'  AS company
	  FROM advisor;

-- Q8 -- We are interested in how well you have covered the most awarded actors. Of all the actors with three types of awards, 
      -- for what % of them do we carry a film? and how about actors with two types af awards,and finally how about actors with 
	  -- just one award?
			
-- Let's us first find the total actors awarded by number of awards by the actor award table. 

SELECT
      award_count,
      COUNT(actor) as total_actors_awarded
	  FROM 
	   ( 
	    SELECT
        ["actor_id"],
        CONCAT(["first_name"], ' ', ["last_name"]) AS actor,
        CASE
        WHEN ["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Oscar%' AND ["awards"] LIKE '%Tony%' THEN 3
        WHEN (["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Oscar%') OR (["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Tony%') OR (["awards"] LIKE '%Oscar%' AND ["awards"] LIKE '%Tony%') THEN 2
        ELSE 1 
        END AS award_count
        FROM actor_award
		) a
       GROUP BY award_count;

-- lets's retrieve the numbers of actors per the number of award in the films in our inventory.

WITH A AS
        (SELECT
        ["actor_id"],
        CASE
        WHEN ["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Oscar%' AND ["awards"] LIKE '%Tony%' THEN 3
        WHEN (["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Oscar%') OR (["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Tony%') OR (["awards"] LIKE '%Oscar%' AND ["awards"] LIKE '%Tony%') THEN 2
        ELSE 1 
        END AS award_count
        FROM actor_award), 
B AS
       (SELECT 
        fa.["actor_id"],
        COUNT(iv.["film_id"]) AS number_of_films
	    FROM inventory iv
	    JOIN film fm
	    ON fm.film_id = iv.["film_id"]
	    JOIN film_actor fa
	    ON fa.["film_id"] = fm.film_id
	    GROUP BY fa.["actor_id"]
	    ) 
SELECT 
       A.award_count,
       COUNT(A.["actor_id"]) AS iv_actors_num
	   FROM A
	   JOIN B
	   ON A.["actor_id"] = B.["actor_id"]
	   GROUP BY A.award_count

-- We will finally  use the two previous result as a CTE to compare and calculate the proportion for each group of award number

WITH 

A AS
        (SELECT
        ["actor_id"],
        CASE
        WHEN ["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Oscar%' AND ["awards"] LIKE '%Tony%' THEN 3
        WHEN (["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Oscar%') OR (["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Tony%') OR (["awards"] LIKE '%Oscar%' AND ["awards"] LIKE '%Tony%') THEN 2
        ELSE 1 
        END AS award_count
        FROM actor_award), 
B AS
       (SELECT 
        fa.["actor_id"],
        COUNT(iv.["film_id"]) AS number_of_films
	    FROM inventory iv
	    JOIN film fm
	    ON fm.film_id = iv.["film_id"]
	    JOIN film_actor fa
	    ON fa.["film_id"] = fm.film_id
	    GROUP BY fa.["actor_id"]
	    ),
CTE1 AS
      (SELECT 
       A.award_count,
       COUNT(A.["actor_id"]) AS iv_actors_num
	   FROM A
	   JOIN B
	   ON A.["actor_id"] = B.["actor_id"]
	   GROUP BY A.award_count),

CTE2 AS
   (SELECT
      award_count,
      COUNT(actor) as total_actors_awarded
	  FROM 
	   ( 
	    SELECT
        ["actor_id"],
        CONCAT(["first_name"], ' ', ["last_name"]) AS actor,
        CASE
        WHEN ["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Oscar%' AND ["awards"] LIKE '%Tony%' THEN 3
        WHEN (["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Oscar%') OR (["awards"] LIKE '%Emmy%' AND ["awards"] LIKE '%Tony%') OR (["awards"] LIKE '%Oscar%' AND ["awards"] LIKE '%Tony%') THEN 2
        ELSE 1 
        END AS award_count
        FROM actor_award
		) a
GROUP BY award_count)

SELECT 
       CTE1.award_count,
	   CTE2.total_actors_awarded,
	   CTE1.iv_actors_num,
	   FORMAT((CAST(CTE1.iv_actors_num AS decimal)/CTE2.total_actors_awarded)*100.0, '0.00') AS percent_covered
       FROM CTE1
	   JOIN CTE2 
	   ON CTE1.award_count = CTE2.award_count


END