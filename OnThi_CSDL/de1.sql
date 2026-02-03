create table customer(
	customer_id varchar(5) primary key,
	customer_full_name varchar(100) not null,
	customer_email varchar(100) not null unique,
	customer_phone varchar(15)  not null,
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
	booking_id int primary key,
	customer_id varchar(5) references customer(customer_id),
	room_id varchar(5) references room(room_id),
	check_in_date date,
	check_out_date date,
	total_amount decimal(10,2)
);

CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    booking_id INT,
    payment_method VARCHAR(50),
    payment_date DATE,
    payment_amount DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);


insert into customer(customer_id, customer_full_name, customer_email, customer_phone, customer_address) values
('C001', 'Nguyen Anh Tu', 'tu.nguyen@gmail.com', 0912345678, 'Hanoi'),
('C002', 'Tran Thi Mai', 'mai.tran@gmail.com', 0923456789, 'HoChiMinh'),
('C003', 'Le Minh Hoang',' hoang.le@gmail.com', 0934567890,' Danang'),
('C004', 'Pham Hoang Nam',' nam.pham@gmail.com', 0945678901, 'Hanoi'),
('C005', 'Vu Minh Thu', 'thu.vu@gmail.com', 0956789012,' Hanoi');

insert into room(room_id, room_type, room_price, room_status, room_area) values
('R001', 'Single', 100.0, 'Availble', 25),
('R002', 'Double', 150.0, 'booked', 40),
('R003', 'Suite', 250.0, 'Availble',60),
('R004', 'Single', 120.0, 'booked', 30),
('R005', 'Double', 160.0, 'Availble', 235);

insert into booking(booking_id, customer_id, room_id, check_in_date, check_out_date, total_amount) values
(1, 'C001', 'R001', '2025-03-01', '2025-03-05', 400.0),
(2, 'C002', 'R002', '2025-03-02', '2025-03-06', 600.0),
(3, 'C003', 'R003', '2025-03-03', '2025-03-07', 1000.0),
(4, 'C004', 'R004', '2025-03-04', '2025-03-08', 480.0),
(5, 'C005', 'R005', '2025-03-05', '2025-03-09', 800.0);


insert into payment(payment_id, booking_id, payment_method, payment_date, payment_amount) values 
(1, 1, 'cash',' 2025-03-05', 400.0),
(2, 2, 'credit cart', '2025-03-06', 600.0),
(3, 3, 'banl transfer', '2025-03-07', 1000.0),
(4, 4, 'cash', '2025-03-08', 480.0),
(5, 5, 'credit cart', '2025-03-09', 800.0);

select * from booking;


update booking set total_amount = total_amount * 0.9 
where check_in_date < '2025-03-03';

delete from payment
where payment_method = 'cash' and payment_amount < 500;

--Lấythôngtinkháchhànggồm:mãkháchhàng,họtên,email,sốđiệnthoạiđược sắpxếptheohọtênkháchhànggiảmdần.
select customer_id, customer_full_name, customer_email, customer_phone
from customer
order by customer_full_name DESC;

--Lấythôngtincácphòngkháchsạngồm:mãphòng,loạiphòng,giáphòngvàdiện tíchphòng,sắpxếptheodiệntíchphòngtăngdần.
select * from room
order by room_area ASC;

--Lấythôngtinkháchhàngvàphòngkháchsạnđãđặtgồm:họtênkháchhàng,mã phòng,ngàynhậnphòngvàngàytrảphòng.
select 
	c.customer_full_name, b.booking_id, b.check_in_date, b.check_out_date
from booking b join customer c on b.customer_id = c.customer_id;

--Lấydanhsáchkháchhàngvàtổngtiềnđãthanhtoánkhiđặtphòng,gồmmãkhách hàng,họtênkháchhàng,phươngthứcthanhtoán
--vàsốtiềnthanhtoán,sắpxếptheosốtiền thanhtoántăngdần
SELECT c.customer_id, c.customer_full_name,
       p.payment_method, p.payment_amount
FROM Payment p
JOIN Booking b ON p.booking_id = b.booking_id
JOIN Customer c ON b.customer_id = c.customer_id
ORDER BY p.payment_amount ASC;

--Lấy tất cả thông tin khách hàng từ vị trí thứ 2 đến thứ 4 trong bảng Customerđược sắpxếptheotênkháchhàng(Z-A).
select * from customer 
order by customer_full_name DESC
limit 3 offset 1;

--Lấy danh sách khách hàng đã đặ ít nhất 2 phòng gồm:mã khách hàng,họ tên khách hàng và số lượng phòng đã đặt.
select customer_id, customer_full_name, count(room_id) as So_Phong
from booking  
group by customer_id
having count(room_ID) >= 2;

--Lấydanhsáchcácphòngtừngcóítnhất3kháchhàngđặt,gồmmãphòng,loại phòng,giáphòngvàsốlầnđãđặt.
SELECT room_id, COUNT(customer_id) AS so_lan_dat
FROM Booking
GROUP BY room_id
HAVING COUNT(customer_id) >= 3;

