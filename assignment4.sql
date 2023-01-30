CREATE TABLE teams (
    team_id INTEGER NOT NULL,
    team_name VARCHAR(30) NOT NULL,
    UNIQUE (team_id)
);
DROP TABLE matches;
CREATE TABLE matches 
(
match_id INTEGER NOT NULL,
_host_team INTEGER NOT NULL,
_guest_team INTEGER NOT NULL,
_host_goals INTEGER NOT NULL,
_guest_goals INTEGER NOT NULL,
UNIQUE (match_id)
);

INSERT INTO teams VALUE (10, "Give");
INSERT INTO teams VALUE (20, "Never");
INSERT INTO teams VALUE (30, "You");
INSERT INTO teams VALUE (40, "Up");
INSERT INTO teams VALUE (50, "Gonna");

SELECT * FROM teams;

INSERT INTO matches VALUE (1, 30, 20, 1, 0);
INSERT INTO matches VALUE (2, 10, 20, 1, 2);
INSERT INTO matches VALUE (3, 20, 50, 2, 2);
INSERT INTO matches VALUE (4, 10, 30, 1, 0);
INSERT INTO matches VALUE (5, 30, 50, 0, 1);

SELECT * FROM matches;


CREATE TABLE host_point
(
SELECT _host_team,_host_goals,_guest_goals,
    CASE 
		WHEN _host_goals > _guest_goals THEN 3
		WHEN _host_goals < _guest_goals THEN 0
		WHEN _host_goals = _guest_goals THEN 1
	END AS host_points
FROM matches
);
SELECT * FROM host_point;
DROP TABLE guest_point;
CREATE TABLE guest_point
(
SELECT _guest_team,_host_goals,_guest_goals,
    CASE 
		WHEN _host_goals > _guest_goals THEN 0
		WHEN _host_goals < _guest_goals THEN 3
		WHEN _host_goals = _guest_goals THEN 1
	END AS guest_points
FROM matches
);
SELECT * FROM guest_point;
CREATE TABLE points
(
SELECT _host_team AS team_id,host_points AS num_points FROM host_point
UNION ALL
SELECT _guest_team,guest_points FROM guest_point
);

CREATE TABLE final_points
(
SELECT team_id,SUM(num_points) AS num_points
FROM points
GROUP BY(team_id)
ORDER BY num_points DESC,team_id
);


SELECT t.team_id,t.team_name, 
CASE 
	WHEN fp.num_points IS NULL THEN 0
    ELSE fp.num_points
END AS num_point
FROM teams t
LEFT JOIN final_points fp ON fp.team_id = t.team_id
ORDER BY num_points DESC;









