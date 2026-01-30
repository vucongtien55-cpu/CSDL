CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    reward_points INT
);

select * from customer;

insert into customer (name, email, reward_points)  values
('Nguyễn Văn A', 'a@gmail.com', 120),
('Trần Thị B', 'b@gmail.com', 300),
('Lê Văn C', 'c@gmail.com', 250),
('Phạm Thị D', NULL, 180),      -- không có email
('Hoàng Văn E', 'e@gmail.com', 400),
('Vũ Thị F', 'f@gmail.com', 90),
('Đặng Văn G', 'g@gmail.com', 220);

select distinct name
from customer;

-- tìm khách hàng chưa có email
select * from customer
where email is null;

--Hiển thị 3 khách hàng có điểm thưởng cao nhất, bỏ qua khách hàng cao điểm nhất (gợi ý: dùng OFFSET)
select name , reward_points
from customer
order by reward_points DESC
offset 1
limit 3;

--Sắp xếp danh sách khách hàng theo tên giảm dần
select * from customer
order by name DESC;