--Lấydanhsáchcáckháchhàngcótổngsốtiềnđãthanhtoánlớnhơn1000,
--gồmmã kháchhàng,họtênkháchhàng,mãphòng,tổngsốtiềnđãthanhtoán.
SELECT c.customer_id, c.customer_full_name, b.room_id,
       SUM(p.payment_amount) AS tong_tien
FROM Payment p
JOIN Booking b ON p.booking_id = b.booking_id
JOIN Customer c ON b.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_full_name, b.room_id
HAVING SUM(p.payment_amount) > 1000;

--Lấydanhsáchcáckháchhànggồm:mãKH,Họtên,email,sđtcóhọtênchứachữ
--"Minh"hoặcđịachỉở"Hanoi".Sắpxếpkếtquảtheohọtêntăngdần.
SELECT customer_id, customer_full_name, customer_email, customer_phone
FROM Customer
WHERE customer_full_name ILIKE '%Minh%'
   OR customer_address ILIKE '%Hanoi%'
ORDER BY customer_full_name ASC;

--Lấydanhsáchthôngtincácphònggồm:mãphòng,loạiphòng,giá,sắpxếptheo giáphònggiảmdần.
--Chỉlấy5phòngvàbỏqua5phòngđầutiên(tứclàlấykếtquảcủatrang thứ2,biếtmỗitrangcó5phòng).
SELECT room_id, room_type, room_price
FROM Room
ORDER BY room_price DESC
LIMIT 5 OFFSET 5;

--Hãytạomộtviewđểlấythôngtincácphòngvàkháchhàngđãđặt,vớiđiềukiện ngàynhậnphòngnhỏhơnngày2025-03-04.
--Cầnhiểnthịcácthôngtinsau:Mãphòng,Loại phòng,Mãkháchhàng,họtênkháchhàng
CREATE VIEW view_booking_before_0304 AS
SELECT r.room_id, r.room_type, c.customer_id, c.customer_full_name
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
JOIN Room r ON b.room_id = r.room_id
WHERE b.check_in_date < '2025-03-04';

--Hãytạomộtviewđểlấythôngtinkháchhàngvàphòngđãđặt,vớiđiềukiệndiện tíchphònglớnhơn30m².
--Cầnhiểnthịcácthôngtinsau:Mãkháchhàng,Họtênkhách hàng,Mãphòng,Diệntíchphòng,Ngàynhậnphòng
CREATE VIEW view_room_area_gt_30 AS
SELECT c.customer_id, c.customer_full_name,
       r.room_id, r.room_area, b.check_in_date
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
JOIN Room r ON b.room_id = r.room_id
WHERE r.room_area > 30;

--Hãytạomộttriggercheck_insert_bookingđểkiểmtradữliệumốikhichènvào bảngBooking.
--Kiểmtranếungàyđặtphòngmàsaungàytrảphòngthìthôngbáolỗivớinội dung“Ngàyđặtphòngkhôngthểsaungàytrảphòngđược!”vàhủythaotácchèndữliệu vàobảng.
CREATE OR REPLACE FUNCTION check_booking_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.check_in_date > NEW.check_out_date THEN
        RAISE EXCEPTION 'Ngày đặt phòng không thể sau ngày trả phòng được !';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_insert_booking
BEFORE INSERT ON Booking
FOR EACH ROW
EXECUTE FUNCTION check_booking_date();

--Hãytạomộttriggercótênlàupdate_room_status_on_bookingđểtựđộngcập nhậttrạngtháiphòngthành"Booked"khimộtphòngđượcđặt
--(khicóbảnghiđượcINSERT vàobảngBooking).
CREATE OR REPLACE FUNCTION update_room_status()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Room
    SET room_status = 'Booked'
    WHERE room_id = NEW.room_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_room_status_on_booking
AFTER INSERT ON Booking
FOR EACH ROW
EXECUTE FUNCTION update_room_status();

--Viếtstoreprocedurecótênadd_customerđểthêmmớimộtkháchhàngvớiđầy đủcácthôngtincầnthiết
CREATE OR REPLACE PROCEDURE add_customer(
    p_id VARCHAR,
    p_name VARCHAR,
    p_email VARCHAR,
    p_phone VARCHAR,
    p_address VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Customer
    VALUES (p_id, p_name, p_email, p_phone, p_address);
END;
$$;

--HãytạomộtStoredProcedurecótênlàadd_paymentđểthựchiệnviệcthêm mộtthanhtoánmớichomộtlầnđặtphòng.
CREATE OR REPLACE PROCEDURE add_payment(
    p_booking_id INT,
    p_payment_method VARCHAR,
    p_payment_amount NUMERIC,
    p_payment_date DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Payment (booking_id, payment_method, payment_amount, payment_date)
    VALUES (p_booking_id, p_payment_method, p_payment_amount, p_payment_date);
END;
$$;






























