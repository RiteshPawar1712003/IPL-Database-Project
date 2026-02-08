
-- Database creation
create database ipl;
use  ipl;
-- table creation
CREATE TABLE TEAM (
  team_id INT PRIMARY KEY,
  team_name VARCHAR(255) NOT NULL,
  home_city VARCHAR(255) NOT NULL
);

CREATE TABLE COACH (
  coach_id INT PRIMARY KEY,
  coach_name VARCHAR(255) NOT NULL,
  experience_years INT,
  team_id INT UNIQUE,
  constraint team_id_fktm FOREIGN KEY (team_id) REFERENCES TEAM(team_id)
);

CREATE TABLE PLAYER (
  player_id INT PRIMARY KEY,
  player_name VARCHAR(255) NOT NULL,
  role ENUM('Batsman', 'Bowler', 'All-Rounder', 'Wicket-Keeper'),
  price_crore DECIMAL(5,2),
  team_id INT,
   constraint team_id_fkplr FOREIGN KEY (team_id) REFERENCES TEAM(team_id)
);

CREATE TABLE VENUE (
  venue_id INT PRIMARY KEY,
  stadium_name VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  capacity INT
);

CREATE TABLE MATCHES (
  match_id INT PRIMARY KEY,
  match_date DATE NOT NULL,
  venue_id INT,
  team1_id INT,
  team2_id INT,
  constraint team_id_fkmtchv FOREIGN KEY (venue_id) REFERENCES VENUE(venue_id),
  constraint team_id_fkmtcht1 FOREIGN KEY (team1_id) REFERENCES TEAM(team_id),
  constraint team_id_fkmtcht2 FOREIGN KEY (team2_id) REFERENCES TEAM(team_id)
);

CREATE TABLE PERFORMANCE (
  performance_id INT PRIMARY KEY,
  match_id INT,
  player_id INT,
  runs_scored INT,
  wickets_taken INT,
  catches INT,
  constraint team_id_fkmper FOREIGN KEY (match_id) REFERENCES MATCHES(match_id),
  constraint team_id_fkplper FOREIGN KEY (player_id) REFERENCES PLAYER(player_id)
);

-- insertion

insert into  TEAM(team_id,team_name,home_city)
             VALUES (108, 'Delhi capital', 'Delhi');
             
insert into  COACH( coach_id, coach_name,experience_years,team_id)
             VALUES (1118,'Ricky ponting',14,108);


insert into  PLAYER( player_id, player_name, role,price_crore,team_id)
             VALUES (2065, 'AB de Villiers', 'Batsman', 7.0, 102),
             (2063, 'Ishan Kishan', 'Wicket-Keeper', 15.25, 101);


INSERT INTO VENUE (venue_id, stadium_name, city, capacity) 
VALUES 
(1, 'Wakhande Stadium', 'Mumbai', 33000),
(2, 'M.A. Chidambaram Stadium', 'Chennai', 40000),
(3, 'M Chinnaswamy Stadium', 'Bangalore', 40000),
(4, 'Sawai Mansingh Stadium', 'Jaipur', 25000),
(5, 'Narendra Modi Stadium', 'Ahemdabad', 132000),
(6, 'Eden Gardens', 'Kolkata', 68000),
(7, 'Rajiv Gandhi International Cricket Stadium', 'Hyderabad', 55000),
(8, 'Arun Jaitley Stadium', 'Delhi', 41000);


INSERT INTO MATCHES (match_id, match_date, venue_id, team1_id, team2_id) 
VALUES 
(1, '2024-04-01', 1, 101, 102),
(2, '2024-04-02', 2, 105, 103),
(3, '2024-04-03', 3, 102, 106),
(4, '2024-04-04', 4, 104, 107),
(5, '2024-04-05', 5, 108, 101);


INSERT INTO PERFORMANCE (performance_id, match_id, player_id, runs_scored, wickets_taken, catches) VALUES 
(1, 1, 2045, 65, 0, 0), -- Rohit Sharma
(2, 1, 2018, 45, 0, 1), -- Virat Kohli
(3, 1, 2051, 0, 3, 0), -- Jasprit Bumrah
(4, 2, 2052, 88, 0, 0), -- Steve Smith
(5, 2, 2053, 32, 2, 1), -- Glenn Maxwell
(6, 3, 2049, 72, 0, 0), -- K L Rahul
(7, 3, 2007, 0, 1, 2), -- MS Dhoni
(8, 4, 2046, 102, 0, 0), -- Sanju Samson
(9, 4, 2054, 55, 0, 0), -- Kane Williamson
(10, 5, 2050, 40, 1, 0), -- Hardik Pandya
(11, 5, 2056, 10, 0, 0), -- Tristan Stubbs
(12, 5, 2063, 82, 0, 0); -- Ishan Kishan



-- Queries
--  1. Get all players who scored more than 50 runs in a match
SELECT p.player_name, perf.runs_scored 
FROM PLAYER p 
JOIN PERFORMANCE perf ON p.player_id = perf.player_id 
WHERE perf.runs_scored > 50;


-- 2. Get the top 3 players with the most runs scored

SELECT p.player_name, SUM(perf.runs_scored) as total_runs 
FROM PLAYER p 
JOIN PERFORMANCE perf ON p.player_id = perf.player_id 
GROUP BY p.player_name 
ORDER BY total_runs DESC 
LIMIT 3;


-- 3. Get all matches played at the Wakhande Stadium (venue_id = 1)

SELECT m.match_id, m.match_date, t1.team_name as team1, t2.team_name as team2 
FROM MATCHES m 
JOIN TEAM t1 ON m.team1_id = t1.team_id 
JOIN TEAM t2 ON m.team2_id = t2.team_id 
WHERE m.venue_id = 1;



-- 4. Get the player who took the most wickets in a match

SELECT p.player_name, perf.wickets_taken 
FROM PLAYER p 
JOIN PERFORMANCE perf ON p.player_id = perf.player_id 
ORDER BY perf.wickets_taken DESC 
LIMIT 1;


-- 5. Get all players who are wicket-keepers

SELECT * 
FROM PLAYER 
WHERE role = 'Wicket-Keeper';


-- 6. Get the total runs scored by each team

SELECT t.team_name, SUM(perf.runs_scored) as total_runs 
FROM TEAM t 
JOIN PLAYER p ON t.team_id = p.team_id 
JOIN PERFORMANCE perf ON p.player_id = perf.player_id 
GROUP BY t.team_name;

-- 7. Get the match details for a specific match_id (e.g., match_id = 1)

SELECT m.match_id, m.match_date, v.stadium_name, t1.team_name as team1, t2.team_name as team2 
FROM MATCHES m 
JOIN VENUE v ON m.venue_id = v.venue_id 
JOIN TEAM t1 ON m.team1_id = t1.team_id 
JOIN TEAM t2 ON m.team2_id = t2.team_id 
WHERE m.match_id = 1;
