use dswork;

-- Tournament
CREATE TABLE Tournament (
    tournament_id INT PRIMARY KEY,
    tournament_name VARCHAR(50) NOT NULL,
    format VARCHAR(10) NOT NULL,
    year INT NOT NULL,
    host_country VARCHAR(50)
);

-- Team
CREATE TABLE Team (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    coach VARCHAR(50)
);

-- Stadium
CREATE TABLE Stadium (
    stadium_id INT PRIMARY KEY,
    stadium_name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    capacity INT
);

-- Match
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    tournament_id INT NOT NULL,
    stadium_id INT NOT NULL,
    match_date DATE NOT NULL,
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    FOREIGN KEY (stadium_id) REFERENCES Stadium(stadium_id)
);


CREATE TABLE Match_Team (
    match_id INT,
    team_id INT,
    PRIMARY KEY (match_id, team_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);



-- Player
CREATE TABLE Player (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    role VARCHAR(20),
    team_id INT NOT NULL,
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);


-- Score (Weak Entity)
CREATE TABLE Score (
    match_id INT,
    team_id INT,
    runs INT,
    wickets INT,
    overs DECIMAL(4,1),
    PRIMARY KEY (match_id, team_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);
