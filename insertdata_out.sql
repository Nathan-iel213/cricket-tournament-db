mysql> INSERT INTO Tournament VALUES
    -> (1, 'World Cup', 'ODI', 2023, 'India');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Team VALUES
    -> (1, 'India', 'India', 'Rahul Dravid'),
    -> (2, 'Australia', 'Australia', 'Andrew McDonald');
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Stadium VALUES
    -> (1, 'Wankhede Stadium', 'Mumbai', 'India', 33000);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Player VALUES
    -> (1, 'Virat Kohli', '1988-11-05', 'Batsman', 1),
    -> (2, 'Steve Smith', '1989-06-02', 'Batsman', 2);
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Matches VALUES
    -> (1, 1, 1, '2023-10-10');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Score VALUES
    -> (1, 1, 280, 6, 50.0),
    -> (1, 2, 275, 9, 50.0);
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> NOTEE;
