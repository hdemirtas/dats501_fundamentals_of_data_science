              ---------------------------
---------------------- 1 - SELECT ----------------------
              ---------------------------

-- 1.1 SELECT
------------------------------------------------------------------
-- select a column -- from -> select
SELECT first_name FROM DATS501.sales.customers
----------------------

------------------------------------------------------------------
-- select multiple columns
SELECT
     first_name
    ,last_name
    ,email
FROM
    sales.customers;
----------------------

------------------------------------------------------------------
-- select all
SELECT * FROM sales.customers
----------------------

------------------------------------------------------------------
-- count
SELECT COUNT(*) FROM sales.customers
----------------------


-- 1.2 FILTER
------------------------------------------------------------------
-- where -- from -> where -> select 
SELECT * FROM sales.customers WHERE state = 'CA' 
----------------------	


-- 1.3 ORDER BY
------------------------------------------------------------------
-- sort -- from -> where -> select -> order by
SELECT * FROM sales.customers WHERE state = 'CA' order by city desc -- asc is the reverse
----------------------

------------------------------------------------------------------
-- sort by an expression
SELECT
    first_name,
    last_name
FROM sales.customers
ORDER BY LEN(first_name) DESC
----------------------

------------------------------------------------------------------
-- sort by column position
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    1,
    2;
----------------------


-- 1.4 GROUP BY
------------------------------------------------------------------
-- order by -- from -> where -> group by -> select
SELECT
    city,
    COUNT (*)
FROM sales.customers
WHERE state = 'CA'
GROUP BY city
----------------------	

-- naming a column
SELECT
    city,
    COUNT (*) as quantity
FROM sales.customers
WHERE state = 'CA'
GROUP BY city
----------------------	


-- 1.5 HAVING
------------------------------------------------------------------
-- having count 
SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
HAVING
    COUNT (*) > 10
ORDER BY
    city
----------------------	


-- 1.6 DISTINCT
------------------------------------------------------------------
--  
SELECT DISTINCT city, state, zip_code FROM sales.customers
----------------------	

-- trying distinct with group by 
SELECT city, state, zip_code 
FROM sales.customers 
GROUP BY city, state, zip_code
ORDER BY city, state, zip_code
----------------------	


              ---------------------------
---------------------- 2 - ROW FILTER ----------------------
              ---------------------------

-- 2.1 OFFSET
------------------------------------------------------------------
--  
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS;
----------------------

--  
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;
----------------------

-- 2.2 TOP
------------------------------------------------------------------
--  
SELECT TOP 10
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;
----------------------

-- percent 
SELECT TOP 1 PERCENT
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;
----------------------

-- ties: bring rows with the same value of the last top element 
SELECT TOP 3 WITH TIES
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;
----------------------

--
SELECT TOP 8 WITH TIES
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;
----------------------

-- 2.3 NULL
------------------------------------------------------------------
--  
SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE phone IS NULL
ORDER BY first_name, last_name
----------------------

--  equal to NULL does not work
SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE phone = NULL
ORDER BY first_name, last_name
----------------------

--  NOT NULL
SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE phone IS NOT NULL
ORDER BY first_name, last_name
----------------------


              ---------------------------
---------------------- 3 - LOGIC OPERATIONS ----------------------
              ---------------------------

-- 3.1 AND
------------------------------------------------------------------
--  
SELECT *
FROM production.products
WHERE
    category_id = 1
AND list_price > 400
AND brand_id = 1
ORDER BY
    list_price DESC
----------------------

-- 3.2 OR
------------------------------------------------------------------
--  
SELECT *
FROM production.products
WHERE
    brand_id = 1
OR brand_id = 2
ORDER BY
    brand_id DESC
----------------------

-- AND OR together: AND has priority but it is not a good practice to use LOGICAL OPERATORS without paranthesis
SELECT *
FROM production.products
WHERE
    brand_id = 1
OR brand_id = 2
ORDER BY
    brand_id DESC
