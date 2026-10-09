-- Query 1: List all matches with formatted date and stadium location
-- Shows use of DATE_FORMAT and string concatenation
SELECT 
    m.match_id,
    DATE_FORMAT(m.match_date, '%W, %M %d, %Y') AS formatted_date,
    CONCAT(s.stadium_name, ', ', s.city, ', ', s.country) AS stadium_location
FROM Matches m
JOIN Stadium s ON m.stadium_id = s.stadium_id
ORDER BY m.match_date;

-- Query 2: Find players born after 1985 with their age calculated
-- Shows use of TIMESTAMPDIFF and date functions
SELECT 
    player_name,
    date_of_birth,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age,
    UPPER(role) AS role_uppercase
FROM Player
WHERE date_of_birth > '1985-01-01'
ORDER BY age;


-- Query 3: Display match scores with conditional formatting
-- Shows CASE statements and numeric formatting
SELECT 
    s.match_id,
    s.team_id,
    s.runs,
    s.wickets,
    s.overs,
    CONCAT(s.runs, '/', s.wickets) AS score_summary,
    CASE 
        WHEN s.runs >= 300 THEN 'High Score'
        WHEN s.runs BETWEEN 200 AND 299 THEN 'Medium Score'
        ELSE 'Low Score'
    END AS score_category
FROM Score s
WHERE s.overs >= 20.0;

-- Query 4: Find matches from current year with month extraction
-- Shows YEAR() and MONTH() functions
SELECT 
    match_id,
    match_date,
    YEAR(match_date) AS year,
    MONTHNAME(match_date) AS month_name,
    QUARTER(match_date) AS quarter
FROM Matches
WHERE YEAR(match_date) = YEAR(CURDATE())
ORDER BY match_date;


-- Query 5: Team performance - total runs, average runs, and match count
-- Shows GROUP BY, aggregate functions, and multiple joins
SELECT 
    t.team_name,
    t.country,
    COUNT(DISTINCT s.match_id) AS matches_played,
    SUM(s.runs) AS total_runs,
    AVG(s.runs) AS avg_runs_per_match,
    MAX(s.runs) AS highest_score,
    SUM(CASE WHEN s.wickets = 10 THEN 1 ELSE 0 END) AS all_outs_matches
FROM Team t
LEFT JOIN Score s ON t.team_id = s.team_id
GROUP BY t.team_id, t.team_name, t.country
HAVING matches_played > 0
ORDER BY total_runs DESC;

-- Query 6: Find matches where both teams scored above average
-- Shows subquery with aggregate, HAVING clause
SELECT 
    s.match_id,
    t.team_name,
    s.runs,
    s.wickets,
    (SELECT AVG(runs) FROM Score) AS tournament_avg_score
FROM Score s
JOIN Team t ON s.team_id = t.team_id
WHERE s.runs > (SELECT AVG(runs) FROM Score)
ORDER BY s.match_id, s.runs DESC;

-- Query 7: Players with their team details and total team matches
-- Shows correlated subquery and multiple joins
SELECT 
    p.player_name,
    p.role,
    t.team_name,
    t.country,
    (SELECT COUNT(DISTINCT match_id) 
     FROM Score s 
     WHERE s.team_id = t.team_id) AS team_matches_played
FROM Player p
JOIN Team t ON p.team_id = t.team_id
WHERE p.player_id IN (
    SELECT player_id FROM Player WHERE role LIKE '%batsman%'
)
ORDER BY t.team_name, p.player_name;

-- Query 8: Stadium utilization with match counts and venue statistics
-- Shows LEFT JOIN, GROUP BY with multiple aggregates, subquery
SELECT 
    s.stadium_name,
    s.city,
    s.country,
    s.capacity,
    COUNT(m.match_id) AS matches_hosted,
    COALESCE(SUM(sc.runs), 0) AS total_runs_scored,
    AVG(sc.runs) AS avg_score_at_venue,
    (SELECT COUNT(DISTINCT team_id) 
     FROM Score sc2 
     WHERE sc2.match_id IN (SELECT match_id FROM Matches m2 WHERE m2.stadium_id = s.stadium_id)
    ) AS distinct_teams_played
FROM Stadium s
LEFT JOIN Matches m ON s.stadium_id = m.stadium_id
LEFT JOIN Score sc ON m.match_id = sc.match_id
GROUP BY s.stadium_id, s.stadium_name, s.city, s.country, s.capacity
ORDER BY matches_hosted DESC, avg_score_at_venue DESC;

-- Query 9: Tournament analysis with match statistics
-- Shows multiple joins, nested aggregates, and complex grouping
SELECT 
    t.tournament_name,
    t.format,
    t.year,
    COUNT(DISTINCT m.match_id) AS total_matches,
    AVG(score_stats.total_runs_per_match) AS avg_runs_per_match,
    MAX(score_stats.total_runs_per_match) AS highest_match_total,
    MIN(score_stats.total_runs_per_match) AS lowest_match_total
FROM Tournament t
LEFT JOIN Matches m ON t.tournament_id = m.tournament_id
LEFT JOIN (
    SELECT 
        match_id,
        SUM(runs) AS total_runs_per_match
    FROM Score
    GROUP BY match_id
) score_stats ON m.match_id = score_stats.match_id
GROUP BY t.tournament_id, t.tournament_name, t.format, t.year
HAVING total_matches > 0
ORDER BY t.year DESC, avg_runs_per_match DESC;


-- Query 10: Head-to-head team comparison
-- Shows self-join and match analysis
SELECT 
    t1.team_name AS team1,
    t2.team_name AS team2,
    COUNT(DISTINCT s1.match_id) AS matches_played,
    AVG(s1.runs) AS team1_avg_score,
    AVG(s2.runs) AS team2_avg_score,
    SUM(CASE WHEN s1.runs > s2.runs THEN 1 ELSE 0 END) AS team1_wins,
    SUM(CASE WHEN s2.runs > s1.runs THEN 1 ELSE 0 END) AS team2_wins
FROM Score s1
JOIN Score s2 ON s1.match_id = s2.match_id AND s1.team_id < s2.team_id
JOIN Team t1 ON s1.team_id = t1.team_id
JOIN Team t2 ON s2.team_id = t2.team_id
GROUP BY t1.team_name, t2.team_name
HAVING matches_played >= 1
ORDER BY matches_played DESC;





