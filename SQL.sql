CREATE TABLE library.books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50) NOT NULL,
    published_year INTEGER,
    price REAL
);
-- Xem tất cả các database
SELECT datname
FROM pg_database;
--Xem tất cả các schema trong database
SELECT schema_name
FROM information_schema.schemata;
