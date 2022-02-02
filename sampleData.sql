-- INSERT INTO ADMINS

INSERT INTO admins(email, password)  VALUES('barbara@gmail.com', '1234567');
INSERT INTO admins(email, password)  VALUES('chhaya@gmail.com', '2345678');
INSERT INTO admins(email, password)  VALUES('mahesh@gmail.com', '3456789');

-- INSERT INTO CUSTOMERS

INSERT INTO customers(username, first_name, last_name, email, password, address, contact_no)
VALUES('jenninaperez', 'Jennina', 'Perez', 'jenninaperez@gmail.com', '1234567', 'Mandaluyong City', '09770723941');
INSERT INTO customers(username, first_name, last_name, email, password, address, contact_no)
VALUES('jakeperalta', 'Jake', 'Peralta', 'jakeperalta@gmail.com', '2345678', 'Brooklyn, New York', '09770723941');
INSERT INTO customers(username, first_name, last_name, email, password, address, contact_no)
VALUES('amysantiago', 'Amy', 'Santiago', 'amysantiago@gmail.com', '3456789', 'Brooklyn, New York', '09770723941');

-- INSERT INTO CATEGORIES
INSERT INTO categories(cat_name) VALUES('Electronics');
INSERT INTO categories(cat_name) VALUES('Shoes');
INSERT INTO categories(cat_name) VALUES('Dresses');

-- INSERT INTO PRODUCTS
INSERT INTO products(product_name, cat_id, product_price, image, available_qty) 
VALUES('Laptop', 'CAT 0000001', 19999.99, 'laptop.jpg', '5');
INSERT INTO products(product_name, cat_id, product_price, image, available_qty) 
VALUES('Nike Air Force 1 SE', 'CAT 0000002', 6195.25, 'af1.jpg', '10');
INSERT INTO products(product_name, cat_id, product_price, image, available_qty) 
VALUES('Scallop Trim Fit Flare Dress', 'CAT 0000003', 794.99, 'scallop_dress.jpg', '2');

-- INSERT INTO COUPONS
INSERT INTO coupons(coupon_name, discount_val, start_date, end_date) 
VALUES('Valentines Day Sale', 10, '01-FEB-22', '15-FEB-22');
INSERT INTO coupons(coupon_name, discount_val, start_date, end_date) 
VALUES('Christmas Sale', 15, '01-DEC-22', '27-DEC-22');

-- INSERT INTO CARTS
INSERT INTO carts(customer_id) 
VALUES('C 0000001');
INSERT INTO carts(customer_id) 
VALUES('C 0000002');
INSERT INTO carts(customer_id) 
VALUES('C 0000003');

-- INSERT INTO CART ITEMS
INSERT INTO cart_items(cart_id, customer_id, product_id, product_qty) 
VALUES('CA 0000001', 'C 0000001', 'P 0000001', 1);
INSERT INTO cart_items(cart_id, customer_id, product_id, product_qty) 
VALUES('CA 0000001', 'C 0000001', 'P 0000002', 1);
INSERT INTO cart_items(cart_id, customer_id, product_id, product_qty) 
VALUES('CA 0000001', 'C 0000001', 'P 0000003', 1);

-- INSERT INTO ORDERS
INSERT INTO orders(cart_id, customer_id, coupon_id, bill_amt, payment_method)
VALUES('CA 0000001', 'C 0000001', 'CO 0000001', 26990.23, 'CREDIT');
