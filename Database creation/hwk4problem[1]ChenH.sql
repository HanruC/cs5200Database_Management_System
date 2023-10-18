CREATE DATABASE groceryStore;
USE groceryStore;

CREATE TABLE chain (
	chain_id INT PRIMARY KEY NOT NULL,
    street_number VARCHAR(10),
    street_name VARCHAR(64),
    zip_code VARCHAR(10),
    state VARCHAR(2),
    open_time TIME,
    close_time TIME);

CREATE TABLE staff (
	staff_no INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(64),
    last_name VARCHAR(64),
    chain_id INT,
    is_manager BOOLEAN DEFAULT FALSE,
    manager_start_date DATE,
    CONSTRAINT chain_id_fk FOREIGN KEY (chain_id) 
		REFERENCES chain(chain_id) ON DELETE RESTRICT ON UPDATE RESTRICT);

CREATE TABLE product_genres (
	genre_name VARCHAR(64),
    genre_id INT PRIMARY KEY);
    
CREATE TABLE product_type (
	type_id INT PRIMARY KEY NOT NULL,
    type_name VARCHAR(64),
    genre_id INT,
    CONSTRAINT genre_id_fk FOREIGN KEY (genre_id) 
		REFERENCES product_genres(genre_id) ON DELETE RESTRICT ON UPDATE RESTRICT);
        
CREATE TABLE inventory (
	chain_id INT,
    type_id INT,
    quantity_per_type INT,
    CONSTRAINT inventory_chain_id_fk FOREIGN KEY (chain_id) 
		REFERENCES chain(chain_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT inventory_type_id_fk FOREIGN KEY (type_id) 
		REFERENCES product_type(type_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    PRIMARY KEY(chain_id, type_id));

CREATE TABLE customer (
	first_name VARCHAR(64),
    last_name VARCHAR(64),
    local_address VARCHAR(64),
    customer_id INT PRIMARY KEY NOT NULL);
    
CREATE TABLE credit_card_info (
	card_number VARCHAR(19) PRIMARY KEY NOT NULL,
    card_type ENUM('VISA', 'AMEX', 'Mastercard'),
    expiration_date DATE,
    customer_id INT,
    CONSTRAINT cc_customer_id_fk FOREIGN KEY (customer_id) 
		REFERENCES customer(customer_id) ON DELETE RESTRICT ON UPDATE RESTRICT );
        
CREATE TABLE orders (
	order_id INT PRIMARY KEY NOT NULL,
    identification_type ENUM('credit card', 'driving license', 'passport'),
    identification_number VARCHAR(64),
    chain_id INT,
    customer_id INT,
    CONSTRAINT order_chain_id_fk FOREIGN KEY (chain_id) 
		REFERENCES chain(chain_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT order_customer_id_fk FOREIGN KEY (customer_id) 
		REFERENCES customer(customer_id) ON DELETE RESTRICT ON UPDATE RESTRICT);
    
CREATE TABLE orderDetail (
	quantity INT,
    orderDetail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    type_id INT,
    CONSTRAINT detail_order_id_fk FOREIGN KEY (order_id) 
		REFERENCES orders(order_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT detail_type_id_fk FOREIGN KEY (type_id) 
		REFERENCES product_type(type_id) ON DELETE RESTRICT ON UPDATE RESTRICT);
    

    
