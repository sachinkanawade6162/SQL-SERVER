

--Q1>

CREATE VIEW SALE_INFO
AS
SELECT P.product_id,P.product_name,P.model_year,OI.quantity,OI.list_price,OI.discount,
O.order_status,O.required_date,O.shipped_date,O.store_id FROM production.products P INNER JOIN sales.order_items OI 
ON P.product_id=OI.product_id
INNER JOIN sales.orders O
ON OI.order_id=O.order_id;

SELECT * FROM SALE_INFO;

--Q2>

CREATE VIEW STAFF_SALES
AS
SELECT S.first_name,S.last_name,SUM(OI.quantity*OI.list_price) AS 'TOTAL SALES'
FROM sales.order_items OI 
INNER JOIN sales.orders O
ON OI.order_id=O.order_id 
INNER JOIN sales.staffs S
ON O.staff_id=S.staff_id
GROUP BY S.first_name,S.last_name;

SELECT * FROM STAFF_SALES;

--Q3>
CREATE PROCEDURE SALES.USP_ADD_STORE
@STORE_NAME VARCHAR(255),
@STORE_COUNT INT OUTPUT
AS
BEGIN
   INSERT INTO SALES.stores (store_name) VALUES (@STORE_NAME)
   SELECT @STORE_COUNT=COUNT(store_name) FROM SALES.stores
END;

DECLARE @COUNT INT;
EXEC SALES.USP_ADD_STORE
@STORE_NAME='Rowlett Bikes',
@STORE_COUNT=@COUNT OUTPUT

SELECT @COUNT AS 'SOTRE COUNT'

--Q4>

CREATE PROCEDURE SALES.USP_STORE_WISE_SALES
AS
BEGIN
SELECT  SS.store_id,SS.store_name,SS.city,COUNT(order_id) AS 'ORDER COUNT'  
FROM SALES.stores SS INNER JOIN SALES.orders SO ON SS.store_id=SO.store_id
GROUP BY SS.store_id,SS.store_name,SS.CITY
END
EXEC SALES.USP_STORE_WISE_SALES

--Q5>

ALTER FUNCTION SALES.UDF_AVG (
@CUSTOMER_ID INT,
@YEAR  INT 
)
RETURNS INT
AS 
BEGIN
DECLARE @SUM INT 
  SELECT @SUM =SUM(QUANTITY*LIST_PRICE) FROM SALES.order_items WHERE order_id IN
  (SELECT order_id FROM SALES.orders WHERE customer_id=@CUSTOMER_ID AND YEAR(order_date)=@YEAR)
  RETURN @SUM 
END

(SELECT SALES.UDF_AVG(20,2018) AS ORDER_SUM)