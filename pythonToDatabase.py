import mysql.connector


# Connect to Darabase

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="me",
        password="myUserPassword",
        database="dswork"
    )

    print("Connected to database")

    
    # Create cursor
   
    cursor = conn.cursor()

  
    # SELECT query
 
    print("\n--- Teams in Database ---")
    select_query = "SELECT * FROM Team"
    cursor.execute(select_query)

    rows = cursor.fetchall()   # Step 5: fetch results
    for row in rows:
        print(row)

 
    # INSERT
    print("\n--- Inserting new team ---")

    insert_query = "INSERT INTO Team (team_id, team_name, country, coach) VALUES (%s, %s, %s, %s)"
    data = (11, "New Zealand", "New Zealand", "Gary Stead")

    cursor.execute(insert_query, data)
    conn.commit()

    print("Inserted successfully")


    # SELECT with parameter

    print("\n--- Players from Team 1 ---")

    select_param_query = "SELECT player_name FROM Player WHERE team_id = %s"
    cursor.execute(select_param_query, (1,))

    for row in cursor:
        print(row)


 #Close connection

    cursor.close()
    conn.close()
    print("\nConnection closed")

except mysql.connector.Error as err:
    print("Error:", err)
