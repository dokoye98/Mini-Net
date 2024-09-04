create database CW2;
USE CW2;
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL,
    SubscriptionType VARCHAR(5),
    City VARCHAR(50),
    Country VARCHAR(50),
    Age INT
);
CREATE TABLE Actors (
    ActorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    City VARCHAR(50)
);
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    ReleaseDate DATE
);
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    MovieID INT,
    Score INT CHECK (Score >= 0 AND Score <= 5),
    Comment TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE
);
CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    PlanName VARCHAR(5),
    Price DECIMAL(4, 2),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
CREATE TABLE FavouriteMovies (
    FavouriteID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    MovieID INT,
    Score INT CHECK (Score >= 0 AND Score <= 5),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE
);
CREATE TABLE MovieHistory (
    MovHistoryID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    MovieID INT,
    WatchDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE
);
CREATE TABLE MovieActors (
    MovieActorID INT PRIMARY KEY AUTO_INCREMENT,
    MovieID INT,
    ActorID INT,
    Role VARCHAR(50),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON DELETE CASCADE,
    FOREIGN KEY (ActorID) REFERENCES Actors(ActorID) ON DELETE CASCADE
);
INSERT INTO Users (Username, Email, Password, SubscriptionType, City, Country, Age) VALUES
('john_doe', 'john@example.com', 'password1', 'HD', 'New York', 'USA', 28),
('alice_smith', 'alice@example.com', 'password2', 'HD', 'Los Angeles', 'USA', 34),
('jane_doe', 'jane@example.com', 'password3', 'UHD', 'Chicago', 'USA', 21),
('bob_jones', 'bob@example.com', 'password4', 'UHD', 'Chicago', 'USA', 30),
('Dwayne', 'Dwayne@example.com', 'password', 'HD', 'New York', 'USA', 25),
('Tyler', 'Tyler@example.com', 'password', 'HD', 'New York', 'USA', 23),
('emma_johnson', 'emma@example.com', 'password5', 'HD', 'San Francisco', 'USA', 25);

INSERT INTO Actors (Name, City, DateOfBirth) VALUES
('Millie Bobby Brown', 'Los Angeles', '2004-02-19'),
('Bryan Cranston', 'Hollywood', '1956-03-07'),
('Winona Ryder', 'New York', '1971-10-29'),
('Aaron Paul', 'Boise', '1979-08-27'),
('David Harbour', 'White Plains', '1975-04-10');

INSERT INTO Movies (Title, Genre, ReleaseDate) VALUES
('Stranger Things', 'Sci-Fi', '2016-07-15'),
('Breaking Bad', 'Drama', '2008-01-20'),
('The Office', 'Comedy', '2005-03-24'),
('Parks and Recreation', 'Comedy', '2009-04-09'),
('The Godfather', 'Crime', '1972-03-24');
INSERT INTO Reviews (UserID, MovieID, Score, Comment) VALUES
(1, 1, 5, 'Amazing show!'),
(2, 2, 3, 'Good show'),
(3, 3, 4, 'Funny and smart'),
(4, 4, 2, 'Not my taste'),
(5, 5, 5, 'A classic!');

INSERT INTO Subscriptions (UserID, PlanName, Price) VALUES
(1, 'HD', 9.99),
(2, 'HD', 9.99),
(3, 'UHD', 14.99),
(4, 'UHD', 14.99),
(5, 'HD', 9.99);

INSERT INTO FavouriteMovies (UserID, MovieID, Score) VALUES
(1, 3, 5),
(2, 5, 4),
(3, 1, 5),
(4, 4, 2),
(5, 2, 3);

INSERT INTO MovieHistory (UserID, MovieID, WatchDate) VALUES
(1, 1, '2023-06-10'),
(2, 2, '2023-06-11'),
(3, 3, '2023-06-12'),
(4, 4, '2023-06-13'),
(5, 5, '2023-06-14');

INSERT INTO MovieActors (MovieID, ActorID, Role) VALUES
(1, 1, 'Eleven'),
(2, 2, 'Walter White'),
(3, 3, 'Michael Scott'),
(4, 4, 'Leslie Knope'),
(5, 5, 'Vito Corleone');

SELECT * FROM Users where SubscriptionType = 'HD';
select Actors.ActorID, Actors.Name, Actors.DateOfBirth, Movies.MovieID, Movies.Title, Movies.Genre, Movies.ReleaseDate
from Actors join MovieActors on Actors.ActorID= MovieActors.ActorID join   Movies on  MovieActors.MovieID = Movies.MovieID;
select City, COUNT(ActorID) AS NumberOfActors, AVG(year(curdate()) - year(DateOfBirth)) as AvgAge from Actors group by City; 
select Movies.Genre, AVG(Reviews.score) as AverageScore from Movies join Reviews on Movies.MovieID = Reviews.MovieID group by Genre;
select Users.City, COUNT(Subscriptions.SubscriptionID) from Users join Subscriptions on Users.UserID = Subscriptions.SubscriptionID group by City;
select MovieID ,Title , Genre, ReleaseDate FROM Movies where Title Like 'The%';
 
 select * from Users where Age=(select min(age) from Users);
 
  select * from Users where Age <= 30 and Age >=22;
  SELECT 
    CASE 
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 21 AND 40 THEN '21-40'
        ELSE '41 and over'
    END AS AgeGroup,
    AVG(Age) AS AverageAge
FROM Users
JOIN Reviews ON Users.UserID = Reviews.UserID
WHERE Reviews.Score < 3
GROUP BY AgeGroup;




