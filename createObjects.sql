-- Admins Table 
-- Attributes:
-- admin_id
-- email
-- password

CREATE TABLE admins
    (admin_id varchar2(20) constraint pk_admin_id primary key, 
    email varchar2(50) unique , 
    password varchar2(50) not null          
);

-- Create sequence for admin_id auto increment
CREATE SEQUENCE admin_id_seq;

CREATE OR REPLACE TRIGGER adm_tgr
    BEFORE INSERT ON admins
    FOR EACH ROW
BEGIN
-- If admin_id is null, create pattern for id AXXXXXXX
    IF :NEW.admin_id IS NULL THEN
        SELECT 'A'||TO_CHAR(admin_id_seq.NEXTVAL,'0000000') 
        INTO :NEW.admin_id FROM DUAL;
    END IF;
END;

-- Customers Table
-- Attributes:
-- customer_id
-- username
-- first_name
-- last_name
-- email
-- password
-- date_of_reg
-- address
-- contact_no

CREATE TABLE customers
    (customer_id varchar2(20) constraint pk_customer_id primary key , 
    username varchar2(50),
    first_name varchar2(50),
    last_name varchar2(50),
    email varchar(50) unique, 
    password varchar2(50) not null, 
    date_of_reg date default sysdate,  
    address varchar2(50),
    contact_no varchar2(20)
);

-- Create sequence for customer_id auto increment
CREATE SEQUENCE customers_id_seq;

CREATE OR REPLACE TRIGGER cust_tgr
    BEFORE INSERT
    ON customers
    FOR EACH ROW
BEGIN
-- If customer_id is null, create pattern for id CXXXXXXX
    IF :NEW.customer_id IS NULL THEN
        SELECT 'C'||TO_CHAR(customers_id_seq.NEXTVAL,'0000000') 
        INTO :NEW.customer_id FROM DUAL;
    END IF;
END;

-- Categories Table
-- Attributes:
-- cat_id
-- cat_name

CREATE TABLE categories
    (cat_id varchar2(20) constraint pk_cat_id primary key, 
    cat_name varchar2(50));

-- Create sequence for cat_id auto increment
CREATE SEQUENCE cat_id_seq;

CREATE OR REPLACE TRIGGER cat_tgr
    BEFORE INSERT
    ON categories
    FOR EACH ROW
BEGIN
-- If cat_id is null, create pattern for id CATXXXXXXX
    IF :NEW.cat_id IS NULL THEN
        SELECT 'CAT'||TO_CHAR(cat_id_seq.NEXTVAL,'0000000') 
        INTO :NEW.cat_id FROM DUAL;
    END IF;
END;

-- Products Table
-- Attributes:
-- product_id
-- product_name
-- category_id
-- product_price
-- image
-- available_qty

CREATE TABLE products
    (product_id varchar2(20) constraint pk_product_id primary key, 
    product_name varchar2(50), 
    cat_id varchar(20) not null, 
    product_price number(12,2), 
    image varchar2(20), 
    available_qty varchar2(50),
    constraint fk_category foreign key (cat_id) references categories(cat_id)
);

-- Create sequence for product_id auto increment
CREATE SEQUENCE product_id_seq;

CREATE OR REPLACE TRIGGER prod_tgr
    BEFORE INSERT
    ON products
    FOR EACH ROW
BEGIN
-- If product_id is null, create pattern for id PXXXXXXX
    IF :NEW.product_id IS NULL THEN
        SELECT 'P'||TO_CHAR(product_id_seq.NEXTVAL,'0000000') 
        INTO :NEW.product_id FROM DUAL;
    END IF;
END;

-- Coupons Table
-- Attributes:
-- coupon_id
-- coupon_name
-- discount_val
-- start_date
-- end_date

CREATE TABLE coupons
    (coupon_id varchar2(20) constraint pk_coupon_id primary key, 
    coupon_name varchar2(50), 
    discount_val number(20),
    start_date date,
    end_date date
);

-- Create sequence for coupon_id auto increment
CREATE SEQUENCE coupon_id_seq;

