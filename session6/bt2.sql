create table employee(
	id serial primary key,
	name varchar(100) not null unique,
	department varchar(50),
	salary numeric(10,2),
	hire_date date
);
select * from employee;
--Thêm 6 nhân viên mới
insert into employee (name, department, salary, hire_date) values
('Nguyễn Văn An', 'IT', 18000000.00, '2021-03-15'),
('Trần Thị Bình', 'HR', 12000000.00, '2020-07-01'),
('Lê Văn Cường', 'IT', 22000000.00, '2019-11-20'),
('Phạm Thị Dung', 'Finance', 15000000.00, '2022-02-10'),
('Hoàng Minh Đức', 'Marketing', 13000000.00, '2021-08-05'),
('Vũ Thị Hạnh', 'HR', 16000000.00, '2023-01-18');

--Cập nhật mức lương tăng 10% cho nhân viên thuộc phòng IT
update employee set salary = salary * 1.10
where department = 'IT';

--Xóa nhân viên có mức lương dưới 6,000,000
delete from employee
where salary < 6000000;

--Liệt kê các nhân viên có tên chứa chữ “An” (không phân biệt hoa thường)
select * from employee
where name ilike '%An%'; 

--Hiển thị các nhân viên có ngày vào làm việc trong khoảng từ '2023-01-01' đến '2023-12-31'
select * from employee
where hire_date between '2023-01-01' and '2023-12-31';


