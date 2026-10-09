USE dswork;

-- =====================================
-- STORED PROCEDURES
-- =====================================

-- Stored Procedure 1: Get players by team
DELIMITER //
CREATE PROCEDURE GetPlayersByTeam(IN team_id_param INT)
BEGIN
    SELECT player_name, role
    FROM Player
    WHERE team_id = team_id_param;
END //
DELIMITER ;

-- Stored Procedure 2: Get match winner
DELIMITER //
CREATE PROCEDURE GetMatchWinner(IN match_id_param INT)
BEGIN
    SELECT t.team_name, s.runs
    FROM Score s
    JOIN Team t ON s.team_id = t.team_id
    WHERE s.match_id = match_id_param
    ORDER BY s.runs DESC
    LIMIT 1;
END //
DELIMITER ;

-- =====================================
-- VIEWS
-- =====================================

-- View 1: Team total runs
CREATE VIEW TeamTotalRuns AS
SELECT 
    t.team_name,
    SUM(s.runs) AS total_runs,
    COUNT(DISTINCT s.match_id) AS matches_played
FROM Team t
JOIN Score s ON t.team_id = s.team_id
GROUP BY t.team_id;

-- View 2: High scores (300+ runs)
CREATE VIEW HighScores AS
SELECT 
    m.match_id,
    t.team_name,
    s.runs,
    s.wickets
FROM Score s
JOIN Team t ON s.team_id = t.team_id
JOIN Matches m ON s.match_id = m.match_id
WHERE s.runs >= 300
ORDER BY s.runs DESC;

-- =====================================
-- INDEXES
-- =====================================

-- Index for faster player searches by team
CREATE INDEX idx_player_team ON Player(team_id);

-- Index for faster score lookups by match
CREATE INDEX idx_score_match ON Score(match_id);

-- =====================================
-- DEMONSTRATION
-- =====================================

-- Test stored procedures
CALL GetPlayersByTeam(1);
CALL GetMatchWinner(1);

-- Test views
SELECT * FROM TeamTotalRuns;
SELECT * FROM HighScores;