CREATE OR REPLACE TRIGGER coup_tgr
    BEFORE INSERT
    ON coupons
    FOR EACH ROW
BEGIN
-- If coupon_id is null, create pattern for id COXXXXXXX
    IF :NEW.coupon_id IS NULL THEN
        SELECT 'CO'||TO_CHAR(coupon_id_seq.NEXTVAL,'0000000') 
        INTO :NEW.coupon_id FROM DUAL;
    END IF;
END;

-- Carts Table
-- Attributes:
-- cart_id
-- customer_id

CREATE TABLE carts
    (cart_id varchar2(20) constraint pk_cart_id primary key, 
    customer_id varchar2(20) not null,
    constraint fk_cust_id_cart foreign key (customer_id) references customers(customer_id)
);

-- Create sequence for cart_id auto increment
CREATE SEQUENCE cart_id_seq;

CREATE OR REPLACE TRIGGER cart_tgr
    BEFORE INSERT
    ON carts
    FOR EACH ROW
BEGIN
-- If cart_id is null, create pattern for id CAXXXXXXX
    IF :NEW.cart_id IS NULL THEN
        SELECT 'CA'||TO_CHAR(cart_id_seq.NEXTVAL,'0000000') 
        INTO :NEW.cart_id FROM DUAL;
    END IF;
END;

-- Cart Items Table
-- Attributes:
-- cart_item_id
-- cart_id
-- customer_id
-- product_id
-- product_qty

CREATE TABLE cart_items
    (cart_item_id varchar2(20) constraint pk_cart_item_id primary key,
    cart_id varchar2(20) not null, 
    customer_id varchar2(20) not null,
    product_id varchar2(20) not null, 
    product_qty number(20),
    constraint fk_cart_to_cart_items foreign key (cart_id) references carts(cart_id), 
    constraint fk_cust_to_cart_items foreign key (customer_id) references customers(customer_id), 
    constraint fk_prod_to_cart_items foreign key (product_id) references products(product_id)
);

-- Create sequence for cart_item_id auto increment
CREATE SEQUENCE cart_item_id_seq;

CREATE OR REPLACE TRIGGER cart_items_tgr
    BEFORE INSERT
    ON cart_items
    FOR EACH ROW
BEGIN
-- If cart_item_id is null, create pattern for id CIXXXXXXX
    IF :NEW.cart_item_id IS NULL THEN
        SELECT 'CI'||TO_CHAR(cart_item_id_seq.NEXTVAL,'0000000') 
        INTO :NEW.cart_item_id FROM DUAL;
    END IF;
END;

-- Orders Table
-- Attributes:
-- order_id
-- cart_id
-- user_id
-- order_date
-- dely_date
-- coupon_id
-- bill_amt
-- payment_method

CREATE TABLE orders
    (order_id varchar2(20) constraint pk_order_id primary key,
    cart_id varchar2(20) not null, 
    customer_id varchar2(20) not null, 
    order_date date DEFAULT sysdate,
    dely_date date default sysdate + 7, 
    coupon_id varchar2(20) not null, 
    bill_amt number(12,2), 
    payment_method varchar2(2),
    constraint fk_cart_to_order foreign key (cart_id) references carts(cart_id), 
    constraint fk_cust_to_order foreign key (customer_id) references customers(customer_id), 
    constraint fk_coupon_order foreign key (coupon_id) references coupons(coupon_id), 
    constraint ck_pay_meth check(payment_method in ('COD', 'CREDIT', 'DEBIT', 'E-WALLET'))
);

-- Create sequence for order_id auto increment
CREATE SEQUENCE order_id_seq;

CREATE OR REPLACE TRIGGER order_tgr
    BEFORE INSERT
    ON orders
    FOR EACH ROW
BEGIN
-- If order_id is null, create pattern for id OXXXXXXX
    IF :NEW.order_id IS NULL THEN
        SELECT 'O'||TO_CHAR(order_id_seq.NEXTVAL,'0000000') 
        INTO :NEW.order_id FROM DUAL;
    END IF;
END;

