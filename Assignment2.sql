--Q1> Write a query to display customer list by the first name in descending order.

SELECT first_name FROM SALES.customers
ORDER BY first_name;

--Q2>

SELECT first_name,last_name,city FROM SALES.customers
ORDER BY city,first_name;

--Q3>

SELECT TOP 3 product_name,list_price FROM production.products
ORDER BY list_price DESC;

--Q4>

SELECT product_name,list_price,model_year FROM production.products
WHERE list_price>300 AND model_year =2018;

--Q5>

SELECT product_name,list_price,model_year FROM production.products
WHERE list_price>3000 OR model_year =2018;


--Q6>

SELECT product_name,list_price,model_year FROM production.products
WHERE list_price BETWEEN 1899 AND 1999.99;

--Q7>

SELECT product_name,list_price,model_year FROM production.products
WHERE list_price IN(299.99,466.99,489.99);

--Q8>

SELECT first_name,last_name FROM SALES.customers
WHERE last_name LIKE '[abc]%';

--Q9>

SELECT first_name,last_name FROM SALES.customers
WHERE first_name not LIKE 'a%';

--Q10>

SELECT state,COUNT(customer_id) AS 'NO_OF_CUSTOMER' FROM SALES.customers
GROUP BY city,state;


--Q11>

SELECT customer_id,COUNT(ORDER_ID) AS 'NO_OF_ORDER' FROM SALES.orders
GROUP BY customer_id ,YEAR(order_date); 

--Q12>

SELECT category_id,MAX(list_price) AS 'MAX_LIST_PRICE',MIN(list_price) AS 'MIN_LIST_PRICE' FROM production.products
GROUP BY category_id 
HAVING MAX(list_price) > 4000 OR MIN(list_price) < 500;



