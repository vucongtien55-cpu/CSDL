CREATE TABLE elearning.students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR NOT NULL UNIQUE
);
CREATE TABLE elearning.instructors (
    instructor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR NOT NULL UNIQUE
);
CREATE TABLE elearning.courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INTEGER REFERENCES elearning.instructors(instructor_id)
);
CREATE TABLE elearning.enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES elearning.students(student_id),
    course_id INTEGER REFERENCES elearning.courses(course_id),
    enroll_date DATE NOT NULL
);
CREATE TABLE elearning.assignments (
    assignment_id SERIAL PRIMARY KEY,
    course_id INTEGER REFERENCES elearning.courses(course_id),
    title VARCHAR(100) NOT NULL,
    due_date DATE NOT NULL
);
CREATE TABLE elearning.submissions (
    submission_id SERIAL PRIMARY KEY,
    assignment_id INTEGER REFERENCES elearning.assignments(assignment_id),
    student_id INTEGER REFERENCES elearning.students(student_id),
    submission_date DATE NOT NULL,
    grade REAL CHECK (grade >= 0 AND grade <= 100)
);
-- xem danh sach database 
SELECT datname FROM pg_database;

-- xem danh sach schema 
SELECT schema_name FROM information_schema.schemata;

--xem cau truc bang SQL
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'elearning'
  AND table_name = 'students';
