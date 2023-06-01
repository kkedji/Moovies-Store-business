-- Moovies store data analysis project

USE Moovies;

-- let's remove the quotation marks from the value of each column in the tables where it exists
-- The quotation marks were imported with the values as stored in the csv file.

-- Table actor
UPDATE [actor]
SET ["first_name"] = SUBSTRING(["first_name"], 2, LEN(["first_name"]) - 2);
UPDATE [actor]
SET ["last_name"] = SUBSTRING(["last_name"], 2, LEN(["last_name"]) - 2);
UPDATE [actor]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table actor_award
UPDATE [actor_award]
SET ["first_name"] = SUBSTRING(["first_name"], 2, LEN(["first_name"]) - 2);
UPDATE [actor_award]
SET ["last_name"] = SUBSTRING(["last_name"], 2, LEN(["last_name"]) - 2);
UPDATE [actor_award]
SET ["awards"] = SUBSTRING(["awards"], 2, LEN(["awards"]) - 2);
UPDATE [actor_award]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table address
UPDATE [address]
SET ["address"] = SUBSTRING(["address"], 2, LEN(["address"]) - 2);
UPDATE [address]
SET ["district"] = SUBSTRING(["district"], 2, LEN(["district"]) - 2);
UPDATE [address]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);
UPDATE [address]
SET ["postal_code"] = SUBSTRING(["postal_code"], 2, LEN(["postal_code"]) - 2);
UPDATE [address]
SET ["phone"] = SUBSTRING(["phone"], 2, LEN(["phone"]) - 2);

-- Table advisor
UPDATE [advisor]
SET ["first_name"] = SUBSTRING(["first_name"], 2, LEN(["first_name"]) - 2);
UPDATE [advisor]
SET ["last_name"] = SUBSTRING(["last_name"], 2, LEN(["last_name"]) - 2);

-- Table category
UPDATE [category]
SET ["name"] = SUBSTRING(["name"], 2, LEN(["name"]) - 2);
UPDATE [category]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table city
UPDATE [city]
SET ["city"] = SUBSTRING(["city"], 2, LEN(["city"]) - 2);
UPDATE [city]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table country
UPDATE [country]
SET ["country"] = SUBSTRING(["country"], 2, LEN(["country"]) - 2);
UPDATE [country]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table customer
UPDATE [customer]
SET ["first_name"] = SUBSTRING(["first_name"], 2, LEN(["first_name"]) - 2);
UPDATE [customer]
SET ["last_name"] = SUBSTRING(["last_name"], 2, LEN(["last_name"]) - 2);
UPDATE [customer]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);
UPDATE [customer]
SET ["email"] = SUBSTRING(["email"], 2, LEN(["email"]) - 2);
UPDATE [customer]
SET ["create_date"] = SUBSTRING(["create_date"], 2, LEN(["create_date"]) - 2);

-- Table film_actor
UPDATE [film_actor]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table film_category
UPDATE [film_category]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table inventory
UPDATE [inventory]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table investor
UPDATE [investor]
SET ["first_name"] = SUBSTRING(["first_name"], 2, LEN(["first_name"]) - 2);
UPDATE [investor]
SET ["last_name"] = SUBSTRING(["last_name"], 2, LEN(["last_name"]) - 2);
UPDATE [investor]
SET ["company_name"] = SUBSTRING(["company_name"], 2, LEN(["company_name"]) - 2);

-- Table langage
UPDATE [language]
SET ["name"] = SUBSTRING(["name"], 2, LEN(["name"]) - 2);

UPDATE [language]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table payment
UPDATE [payment]
SET ["payment_date"] = SUBSTRING(["payment_date"], 2, LEN(["payment_date"]) - 2);
UPDATE [payment]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table payment
UPDATE [rental]
SET ["rental_date"] = SUBSTRING(["rental_date"], 2, LEN(["return_date"]) - 2);
UPDATE [rental]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);
UPDATE [rental]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- Table staff
UPDATE [staff]
SET ["first_name"] = SUBSTRING(["first_name"], 2, LEN(["first_name"]) - 2);
UPDATE [staff]
SET ["last_name"] = SUBSTRING(["last_name"], 2, LEN(["last_name"]) - 2);
UPDATE [staff]
SET ["username"] = SUBSTRING(["username"], 2, LEN(["username"]) - 2);
UPDATE [staff]
SET ["email"] = SUBSTRING(["email"], 2, LEN(["email"]) - 2);
UPDATE [staff]
SET ["password"] = SUBSTRING(["password"], 2, LEN(["password"]) - 2);

-- Table store
UPDATE [store]
SET ["last_update"] = SUBSTRING(["last_update"], 2, LEN(["last_update"]) - 2);

-- END