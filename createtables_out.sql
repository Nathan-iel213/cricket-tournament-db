mysql> use dswork;
Database changed
mysql> CREATE TABLE Tournament(tournament_id INT PRIMARY KEY, tournament_name VARCHAR(50) NOT NULL,)
    ->     format VARCHAR(10) NOT NULL,
    ->     year INT NOT NULL,
    -> ^C
mysql> CREATE TABLE Tournament (
    ->     tournament_id INT PRIMARY KEY,
    ->     tournament_name VARCHAR(50) NOT NULL,
    ->     format VARCHAR(10) NOT NULL,
    ->     year INT NOT NULL,
    ->     host_country VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> CREATE TABLE Team (
    ->     team_id INT PRIMARY KEY,
    ->     team_name VARCHAR(50) NOT NULL,
    ->     country VARCHAR(50) NOT NULL,
    ->     coach VARCHAR(50)
    -> ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 5
mysql> CREATE TABLE Team (
    ->     team_id INT PRIMARY KEY,
    ->     team_name VARCHAR(50) NOT NULL,
    ->     country VARCHAR(50) NOT NULL,
    ->     coach VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.11 sec)

mysql> CREATE TABLE Stadium (
    ->     stadium_id INT PRIMARY KEY,
    ->     stadium_name VARCHAR(50) NOT NULL,
    ->     city VARCHAR(50),
    ->     country VARCHAR(50),
    ->     capacity INT
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> CREATE TABLE Player (
    ->     player_id INT PRIMARY KEY,
    ->     player_name VARCHAR(50) NOT NULL,
    ->     date_of_birth DATE,
    ->     role VARCHAR(20),
    ->     team_id INT NOT NULL,
    ->     FOREIGN KEY (team_id) REFERENCES Team(team_id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> CREATE TABLE Match (
    ->     match_id INT PRIMARY KEY,
    ->     tournament_id INT NOT NULL,
    ->     stadium_id INT NOT NULL,
    ->     match_date DATE NOT NULL,
    ->     FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    ->     FOREIGN KEY (stadium_id) REFERENCES Stadium(stadium_id)
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Match (
    match_id INT PRIMARY KEY,
    tournament_id INT NOT NULL,
    stadiu' at line 1
mysql> CREATE TABLE Matches (
    ->     match_id INT PRIMARY KEY,
    ->     tournament_id INT NOT NULL,
    ->     stadium_id INT NOT NULL,
    ->     match_date DATE NOT NULL,
    ->     FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    ->     FOREIGN KEY (stadium_id) REFERENCES Stadium(stadium_id)
    -> );
Query OK, 0 rows affected (0.08 sec)

mysql> CREATE TABLE Score (
    ->     match_id INT,
    ->     team_id INT,
    ->     runs INT,
    ->     wickets INT,
    ->     overs DECIMAL(4,1),
    ->     PRIMARY KEY (match_id, team_id),
    ->     FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    ->     FOREIGN KEY (team_id) REFERENCES Team(team_id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> SHOW TABLES;
+------------------+
| Tables_in_dswork |
+------------------+
| Matches          |
| Player           |
| Score            |
| Stadium          |
| Team             |
| Tournament       |
+------------------+
6 rows in set (0.00 sec)

mysql> NOTEE;
