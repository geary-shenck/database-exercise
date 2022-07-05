-- for exercise in the basic-statement 

-- Explore the structure of the albums table.
-- use albums_db database
USE albums_db;
SHOW tables;

-- a. How many rows are in the albums table?
SELECT * FROM albums_db.albums;
-- 31

-- b. How many unique artist names are in the albums table?
SELECT DISTINCT artist FROM albums_db.albums;
-- 23

-- c. What is the primary key for the albums table?
DESCRIBE albums;
-- id

-- d. What is the oldest release date for any album in the albums table? 
-- What is the most recent release date?
SELECT release_date from albums;
-- manual sort 1967, 2011



-- Write queries to find the following information:

SELECT * FROM albums_db.albums;
-- a. The name of all albums by Pink Floyd
SELECT name FROM albums_db.albums WHERE artist = 'Pink Floyd';
-- the dark side of the moon, the wall

-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums_db.albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';
-- 1967

-- c. The genre for the album Nevermind
SELECT genre FROM albums_db.albums WHERE name = 'Nevermind';
-- Grunge, Alternative Rock

-- d. Which albums were released in the 1990s
SELECT name FROM albums_db.albums WHERE release_date between 1990 and 1999;
-- 11 of them

-- e. Which albums had less than 20 million certified sales
SELECT name FROM albums_db.albums WHERE sales < 20;
-- 13 of them

/* f. All the albums with a genre of "Rock". Why do these query results not 
include albums with a genre of "Hard rock" or "Progressive rock"? */
SELECT name, genre FROM albums_db.albums WHERE genre = 'Rock';
-- 5 of them, explict search for 'Rock', not inclusive

SELECT name, genre FROM albums_db.albums WHERE genre like '%Rock';