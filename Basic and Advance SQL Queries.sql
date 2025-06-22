    SELECT * FROM  Books;
    SELECT * FROM  Customers;
    SELECT * FROM  Orders;
																 
																 --Basic Qureies--
																	
 -- 1) Retrieve all books in the "Fiction" genre

    CREATE VIEW All_Books_Fiction AS
    SELECT * FROM Books 
    WHERE genre = 'Fiction';

    /*Ans*/ SELECT * FROM  All_Books_Fiction;
 
 -- 2) Find books published after the year 1950
 
    CREATE VIEW After_1950 AS 
    SELECT * FROM Books 
    WHERE published_year > 1950;

    /*Ans*/ SELECT * FROM After_1950;
  
 -- 3) List all customers from the Canada

    CREATE VIEW All_Customers_Canada AS
    SELECT * FROM Customers 
    WHERE country = 'Canada';
 
    /*Ans*/ SELECT * FROM All_Customers_Canada;
  
 -- 4) Show orders placed in November 2023

    CREATE VIEW Orders_Placed_Nov_2023 AS
    SELECT * FROM Orders 
    WHERE order_date 
    BETWEEN '2023-11-01' AND '2023-11-30';
 
    /*Ans*/ SELECT * FROM Orders_Placed_Nov_2023;
  
 -- 5) Retrieve the total stock of books available
 
    CREATE VIEW Total_Stock AS
    SELECT SUM(stock) AS 
    Total_Stock FROM Books;
 
    /*Ans*/ SELECT * FROM Total_Stock;
  
 -- 6) Find the details of the most expensive book
 
    CREATE VIEW Most_Expensive_Book AS
    SELECT title, price AS Most_Expensive_Book 
    FROM Books 
    ORDER BY price DESC LIMIT 1;
 
    /*Ans*/ SELECT * FROM  Most_Expensive_Book;
  
 -- 7) Show all customers who ordered more than 1 quantity of a book

    CREATE VIEW Ordered_More_Than_1 AS
    SELECT * FROM Orders WHERE quantity > 1;
  
     /*Ans*/ SELECT * FROM Ordered_More_Than_1;
  
 -- 8) Retrieve all orders where the total amount exceeds $20
 
    CREATE VIEW Amount_Exceeds_20 AS
    SELECT * FROM  Orders WHERE total_amount > 20;
  
    /*Ans*/ SELECT * FROM Amount_Exceeds_20;
  
 -- 9) List all genres available in the Books table
 
    CREATE VIEW Genres_Available AS
    SELECT DISTINCT genre FROM Books;
		 
    /*Ans*/ SELECT * FROM Genres_Available;
	
 -- 10) Find the book with the lowest stock
 
    CREATE VIEW Lowest_Stock AS 
    SELECT title, stock AS Lowest_Stock 
    FROM Books
    ORDER BY stock ASC LIMIT 1;
 
    /*Ans*/ SELECT * FROM Lowest_Stock;
	
 -- 11) Calculate the total revenue generated from all orders
 
    CREATE VIEW Total_Revenue AS 
    SELECT SUM(total_amount) AS Total_Revenue 
    FROM Orders;
  
    /*Ans*/ SELECT * FROM Total_Revenue;

                                                              --Advance Queries--
															  
 -- 12) Retrieve the total number of books sold for each genre
 
     CREATE VIEW Total_Books_Sold_Each_Genre AS
	 SELECT b.genre, SUM(o.quantity) AS Total_Books_Sold 
     FROM Orders o
     JOIN Books b ON o.book_id = b.book_id
     GROUP BY b.genre;
 
     /*Ans*/ SELECT * FROM Total_Books_Sold_Each_Genre;
 
 -- 13) Calculates the average total amount for orders of books categorized as 'Fantasy'.
 
    CREATE VIEW Average_Price_Fantasy AS
	 SELECT b.genre, ROUND (AVG(o.total_amount),2) AS Average_Price_Fantasy FROM Orders o 
	 JOIN Books b ON o.book_id = b.book_id
	 WHERE b.genre = 'Fantasy'
	 GROUP BY b.genre;
	 
    /*Ans*/ SELECT * FROM Average_Price_Fantasy;
 
 -- 14) List customers who have placed at least 2 orders

	 CREATE VIEW At_Least_2_Orders AS
	 SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS Total_Orders FROM Customers c 
	 JOIN Orders o ON c.customer_id = o.customer_id
	 GROUP BY c.customer_name, c.customer_id
	 HAVING COUNT(o.order_id) >= 2;


    /*Ans*/ SELECT * FROM At_Least_2_Orders;
 
 -- 15) Find the title of the most frequently ordered book?

	 CREATE VIEW Frequently_Ordered_Book AS
	 SELECT b.title, COUNT(o.order_id) AS Frequently_Ordered_Book FROM Orders o
	 JOIN Books b ON o.book_id = b.book_id
	 GROUP BY b.title
	 ORDER BY Frequently_Ordered_Book DESC LIMIT 1;

    /*Ans*/ SELECT * FROM Frequently_Ordered_Book;
 
 -- 16) Show the top 3 most expensive books of 'Fantasy' Genre
 
    CREATE VIEW Top_3_Most_Expensive_Books AS
	 SELECT * FROM Books
	 WHERE genre = 'Fantasy'
	 ORDER BY genre DESC LIMIT 3;

    /*Ans*/ SELECT * FROM Top_3_Most_Expensive_Books;
 
 -- 17) Retrieve the total quantity of books sold by each author
 
    CREATE VIEW Total_Quantity_Sold_By_Author AS
	 SELECT b.author, SUM(o.quantity) AS Total_Quantity_Sold_By_Author FROM Orders o
	 JOIN Books b ON o.book_id = b.book_id
	 GROUP BY b.author;
	 
    /*Ans*/ SELECT * FROM Total_Quantity_Sold_By_Author;
 
 -- 18) List the cities where customers who spent over $30 are located
 
    CREATE VIEW Customers_Spent_Over_30 AS
	 SELECT c.city,  o.total_amount AS Customers_Spent_Over_30 FROM Customers c
	 JOIN Orders o ON c.customer_id = o.customer_id
	 WHERE o.total_amount > 30;
	 
    /*Ans*/ SELECT * FROM Customers_Spent_Over_30;
 
 -- 19) Find the customer who spent the most on orders
 
    CREATE VIEW Customer_Spent AS
	 SELECT  c.customer_id, c.customer_name , SUM(o.total_amount) AS Customer_Spent FROM Customers c
	 JOIN Orders o ON c.customer_id = o.customer_id
	 GROUP BY c.customer_id, c.customer_name
	 ORDER BY Customer_Spent DESC LIMIT 1;

    /*Ans*/ SELECT * FROM Customer_Spent;
 
 -- 20) Calculate the stock remaining after fulfilling all orders
 
     CREATE VIEW Remaining_Quantity AS
	  SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity), 0) AS Order_quantity,
     b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Quantity
     FROM books b
     LEFT JOIN orders o ON b.book_id = o.book_id
     GROUP BY b.book_id, b.title, b.stock
     ORDER BY b.book_id;

     /*Ans*/ SELECT * FROM Remaining_Quantity;
 