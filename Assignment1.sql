CREATE DATABASE VEHICALMODEL;

USE VEHICALMODEL;

CREATE SCHEMA ScSALE;

CREATE TABLE ScSALE.CUSTOMERS(
customer_id	INT PRIMARY KEY,
first_name	VARCHAR(20),
last_name	VARCHAR(20),
phone		VARCHAR(10),
email		VARCHAR(30) UNIQUE,
street		VARCHAR(30),
city		VARCHAR(20),
state		VARCHAR(20),
zip_code	VARCHAR(20)
); 

CREATE TABLE ScSALE.STORES(
store_id	INT PRIMARY KEY,
store_name	VARCHAR(30),
phone		VARCHAR(10),
email		VARCHAR(20),
street		VARCHAR(20),
city		VARCHAR(20),
state		VARCHAR(20),
zip_code	varchar(20)
);

CREATE TABLE ScSALE.STAFFS(
staff_id	INT PRIMARY KEY,
first_name	VARCHAR(30),
last_name	VARCHAR(30),
email		VARCHAR(30) UNIQUE,
phone		VARCHAR(10)	UNIQUE,
active		VARCHAR(30),
store_id	INT,
manager_id	INT,
CONSTRAINT fk_strore_id FOREIGN KEY(store_id) REFERENCES ScSALE.STORES(store_id)
);

CREATE TABLE ScSALE.ORDERS(
order_id	INT PRIMARY KEY,
customer_id	INT,
order_status VARCHAR(30),
order_date	 DATE,
required_date DATE,
shipped_date  DATE,
store_id	INT,
staff_id	INT,
CONSTRAINT fk_cust_id FOREIGN KEY(customer_id) REFERENCES ScSALE.CUSTOMERS(customer_id),
CONSTRAINT fk_store_id FOREIGN KEY(store_id) REFERENCES ScSALE.STORES(store_id),
CONSTRAINT fk_staff_id FOREIGN KEY(staff_id) REFERENCES ScSALE.STAFFS(staff_id),
);


CREATE TABLE ScSALE.ORDER_ITEMS(
order_id	INT,
item_id		INT PRIMARY KEY,
product_id	INT NOT NULL,
quantity	INT CHECK (quantity > 0),
list_price	INT CHECK (list_price > 0),
discount	INT,
CONSTRAINT fk_order_id FOREIGN KEY(order_id) REFERENCES ScSALE.ORDERS(order_id),
CONSTRAINT fk_product_id FOREIGN KEY(product_id) REFERENCES ScPRODUCTON.PRODUCTION(production_id)
);


CREATE SCHEMA ScPRODUCTON;

CREATE TABLE ScPRODUCTON.BRANDS(
brand_id	INT PRIMARY KEY,
brand_name	VARCHAR(30)
);

CREATE TABLE ScPRODUCTON.CATEGORIES(
categories_id	INT PRIMARY KEY,
categories_name	VARCHAR(30)
);

CREATE TABLE ScPRODUCTON.PRODUCTION(
production_id	INT PRIMARY KEY,
production_name	VARCHAR(30),
brand_id		INT,
categories_id	INT,
model_year		INT,
list_price		INT,
CONSTRAINT fk_brand_id FOREIGN KEY(brand_id) REFERENCES ScPRODUCTON.BRANDS(brand_id),
CONSTRAINT fk_categories_id FOREIGN KEY(categories_id) REFERENCES ScPRODUCTON.CATEGORIES(categories_id)
);

CREATE TABLE ScPRODUCTON.STOCKS(
stored_id INT,
production_id	INT,
quantity	INT,
CONSTRAINT fk_stored_id FOREIGN KEY(stored_id) REFERENCES ScSALE.STORES(store_id),
CONSTRAINT fk_product_id FOREIGN KEY(production_id) REFERENCES ScPRODUCTON.PRODUCTION(production_id)
);