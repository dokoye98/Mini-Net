
from cassandra.cluster import Cluster 


cluster = Cluster() 


cluster = Cluster(['172.17.0.2'], port=9042)


session = cluster.connect('big_data') 
session.set_keyspace('big_data')


session.execute('USE big_data') 


rows = session.execute('SELECT * FROM big_data.users')
print("Question 6.2\n")
for i in rows: 
     print(i)

def q6_3(country):
    query = f"SELECT * FROM Users WHERE Country = '{country}' ALLOW FILTERING"
    return query
rows = session.execute(q6_3(input("Country for 6.3: ")))
print("\n Question 6.3")
for i in rows:
    print(i)

rows = session.execute("SELECT * FROM Users WHERE Age >= 22 AND Age <= 30 ALLOW FILTERING")
print("\n Question 6.4")
for i in rows:
    print(i)


def q6_5(city):
    query = f"SELECT City, COUNT(UserID) FROM Users WHERE City = '{city}' ALLOW FILTERING"
    return query


rows = session.execute(q6_5(input("City for 6.5: ")))
print("\n Question 6.5")
for i in rows:
    print(i)