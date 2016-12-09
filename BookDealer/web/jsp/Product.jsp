<%-- 
    Document   : Product
    Created on : Dec 5, 2016, 10:04:04 PM
    Author     : rohlf
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="bookdeals.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Information</title>
        <link rel="stylesheet" type="text/css" href="../default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
    </head>
    <body>
        <ul>
            <li>
                <a href="../home.html">
                    <img src="../logo.png" alt="Logo" style="max-width:150px"/>
                </a>          
            <li>
              <form method="post" action="../search">
                  <input style='width:20em' name="search" type="text" placeholder="Search..." required>
                  <select name="type" required>
                      <option selected="selected" disabled>Select an Option</option>
                      <option value="title">Title</option>
                      <option value="author">Author</option>
                      <option value="isbn">ISBN</option>
                  </select>
                  <input type="submit" value='Search'>
              </form>          
            </li>
            <li style="float:right; padding-top: 15px; padding-right: 15px"><a href="Account.jsp">Account</a></li>
        </ul>
        
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <% 
            Connection conn = null;
            ResultSet bookRS = null;
            ResultSet priceRS = null;
            Book book = new Book();
            double amPrice = 0;
            double bnPrice = 0;
            double bmPrice = 0;
            double wmPrice = 0;
            DecimalFormat df = new DecimalFormat("#0.00");
            
            try {
            Class.forName("com.mysql.jdbc.Driver");
            
            conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");

            String bookSQL = "SELECT title, author, genre, year, description, isbn FROM Books WHERE isbn LIKE ?";
            PreparedStatement bookPS = conn.prepareStatement(bookSQL);            
            bookPS.setString(1, request.getParameter("isbn"));            
            bookRS = bookPS.executeQuery();

            String priceSQL = "SELECT vendor_id, price FROM Prices WHERE isbn = \"" + request.getParameter("isbn") + "\"";
            PreparedStatement pricePS = conn.prepareStatement(priceSQL);
            priceRS = pricePS.executeQuery();
            
            while(bookRS.next()) {                
                book.title = bookRS.getString("title");
                book.author = bookRS.getString("author");
                book.genre = bookRS.getString("genre");
                book.year = bookRS.getInt("year");
                book.description = bookRS.getString("description");
                book.isbn = bookRS.getString("isbn");
            }
            
//            System.out.println(book.getTitle());
//            System.out.println(book.getAuthor());
//            System.out.println(book.getGenre());
//            System.out.println(book.getYear());
//            System.out.println(book.getDescription());
//            System.out.println(book.getIsbn());
            
//            while(priceRS.next()) {
//                amPrice = priceRS.absolute(1);
//            }
            priceRS.absolute(1);
            amPrice = priceRS.getDouble("price");
            priceRS.next();
            bnPrice = priceRS.getDouble("price");
            priceRS.next();
            bmPrice = priceRS.getDouble("price");
            priceRS.next();
            wmPrice = priceRS.getDouble("price");
        }
        catch (ClassNotFoundException | SQLException e) {
            System.out.println("Cause is " + e.toString());
        }
        finally {
            bookRS.close();
            priceRS.close();
            conn.close();
        }
            
        %> 
        
        <div class="product">
            <img src="../img/<%=book.getIsbn()%>.jpg" alt="Book Cover" style="float: left; padding-right: 15px;"/>      
            <h2> <%=book.getTitle()%> </h2>
            <p> <%=book.getAuthor()%> </p>
            <p> <%=book.getGenre()%> </p>
            <p> <%=book.getYear()%> </p>
            <p> <%=book.getDescription()%> </p>
            <p> <%=book.getIsbn()%> </p>
        </div>
        
        <div class="section group" align="center" style="width: 900px; padding-left: 15px; padding-right: 15px; padding-top: 30px;
                                                        display: block; margin-left: auto; margin-right: auto;">
	<div class="col span_1_of_4">
            <h2>Amazon</h2>
            
            <p> $<%=df.format(amPrice)%> </p>
	</div>
	<div class="col span_1_of_4">
            <h2>Barnes & Noble</h2>
            
            <p> $<%=df.format(bnPrice)%> </p>
	</div>
	<div class="col span_1_of_4">
            <h2>Books-A-Million</h2>
            
            <p> $<%=df.format(bmPrice)%> </p>
	</div>
	<div class="col span_1_of_4">
            <h2>WalMart</h2>
            
            <p> $<%=df.format(wmPrice)%> </p>
	</div>
    </div>
        
        <footer>
            <a href="about.html">About Us</a>
        </footer>
    </body>
</html>