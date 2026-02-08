'1. List all players with their team names'
SELECT p.player_name, t.team_name
FROM player p
JOIN team t
ON p.team_id = t.team_id;

'2. Count number of players in each team'
SELECT t.team_name, COUNT(p.player_id) AS total_players
FROM team t
LEFT JOIN player p
ON t.team_id = p.team_id
GROUP BY t.team_name;

'3. Find the highest paid player'
SELECT player_name, price_crore
FROM player
ORDER BY price_crore DESC
LIMIT 1;

'4. Show teams with more than 5 players'
SELECT t.team_name, COUNT(p.player_id) AS total_players
FROM team t
JOIN player p
ON t.team_id = p.team_id
GROUP BY t.team_name
HAVING COUNT(p.player_id) > 5;

'5. Average player price per team'
SELECT t.team_name, AVG(p.price_crore) AS avg_price
FROM team t
JOIN player p
ON t.team_id = p.team_id
GROUP BY t.team_name;

'6. Players whose price is above average'
SELECT player_name, price_crore
FROM player
WHERE price_crore >
      (SELECT AVG(price_crore) FROM player);

'7. Total spending of each team'
SELECT t.team_name, SUM(p.price_crore) AS total_spent
FROM team t
JOIN player p
ON t.team_id = p.team_id
GROUP BY t.team_name;

'8. List players sorted by price'
SELECT player_name, price_crore
FROM player
ORDER BY price_crore DESC;

'9. Find teams having at least one player above 10 crore'
SELECT DISTINCT t.team_name
FROM team t
JOIN player p
ON t.team_id = p.team_id
WHERE p.price_crore > 10;


'10. Top 5 most expensive players'
SELECT player_name, price_crore
FROM player
ORDER BY price_crore DESC
LIMIT 5;
