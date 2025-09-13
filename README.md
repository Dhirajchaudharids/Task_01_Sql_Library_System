# Task_01_Sql_Library_System
I build schema for library management system using MySql.
Step 1: Understanding the Problem
I had to design a database for a library. The library stores books, authors, members, and also tracks who borrowed which book.
At first, I thought of keeping everything in one big table:
(MemberID, MemberName, BookTitle, AuthorName, Publisher, CopyNo, LoanDate, DueDate, ReturnDate)
But I realized this will have repetition and is not normalized. So I decided to normalize it up to 3NF.

Step 2: Apply 1NF (remove repeating groups)
I separated entities into different tables:
Members
Books
Authors
Loans
Now, no repeating groups, only atomic values.

Step 3: Apply 2NF (remove partial dependency)
In a many-to-many case (Books ↔ Authors), I created a join table BookAuthors.
Now authors and books are independent, but still linked.

Step 4: Apply 3NF (remove transitive dependency)

I noticed each book has a category (Fiction, Science, etc.).
Instead of writing category names again and again, I created a separate Categories table.
Books table now stores only CategoryID as a foreign key.

Step 5: Final Schema (in 3NF)

Members(MemberID, Name, Phone, Address)
Categories(CategoryID, CategoryName)
Books(ISBN, Title, Publisher, YearPublished, CategoryID)
Authors(AuthorID, Name)
BookAuthors(ISBN, AuthorID) (for many-to-many)
Copies(CopyID, ISBN, Condition, Location)
Loans(LoanID, CopyID, MemberID, LoanDate, DueDate, ReturnDate)

Step 6: Insert Example Data (Indian Authors)

Books: The White Tiger (HarperCollins India, by Aravind Adiga),
Wings of Fire (Universities Press, by A.P.J. Abdul Kalam).
Authors: Aravind Adiga, Abdul Kalam.
Members: Ravi Sharma (Delhi), Priya Singh (Mumbai).
Copies: Each book has physical copies stored on shelves.
Loans: Members borrow specific copies.

Step 7: Use of JOINs

Since data is in multiple tables, I learned to use JOIN queries.
For example:
To find all books written by Abdul Kalam, I joined Books + BookAuthors + Authors.
To find books borrowed by Priya Singh, I joined Loans + Members + Copies + Books.

Final Reflection:

This was my first time designing a normalized schema. At first it looked confusing, but step by step I:
Started with a single table,
Broke it into entities (1NF),
Handled many-to-many with join tables (2NF),
Removed transitive dependency (3NF).
Now the schema is clean, avoids duplication, and supports queries with JOINs.
