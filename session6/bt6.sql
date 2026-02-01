create table orders(
	id serial primary key,
	customer_id int,
	order_date date,
	total_amount numeric(10,2)
);

insert into Orders (customer_id, order_date, total_amount) values
(1, '2023-01-10', 12000000),
(2, '2023-03-15', 18000000),
(3, '2023-07-20', 25000000),
(1, '2024-02-05', 15000000),
(2, '2024-04-18', 22000000),
(3, '2024-10-10', 30000000),
(4, '2024-10-25', 8000000),
(1, '2025-01-12', 40000000),
(2, '2025-03-30', 20000000),
(3, '2025-05-05', 10000000);


-- Hiển thị tổng doanh thu, số đơn hàng, giá trị trung bình mỗi đơn (dùng SUM, COUNT, AVG) 
-- Đặt bí danh cột lần lượt là total_revenue, total_orders, average_order_value
select 
	sum(total_amount) as total_revenue,
	count(*) as total_orders,
	avg(total_amount) as average_order_value
from orders;

--Nhóm dữ liệu theo năm đặt hàng, hiển thị doanh thu từng năm (GROUP BY EXTRACT(YEAR FROM order_date))
select 
	extract(year from order_date) as order_year,
	sum(total_amount) as yearly_revenue
from orders
group by extract(year from order_date)
order by order_year;

--Chỉ hiển thị các năm có doanh thu trên 50 triệu (HAVING)
select 
	extract(year from order_date) as order_year,
	sum(total_amount) as yearly_revenue
from orders
group by extract(year from order_date)
having sum(total_amount) > 50000000;

--Hiển thị 5 đơn hàng có giá trị cao nhất (dùng ORDER BY + LIMIT)
select *
from orders
order by total_amount DESC
limit 5;

