----------------------

-- 3.3 IN
------------------------------------------------------------------
--  
SELECT
    product_name,
    list_price
FROM production.products
WHERE list_price IN (89.99, 109.99, 159.99)
ORDER BY list_price
----------------------

--  equivalent
SELECT
    product_name,
    list_price
FROM production.products
WHERE list_price = 89.99 OR list_price = 109.99 OR list_price = 159.99
ORDER BY list_price
----------------------

-- negative
SELECT
    product_name,
    list_price
FROM production.products
WHERE list_price NOT IN (89.99, 109.99, 159.99)
ORDER BY list_price
----------------------

-- subquery use
SELECT
    product_name,
    list_price
FROM production.products
WHERE
    product_id IN ( SELECT product_id 
	                  FROM production.stocks
					 WHERE store_id = 1 AND quantity >= 30
    )
ORDER BY product_name
----------------------

-- 3.4 BETWEEN
------------------------------------------------------------------
--  
SELECT
    product_id,
    product_name,
    list_price
FROM production.products
WHERE list_price BETWEEN 149.99 AND 199.99
ORDER BY list_price
----------------------

--  negative
SELECT
    product_id,
    product_name,
    list_price
FROM production.products
WHERE list_price NOT BETWEEN 149.99 AND 199.99
ORDER BY list_price
----------------------

--  date
SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM sales.orders
WHERE order_date BETWEEN '2017-01-15' AND '2017-01-17' -- also accepts format '20170115' AND '20170117'
ORDER BY order_date
----------------------

-- 3.5 LIKE
------------------------------------------------------------------
-- %: represents single or multiple characters
-- ending with percent wildcard
SELECT
    customer_id,
    first_name,
    last_name
FROM sales.customers
WHERE last_name LIKE 'z%'
ORDER BY first_name
----------------------

-- starting with percent wildcard
SELECT
    customer_id,
    first_name,
    last_name
FROM sales.customers
WHERE last_name LIKE '%er'
ORDER BY first_name
----------------------

-- percent wildcard in the middle
SELECT
    customer_id,
    first_name,
    last_name
FROM sales.customers
WHERE last_name LIKE 't%s'
ORDER BY first_name
----------------------

-- _: represents a single characters
SELECT
    customer_id,
    first_name,
    last_name
FROM sales.customers
WHERE last_name LIKE '_u%'
ORDER BY first_name
----------------------

-- []: represents a single character that must be one of the characters specified in the list
SELECT
    customer_id,
    first_name,
    last_name
FROM sales.customers
WHERE last_name LIKE '[YZ]%'
ORDER BY last_name
----------------------

-- [ - ]: represent a single character that must be within a specified range
SELECT
    customer_id,
    first_name,
    last_name
FROM sales.customers
WHERE last_name LIKE '[A-C]%'
ORDER BY last_name
----------------------

-- [ ^ - ]: represent a single character that must NOT be within a specified range
SELECT
    customer_id,
    first_name,
    last_name
FROM sales.customers
WHERE last_name LIKE '[^A-C]%'
ORDER BY last_name
----------------------

-- DROP TABLE, CREATE TABLE, TEMPORARY TABLE
DROP TABLE IF EXISTS SALES.##TEMP
SELECT *
      ,CASE WHEN first_name LIKE 'A%' THEN 'TODAY WE HAVE 30% DISCOUNT' 
	        WHEN first_name LIKE 'B%' THEN 'JUST 30' 
	        ELSE 'NO_DISCOUNT' 
	    END AS DISCOUNT 
INTO SALES.##TEMP 
FROM sales.customers 

-- ESCAPE: It instructs the LIKE operator to treat the % character as a literal string instead of a wildcard
SELECT * FROM SALES.##TEMP WHERE DISCOUNT LIKE '%30!%%' ESCAPE '!'
----------------------

-- without ESCAPE
SELECT * FROM SALES.##TEMP WHERE DISCOUNT LIKE '%30%'
----------------------
