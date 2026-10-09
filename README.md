# Cricket Tournament Database

A relational database managing cricket tournaments, teams, stadiums,
matches, and scoring — covering match-team relationships that don't
reduce to a single table.

Built for a university database course (ISYS2014/ISYS5008) with the goal
of designing the schema from scratch rather than adapting an existing one.
The interesting problems were the composite keys on `Match_Team` and
`Score` (a match involves two teams, but neither column alone identifies
the relationship), and pushing match rules down to the database with
stored procedures and views rather than trusting the application to
handle everything.

## Stack

MySQL · SQL · Python · mysql.connector

## Schema

Six tables with primary and foreign key constraints:

- **Tournament** — competition name, format (ODI / T20 / Test), year, host country
- **Team** — team name, country, coach
- **Stadium** — venue name, city, country, capacity
- **Matches** — links a tournament to a stadium on a given date
- **Match_Team** — join table resolving the many-to-many relationship between matches and teams, using a composite primary key `(match_id, team_id)`
- **Player** — player name, date of birth, role, and a foreign key back to their team
- **Score** — modelled as a weak entity with a composite primary key `(match_id, team_id)`, holding runs, wickets, and overs per team per match

The many-to-many relationships are the design centrepiece: a team plays
many matches and a match involves two teams, so the relationship is
resolved through `Match_Team` rather than being collapsed into a single
column.

## Features

**Stored procedures** (`advanced_features.sql`)
- `GetPlayersByTeam(team_id)` — lists all players and roles for a given team
- `GetMatchWinner(match_id)` — returns the winning team and their score by selecting the highest run total for a match

**Views** (`advanced_features.sql`)
- `TeamTotalRuns` — total runs and distinct matches played per team
- `HighScores` — all scores of 300+ runs, ordered descending

**Indexes** (`advanced_features.sql`)
- `idx_player_team` on `Player(team_id)` for faster team-based player lookups
- `idx_score_match` on `Score(match_id)` for faster per-match score retrieval

**Analytical queries** (`queries.sql`) — ten queries demonstrating joins,
aggregates, subqueries, correlated subqueries, self-joins, `CASE`
expressions, and date functions. Highlights include a head-to-head team
comparison using a self-join on `Score`, and a stadium utilisation query
that counts matches hosted and distinct teams played per venue.

## Python client

`pythonToDatabase.py` connects to MySQL directly with `mysql.connector`
(no ORM) and demonstrates:

- A parameterless `SELECT` fetching all teams
- A parameterised `INSERT` adding a new team
- A parameterised `SELECT` fetching players by `team_id`

## Setup

### 1. Database

From the project directory, connect to MySQL:

```
mysql -u me -p
```

Enter the password `myUserPassword` when prompted.

Once inside the MySQL shell:

```sql
SOURCE create_tables.sql;
SOURCE insert_data.sql;
SOURCE queries.sql;
SOURCE advanced_features.sql;
```

If you ever see `ERROR 1046 (3D000): No database selected`, run
`USE dswork;` and re-run the statement.

### 2. Python client

Install the connector if it isn't already present:

```
pip install mysql-connector-python
```

Then, from a normal terminal (not inside the MySQL shell):

```
python3 pythonToDatabase.py
```

## Files

| File | Purpose |
|---|---|
| `create_tables.sql` | Table definitions with keys and constraints |
| `insert_data.sql` | Sample data across all tables |
| `queries.sql` | Ten analytical queries demonstrating SQL features |
| `advanced_features.sql` | Stored procedures, views, and indexes |
| `pythonToDatabase.py` | Python client using `mysql.connector` |
| `21564668_user_guide.pdf` | Original assignment user guide |

## Notes

- The database is named `dswork` throughout.
- Sample data spans historical ODI, T20, and Test matches, including
  tournaments from 1980 through 2024.
- The Python script uses a hardcoded local credentials set
  (`me` / `myUserPassword`) matching the course environment; for any
  real deployment these should come from environment variables instead.
