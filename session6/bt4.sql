CREATE TABLE orderinfo (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total NUMERIC(10,2),
    status VARCHAR(20)
);

select * from orderinfo;
INSERT INTO orderinfo (customer_id, order_date, total, status) VALUES
(1, '2024-10-05', 300000, 'Completed'),
(2, '2024-10-10', 750000, 'Pending'),
(3, '2024-09-28', 1200000, 'Completed'),
(4, '2024-10-20', 550000, 'Cancelled'),
(5, '2024-11-02', 900000, 'Processing');

--Truy vấn các đơn hàng có tổng tiền lớn hơn 500,000
select * from orderinfo
where total > 500000;

-- Truy vấn các đơn hàng có ngày đặt trong tháng 10 năm 2024
select * from orderinfo
where order_date between '2024-10-01' and '2024-10-30';

--Liệt kê các đơn hàng có trạng thái khác “Completed”
select * from orderinfo
where status <> 'completed';

--Lấy 2 đơn hàng mới nhất
select * from orderinfo
order by order_date DESC
limit 2;

