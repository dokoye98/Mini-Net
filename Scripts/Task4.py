import mysql.connector
from mysql.connector import Error

def create_db_connection(host_name, user_name, user_password, db_name):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password,
            database=db_name
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return connection

host = "localhost" 
user = "root"
password = "root" 
database = "BigData2"

connection = create_db_connection(host, user, password, database)




q4_1 = "SELECT * FROM Users where SubscriptionType = 'HD';"
q4_2 = """select Actors.ActorID, Actors.Name, Actors.DateOfBirth, Movies.MovieID, Movies.Title, Movies.Genre, Movies.ReleaseDate
from Actors join MovieActors on Actors.ActorID= MovieActors.ActorID join   Movies on  MovieActors.MovieID = Movies.MovieID;"""
q4_3 = "select City, COUNT(ActorID) AS NumberOfActors, AVG(year(curdate()) - year(DateOfBirth)) as AvgAge from Actors group by City; "
q4_4 = "SELECT Users.Username, Movies.MovieID, Movies.Title, Movies.Genre, Movies.ReleaseDate FROM Users JOIN favouritemovies ON Users.Username = favouritemovies.Username JOIN Movies ON favouritemovies.MovieTitle = Movies.Title WHERE Movies.Genre = 'Comedy' AND Users.Username = 'john_doe';"
q4_5 = "select Users.City, COUNT(Subscriptions.SubscriptionID) from Users join Subscriptions on Users.UserID = Subscriptions.SubscriptionID group by City;"


def execute_query(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        result = cursor.fetchall()  
        connection.commit()
        print("Query successful")
        return result
    except Error as err:
        print(f"Error: '{err}'")

queries = [q4_1,q4_2,q4_3,q4_4,q4_5]
counter  = 1

for i in queries:
    questionMarker = f"Question 4.{counter}"
    res = execute_query(connection, i)    
    print(f"{questionMarker} \n")
    for row in res:
        print(f"{row} \n")
    counter+=1
else:
    print("No results found.")
    