<%-- 
    Document   : Product
    Created on : Dec 5, 2016, 10:04:04 PM
    Author     : rohlf
--%>

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
            ResultSet rs = null;
            Book book = new Book();
            
            try {
            Class.forName("com.mysql.jdbc.Driver");
            
            conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");

            String sql = "SELECT title, author, genre, year, description, isbn FROM Books WHERE isbn LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, request.getParameter("isbn"));
            
            rs = ps.executeQuery();
            
            
            while(rs.next()) {                
                book.title = rs.getString("title");
                book.author = rs.getString("author");
                book.genre = rs.getString("genre");
                book.year = rs.getInt("year");
                book.description = rs.getString("description");
                book.isbn = rs.getString("isbn");
            }
            
            System.out.println(book.getTitle());
            System.out.println(book.getAuthor());
            System.out.println(book.getGenre());
            System.out.println(book.getYear());
            System.out.println(book.getDescription());
            System.out.println(book.getIsbn());
        }
        catch (ClassNotFoundException | SQLException e) {
            System.out.println("Cause is " + e.toString());
        }
        finally {
            rs.close();
            conn.close();
        }
            
        %> 
        
        <img src="../img/<%=book.getIsbn()%>.jpg" alt="Book Cover" style="padding-left: 15px;">
        
        <p> <% 
            out.println(book.getTitle());
            out.println(book.getAuthor());
            out.println(book.getGenre());
            out.println(book.getYear());
            out.println(book.getDescription());
            out.println(book.getIsbn());
        %> </p>
        
        <footer>
            <a href="about.html">About Us</a>
        </footer>
    </body>
</html>
