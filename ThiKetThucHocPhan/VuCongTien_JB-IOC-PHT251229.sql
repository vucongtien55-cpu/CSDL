create table customer(
	customer_id varchar(5) primary key,
	customer_full_name varchar(100) not null,
	customer_email varchar(100) not null unique,
	customer_phone varchar(15) not null,
	customer_address varchar(255) not null
);

create table room(
	room_id varchar(5) primary key,
	room_type varchar(50) not null,
	room_price decimal(10,2) not null,
	room_status varchar(20) not null,
	room_area int not null
);

create table booking(
	booking_id serial primary key,
	customer_id varchar(5) not null,
	room_id varchar(5) not null,
	check_in_date date not null,
	check_out_date date not null,
	total_amount decimal(10,2),

	constraint fk_booking_customer
		foreign key(customer_id) references customer(customer_id),
	constraint fk_booking_room 
		foreign key (room_id) references room(room_id)
);

create table payment(
	payment_id serial primary key,
	booking_id int not null,
	payment_method varchar(50) not null,
	payment_date date not null,
	payment_amount decimal(10,2) not null,

	constraint fk_payment_booking
		foreign key(booking_id) references booking(booking_id)
);

--chèn dữ liệu customer
insert into customer values
('C001', 'Nguyen Anh Tu', 'tu.nguyen@example.com', '0912345678', 'Hanoi,VietNam'),
('C002', 'Tran Thi Mai', 'mai.tran@example.com', '0923456789', 'Ho Chi Minh,VietNam'),
('C003', 'Le Minh Hoang', 'hoang.le@example.com', '0934567890', 'Da Nang,VietNam'),
('C004', 'Pham Hoang Nam', 'nam.pham@example.com', '0945678901', 'Hue,VietNam'),
('C005', 'Vu Minh Thu', 'thu.vu@example.com', '0956789012', 'Hai Phong,VietNam');

-- chèn dữ liệu room
insert into room values
('R001', 'Single', 100, 'Available', 25),
('R002', 'Double', 150, 'Booked', 40),
('R003', 'Suite', 250, 'Available', 60),
('R004', 'Single', 120, 'Booked', 30),
('R005', 'Double', 160, 'Available', 35);

-- chèn dữ liệu booking
insert into booking( customer_id, room_id, check_in_date, check_out_date, total_amount) values
('C001', 'R001', '2025-03-01','2025-03-05', 400),
('C002', 'R002', '2025-03-02','2025-03-06', 600),
('C003', 'R003', '2025-03-03','2025-03-07', 1000),
('C004', 'R004', '2025-03-04','2025-03-08', 480),
('C005', 'R005', '2025-03-05','2025-03-09', 800);

--chèn dữ liệu payment
insert into payment(booking_id, payment_method, payment_date, payment_amount) values
(1, 'Cash', '2025-03-05', 400),
(2, 'Creadit Cash', '2025-03-06', 600),
(3, 'Bank Transfer', '2025-03-07', 1000),
(4, 'Cash', '2025-03-08', 480),
(5, 'Creadit Cash', '2025-03-09', 800);

--update 
update booking b set total_amount = r.room_price *( b.check_out_date - b.check_in_date)
from room r
where b.room_id = r.room_id and r.room_status = 'Booked' and b.check_in_date < CURRENT_DATE;

delete from payment
where payment_method = 'Cash' and payment_amount < 500;

-- Cau5
select customer_id, customer_full_name, customer_email, customer_phone, customer_address
from customer
order by customer_full_name ASC;

--Cau6
select room_id, room_type, room_price, room_area
from room
order by room_price DESC;

--Cau7
select c.customer_id, c.customer_full_name, r.room_id, b.check_in_date, b.check_out_date
from booking b join customer c on b.customer_id = c.customer_id
join room r on b.room_id = r.room_id;


--Cau8
select c.customer_id, c.customer_full_name, p.payment_method, p.payment_amount
from payment p join booking b on p.booking_id = b.booking_id
join customer c on b.customer_id = c.customer_id
order by p.payment_amount DESC;

--Cau9
select * from customer 
order by customer_full_name
offset 1 limit 3;


--Cau10
select c.customer_id, c.customer_full_name, count(b.booking_id) as total_rooms
from customer c join booking b on c.customer_id = b.customer_id
join payment p on b.booking_id = p.booking_id
group by c.customer_id, c.customer_full_name
having count(b.booking_id) >= 2 and sum(p.payment_amount) > 1000;

--Cau11
select r.room_id, r.room_type, r.room_price,
	sum(p.payment_amount) as total_payment
from room r join booking b on r.room_id = b.room_id 
join payment p on b.booking_id = p.booking_id
group by r.room_id , r.room_type, r.room_price
having sum(p.payment_amount) < 1000 and count(distinct b.customer_id) >= 3;

--Cau12
select c.customer_id, c.customer_full_name, r.room_id, 
	sum(p.payment_amount) as total_payment
from customer c join booking b on c.customer_id = b.customer_id
join room r on b.room_id = r.room_id
join payment p on b.booking_id = p.booking_id
group by c.customer_id, c.customer_full_name, r.room_id
having sum(p.payment_amount) > 1000;

--Cau13
select customer_id, customer_full_name, customer_email, customer_phone
from customer
where customer_full_name ilike '%Minh%'
or customer_address ilike '%Hanoi%'
order by customer_full_name ASC;

-- Cau14
select room_id, room_type, room_price
from room
order by room_price DESC
offset 5 limit 5;

--PHẦN 6 
--Cau15 
create view view_booking_before_20250310 as 
select r.room_id, room_type, c.customer_id, c.customer_full_name
from booking b join customer c on b.customer_id = c.customer_id
join room r on b.room_id = r.room_id
where b.check_in_date < '2025-03-10';

--Cau16
create view view_booking_large_room as 
select c.customer_id, c.customer_full_name, r.room_id, r.roomarea
from booking b join customer c on b.customer_id = c.customer_id
join room r on b.room_id = r.room_id
where r.room_area >30;

--PHAN7
--CAu17
create or replace function check_insert_booking()
returns trigger as $$
begin
	if ner.check_in_date > ner.check_out_date then 
		raise exception 'Ngày đặt phòng không thể sau ngày trả phòng được đâu';
	end if;
	return new;
end;
$$ language plpgsql;

create trigger trg_check_booking
before insert on booking
for each row
execute function check_insert_booking();


--Cau18
create or replace function update_room_status()
returns trigger as $$
begin 
	update room
	set room_status = 'Booked'
	where room_id = new.room_id;
	return new;
end;
$$ language plpgsql;
create trigger trg_update_room_status
after insert on booking
for each row
execute function update_room_status();

--Phan8
--Cau19
create or replace procedure add_customer(
	p_id varchar,
	p_name varchar,
	p_email varchar,
	p_phone varchar,
	p_address varchar
)
language plpgsql
as $$
begin 
	insert into customer 
	values(p_id, p_name, p_email, p_phone, p_address);
end;
$$;

--Cau20
create or replace procedure add_payment(
	p_booking_id int,
	p_payment_method varchar,
	p_payment_amount decimal,
	p_payment_date date
)
language plpgsql
as $$
begin 
	insert into payment(booking_id, payment_method, payment_amount, payment_date) 
	values(p/booking_id, p_payment_method, p_payment_amount, p_payment_date);
end;
$$;

select * from customer;
select * from room;
select * from booking;
select * from payment;



























































































