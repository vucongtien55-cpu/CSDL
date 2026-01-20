create table students(
	student_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	birth_date date,
	email text not null unique,
);

crate table courses(
	course_id serial primary key,
	course_name varchar(100) not null,
	credits int,
);

create table enrollments(
	enrollment_id serial primary key,
	student_id integer references university.students(student_id),
	course_id integer references university.Courses(course_id),
	enroll_date date,
);

-- xem danh sach database
select datname from pg_database;

-- xem danh sach schema
select schema_name from information_schema.schemata;

-- xem danh sach bang 
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'university'
	AND table_name = 'students';

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'university'
	AND table_name = 'courses';

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'university'
  	AND table_name = 'enrollments';

