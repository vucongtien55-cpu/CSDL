create table product(
	id serial primary key,
	name varchar(100) not null unique,
	category varchar(50),
	price numeric(10,2),
	stock int
);

insert into product (id, name, category, price, stock) values
(1, 'Laptop Dell', 'Điện tử', 20000000, 10),
(2, 'Chuột Logitech', 'Phụ kiện', 500000, 50),
(3, 'Bàn phím cơ', 'Phụ kiện', 1500000, 30),
(4, 'Tai nghe Sony', 'Âm thanh', 2500000, 20),
(5, 'Màn hình LG', 'Điện tử', 4500000, 15);

select * from product;

select * from product
order by price DESC limit 3;

select * from product
where category = 'Điện tử' and price < 10000000;

select * from product
order by stock ASC;

