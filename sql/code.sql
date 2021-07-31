CREATE TABLE products (name VARCHAR(20), price INT, city INT)

INSERT INTO products VALUES('a', 10, 3)
INSERT INTO products VALUES('b', 15, 1)
INSERT INTO products VALUES('e', 15, NULL)
INSERT INTO products VALUES('c', 20, 2)
INSERT INTO products VALUES('d', 20, 2)


SELECT * FROM products
-------------------------------------------------------------

CREATE TABLE cities (id int, city VARCHAR(20))

INSERT INTO cities VALUES(1, 'Cracow')
INSERT INTO cities VALUES(2, 'Warsaw')
INSERT INTO cities VALUES(3, 'Crosno')

SELECT * From cities
-------------------------------------------------------------

-- assignign all items with lower prices to each item with higher price
SELECT *
FROM products AS A
JOIN products AS B
ON A.price > B.price

-- 0 in WHERE when we want to take all products with the highest price
-- 1 in WHERE when we want to take all products with the second highest price
SELECT name, price
FROM products AS A
WHERE 0 = (
    SELECT COUNT(DISTINCT price)
    FROM products AS B
    WHERE B.price > A.price
)


-- product(s) with the biggest price
SELECT name, price
FROM (
  SELECT name, price, DENSE_RANK() OVER(ORDER BY price) AS r
  FROM products)
WHERE r = (
SELECT DENSE_RANK() OVER(ORDER BY price) AS r
  FROM products
  ORDER BY r DESC  --- DESC for max ASC for min
  LIMIT 1
)


SELECT
    CASE WHEN price < 15 THEN "rejected"
    WHEN price = 15 THEN "pending"
        ELSe "approved" END AS status,
COUNT(*) AS "Count"
FROM products
GROUP BY status
HAVING COUNT(*) > 1
ORDER BY status DESC

-- items and cities with two lowest prices
SELECT p.name, p.price, c.city
FROM products p
JOIN cities c
ON p.city = c.id
WHERE p.price IN (
  SELECT DISTINCT pp.price
  FROM products pp
  ORDER BY price ASC
  LIMIT 2
)


-- temporary table
CREATE TABLE temp_products (name VARCHAR(20), price INT, city INT)

INSERT INTO temp_products (name, price, city)
SELECT name, price, city
FROM products
WHERE price > 10

SELECT *
FROM temp_products

SELECt * FROM products
EXCEPT
SELECT * FROM temp_products

SELECt * FROM products
INTERSECT
SELECT * FROM temp_products

-- view
CREATE VIEW v_products
AS
SELECT name, price, city
FROM products
WHERE price > 10


-- view gets updated automatically when new record inserted to the original table
-- temporary table doesn't get updated
SELECT *
FROM v_products


-- exists

SELECT p.name, p.price
FROM products p
WHERE EXISTS (
  SELECT 1
  FROM v_products v
  WHERE p.name = v.name
)

-- IS NOT NULL
SELECT name
FROM products
WHERE city IS NOT NULL

-- Handling nulls
SELECT p.name, CASE WHEN c.city IS NULL THEN 'Unknown' ELSE c.city END AS 'city'
FROM products p
LEFT JOIN cities c
ON p.city = c.id

-- coounting not nulls
SELECT c.city, SUM( CASE WHEN c.city is NOT NULL THEN 1 ELSE 0 END ) AS 'count'
FROM products p
LEFT JOIN cities c
ON p.city = c.id
WHERE c.city IS NOT NULL
GROUP BY c.city

-- LAG

SELECT
	name,
    price,
    LAG(price) OVER (ORDER BY price) AS 'prev_val'
FROM products

-- running total

SELECT
	name,
    price,
    SUM(price) OVER (ORDER BY name) AS 'prev_val'
FROM products


SELECT p1.name, p1.price, SUM(p2.price)
FROM products p1
JOIN products p2
ON p1.name >= p2.name
GROUP BY p1.name

-- percentage
SELECT
	name,
    price,
    (price - LAG(price) OVER (ORDER BY price)) * 100  / LAG(price) OVER (ORDER BY price) AS perct_diff
from products


--  ntile - taking prducts with the middle range or prices
SELECT name, ntile
FROM (
  SELECT
      name,
      price,
      NTILE(3) OVER(ORDER BY price) as 'ntile'
  FROM products p1)
WHERE ntile = 2

UPDATE products
SET price = price * 0.9
WHERE city IS NULL



-- EXISTS - in sub-query i need to have a referenc to the table from outer query
SELECT name
FROM products p1
WHERE EXISTS (
	SELECT 1
	FROM products p2
	WHERE p1.name = p2.name AND p2.price > 15
)
