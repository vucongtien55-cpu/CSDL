create table course(
	id serial primary key,
	title varchar(100),
	instructor varchar(50),
	price numeric(10,2),
	duration int
);
--Thêm ít nhất 6 khóa học vào bảng
insert into course (title, instructor, price, duration) values
('SQL Cơ Bản', 'Nguyễn Văn A', 800000, 25),
('SQL Nâng Cao', 'Trần Thị B', 1500000, 40),
('Demo PostgreSQL Thực Chiến', 'Lê Văn C', 2000000, 50),
('Lập trình Python', 'Phạm Thị D', 1200000, 35),
('Lập trinh java', 'Nguyễn Văn E', 500000, 10),
('java spring boot', 'Trần Văn F', 1800000, 45);

select * from course;

--Cập nhật giá tăng 15% cho các khóa học có thời lượng trên 30 giờ
update course set duration = duration * 1.15 
where duration > 30;

--Xóa khóa học có tên chứa từ khóa “Demo”
delete from course
where title like '%Demo%';

--Hiển thị các khóa học có tên chứa từ “SQL” (không phân biệt hoa thường)
select * from course 
where title ilike 'SQL%';

--Lấy 3 khóa học có giá nằm giữa 500,000 và 2,000,000, sắp xếp theo giá giảm dần
select * from course
where price between 500000 and 2000000
order by price DESC 
limit 3;