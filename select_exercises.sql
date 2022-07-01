-- for exercise in the basic-statement 
-- use albums_db database
USE albums_db;
/* Explore the structure of the albums table.
a. How many rows are in the albums table?
b. How many unique artist names are in the albums table?
c. What is the primary key for the albums table?
d. What is the oldest release date for any album in the albums table? What is the most recent release date? */

SHOW tables;

-- a 
SELECT * FROM albums_db.albums;
-- 31
d
-- b
SELECT DISTINCT artist FROM albums_db.albums;
-- 23

-- c
DESCRIBE albums;
-- id

-- d
SELECT release_date from albums;
-- manual sort 1967, 2011

/*Write queries to find the following information:
a. The name of all albums by Pink Floyd
b. The year Sgt. Pepper's Lonely Hearts Club Band was released
c. The genre for the album Nevermind
d. Which albums were released in the 1990s
e. Which albums had less than 20 million certified sales
f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? */
SELECT * FROM albums_db.albums;
-- a
SELECT name FROM albums_db.albums WHERE artist = 'Pink Floyd';
-- the dark side of the moon, the wall

-- b
SELECT release_date FROM albums_db.albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';
-- 1967

-- c
SELECT genre FROM albums_db.albums WHERE name = 'Nevermind';
-- Grunge, Alternative Rock

-- d 
SELECT name FROM albums_db.albums WHERE release_date between 1990 and 1999;
-- 11 of them

-- e
SELECT name FROM albums_db.albums WHERE sales < 20;
-- 13 of them

-- f
SELECT name, genre FROM albums_db.albums WHERE genre = 'Rock';
-- 5 of them, explict search for 'Rock', not inclusive

SELECT name, genre FROM albums_db.albums WHERE genre like '%Rock';