create table department(
	id serial primary key,
	name varchar(100)
);

create table employee(
	id serial primary key,
	name varchar(100) not null,
	department_id int,
	salary numeric(10,2)
);

insert into Department (name) values
('IT'),
('Kế toán'),
('Nhân sự'),
('Marketing'),
('Bảo vệ');

insert into Employee (name, department_id, salary) values
('Nguyễn Văn A', 1, 15000000),
('Trần Thị B', 1, 18000000),
('Lê Văn C', 2, 9000000),
('Phạm Thị D', 2, 12000000),
('Hoàng Văn E', 3, 8000000),
('Vũ Thị F', 4, 11000000);

--Liệt kê danh sách nhân viên cùng tên phòng ban của họ (INNER JOIN)
select
    e.name,
    d.name AS department_name
from Employee e
join Department d
on e.department_id = d.id;

-- Tính lương trung bình của từng phòng ban, hiển thị:
-- department_name
-- avg_salary
-- Gợi ý: dùng GROUP BY và bí danh cột
select 
	d.name as department_name,
	avg(salary) as avg_salary
from employee e join Department d on e.department_id = d.id
group by d.name;

--Hiển thị các phòng ban có lương trung bình > 10 triệu (HAVING)
select 
	d.name as department_name,
	avg(salary) as avg_salary
from employee e join Department d on e.department_id = d.id
group by d.name
having avg(salary) > 10000000;

--Liệt kê phòng ban không có nhân viên nào (LEFT JOIN + WHERE employee.id IS NULL)
select 
	d.name as department_name
from department d left join employee e on d.id = e.department_id
where e.id is null;


























