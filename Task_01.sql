CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Publisher VARCHAR(150),
    YearPublished YEAR,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL
);

CREATE TABLE BookAuthors (
    ISBN VARCHAR(20),
    AuthorID INT,
    PRIMARY KEY (ISBN, AuthorID),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

CREATE TABLE Copies (
    CopyID INT AUTO_INCREMENT PRIMARY KEY,
    ISBN VARCHAR(20),
    CopyCondition VARCHAR(50),
    Location VARCHAR(100),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN) ON DELETE CASCADE
);

CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    CopyID INT,
    MemberID INT,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (CopyID) REFERENCES Copies(CopyID) ON DELETE CASCADE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE
);

INSERT INTO Categories (CategoryName) VALUES 
('Fiction'), ('Science'), ('History'), ('Philosophy');

INSERT INTO Books (ISBN, Title, Publisher, YearPublished, CategoryID) VALUES
('9788172234980', 'The White Tiger', 'HarperCollins India', 2008, 1),
('9780143442333', 'India 2020: A Vision for the New Millennium', 'Penguin India', 1998, 2),
('9780143031031', 'The Discovery of India', 'Penguin India', 1946, 3),
('9780143424116', 'The Guide', 'Penguin India', 1958, 1),
('9788129115300', 'Wings of Fire', 'Universities Press', 1999, 2);

INSERT INTO Authors (Name) VALUES
('Aravind Adiga'), ('A.P.J. Abdul Kalam'), ('Jawaharlal Nehru'), ('R.K. Narayan');

INSERT INTO BookAuthors (ISBN, AuthorID) VALUES
('9788172234980', 1), ('9780143442333', 2), ('9788129115300', 2), ('9780143031031', 3), ('9780143424116', 4);

INSERT INTO Members (Name, Phone, Address) VALUES
('Ravi Sharma', '9876543210', 'Delhi'),
('Priya Singh', '9123456789', 'Mumbai');

INSERT INTO Copies (ISBN, CopyCondition, Location) VALUES
('9788172234980', 'Good', 'Shelf A1'),
('9780143442333', 'Excellent', 'Shelf B2'),
('9780143031031', 'Worn', 'Shelf C3'),
('9780143424116', 'Good', 'Shelf D1'),
('9788129115300', 'Excellent', 'Shelf B1');

INSERT INTO Loans (CopyID, MemberID, LoanDate, DueDate) VALUES
(1, 1, '2025-09-13', '2025-09-30'),
(5, 2, '2025-09-13', '2025-09-25');

SELECT b.Title, b.YearPublished, c.CategoryName
FROM Books b
JOIN BookAuthors ba ON b.ISBN = ba.ISBN
JOIN Authors a ON ba.AuthorID = a.AuthorID
JOIN Categories c ON b.CategoryID = c.CategoryID
WHERE a.Name = 'A.P.J. Abdul Kalam';

SELECT m.Name AS MemberName, b.Title, l.LoanDate, l.DueDate
FROM Loans l
JOIN Members m ON l.MemberID = m.MemberID
JOIN Copies c ON l.CopyID = c.CopyID
JOIN Books b ON c.ISBN = b.ISBN
WHERE m.Name = 'Priya Singh' AND l.ReturnDate IS NULL;

SELECT c.CopyID, c.CopyCondition, c.Location
FROM Copies c
JOIN Books b ON c.ISBN = b.ISBN
LEFT JOIN Loans l ON c.CopyID = l.CopyID AND l.ReturnDate IS NULL
WHERE b.Title = 'The White Tiger' AND l.LoanID IS NULL;

SELECT b.Title, GROUP_CONCAT(a.Name SEPARATOR ', ') AS Authors
FROM Books b
JOIN BookAuthors ba ON b.ISBN = ba.ISBN
JOIN Authors a ON ba.AuthorID = a.AuthorID
GROUP BY b.Title;



