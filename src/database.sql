CREATE DATABASE Shopapp;
Use Shopapp;

-- user table for customer creating account
CREATE TABLE accounts(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(10) NOT NULL,
    address VARCHAR(200) DEFAULT '',
    password VARCHAR(100) NOT NULL DEFAULT '', -- encrypted password
    created_at DATETIME,
    updated_at DATETIME,
    is_active TINYINT(1) DEFAULT 1, -- boolean (1 character value, e.g 0-9) track 0/1 tracking active state
    dob DATE, -- date of birth if provided
    facebook_account_id INT DEFAULT 0, -- facebook account if associated
    google_account_id INT DEFAULT 0  -- google account if associated
);

-- table for role 
CREATE TABLE roles(
    id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);
-- add role_id to accounts table assigning the role
ALTER TABLE accounts ADD COLUMN role_id INT;
ALTER TABLE accounts ADD FOREIGN KEY (role_id) REFERENCES roles(id)

-- token table
CREATE TABLE tokens(
    id INT PRIMARY KEY AUTO_INCREMENT,
    token VARCHAR(255) UNIQUE NOT NULL,
    token_type VARCHAR(50) NOT NULL,
    expiration_date DATETIME,
    revoked TINYINT(1) NOT NULL,
    expired TINYINT(1) NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES accounts(id)
);

-- support social network connection (e.g. Facebook and Google)
CREATE TABLE social_accounts(
    id INT PRIMARY KEY AUTO_INCREMENT,
    provider VARCHAR(20) NOT NULL COMMENT 'Your social network platform',
    provider_id VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL COMMENT 'Your email account',
    name VARCHAR(100) NOT NULL COMMENT 'Your username',
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES accounts(id)
);

-- table for item categories
CREATE TABLE categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'category name'
);

-- table for items contained
CREATE TABLE products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(350) COMMENT 'item name',
    price FLOAT NOT NULL CHECK (price >= 0),
    thumbnail VARCHAR(300) DEFAULT '',
    description LONGTEXT DEFAULT '',
    created_at DATETIME,
    updated_at DATETIME,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- table for products' image arrangement
CREATE TABLE product_images(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products (id),
    CONSTRAINT fk_product_images_product_id 
        FOREIGN KEY (product_id) 
        REFERENCES products (id) ON DELETE CASCADE,
    image_url VARCHAR(300)
);

-- table for orders
CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES accounts(id),
    fullname VARCHAR(100) DEFAULT '',
    email VARCHAR(100) DEFAULT '',    
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    note VARCHAR(100) DEFAULT '',    
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    total_price FLOAT CHECK(total_price >= 0)
);
-- add fields
ALTER TABLE orders ADD COLUMN `shipping_method` VARCHAR(100);
ALTER TABLE orders ADD COLUMN `shipping_address` VARCHAR(200);
ALTER TABLE orders ADD COLUMN `shipping_date` DATE;
ALTER TABLE orders ADD COLUMN `tracking_number` VARCHAR(100);
ALTER TABLE orders ADD COLUMN `payment_method` VARCHAR(100);
-- soft delete activation on a order item
ALTER TABLE orders ADD COLUMN active TINYINT(1);
-- possible enum states of an order
ALTER TABLE orders MODIFY COLUMN status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') COMMENT 'order status';

-- order's details table
CREATE TABLE order_details(
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES orders (id),
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products (id),
    price FLOAT CHECK(price >= 0),
    number_of_products INT CHECK(number_of_products > 0),
    total_price FLOAT CHECK(total_price >= 0),
    color VARCHAR(20) DEFAULT ''
);

