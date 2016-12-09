<%-- 
    Document   : Results
    Created on : Dec 5, 2016, 9:18:25 PM
    Author     : rohlf
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="bookdeals.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Wishlist</title>
        <link rel="stylesheet" type="text/css" href="default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
    </head>
    <body>
        <ul>
            <li>
                <a href="home.jsp">
                    <img src="logo.png" alt="Logo" style="max-width:150px"/>
                </a>          
            <li>
                <form method="post" action="search">
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
            <%
                if ((Boolean) session.getAttribute("loggedIn") == null || (Boolean) session.getAttribute("loggedIn") == false) {
                    response.sendRedirect("../login.jsp");
                } else {
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"../logout\">Logout</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"./Wishlist.jsp\">Wishlist</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"Account.jsp\">Hello, " + session.getAttribute("userName") + "</a></li>");
                }
            %>
        </ul>

        <br>
        <br>
        <br>
        <br>
        <br>

        <%
            Connection conn = null;
            ResultSet rs = null;
            ArrayList<Book> wishList = new ArrayList();

            try {
                Class.forName("com.mysql.jdbc.Driver");

                conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");

                String sql = "SELECT title, author, genre, year, description, isbn FROM Books WHERE " + type + " LIKE ?";
                PreparedStatement ps = conn.prepareStatement(sql);

                //ps.setString(1, "%" + input + "%");
                rs = ps.executeQuery();

                while (rs.next()) {
                    Book book = new Book();

                    book.title = rs.getString("title");
                    book.author = rs.getString("author");
                    book.genre = rs.getString("genre");
                    book.year = rs.getInt("year");
                    book.description = rs.getString("description");
                    book.isbn = rs.getString("isbn");

                    wishList.add(book);
                }
            } catch (ClassNotFoundException | SQLException e) {
                System.out.println("Cause is " + e.toString());
            } finally {
                rs.close();
                conn.close();
            }

            //books = (ArrayList<Book>)request.getAttribute("books");
//            System.out.println(books.size());
            if (wishList.size() > 0) {
        %>        
        <table style="border-collapse: collapse;" align="center">
            <tr style="font-weight: bold; border-bottom: 1pt solid #242228">
                <td><p>Title</p></td>
                <td><p>Author</p></td>
                <td><p>Genre</p></td>
                <td><p>Year</p></td>
                <td><p>Description</p></td>
            </tr>
            <%
                for (int ii = 0; ii < wishList.size(); ii++) {
            %> <tr style="border-bottom: 1pt solid #D3D0CB"> <%
                %> <td> <%
                    %> <a href="./jsp/Product.jsp?isbn=<%=wishList.get(ii).getIsbn()%>" style="font-family: Raleway; color: #69B578;"> <%
                        out.print(wishList.get(ii).getTitle());
                        %> </a> <%
                    %> </td> <td> <%
                    %> <p> <%                                out.print(wishList.get(ii).getAuthor());
                        %> </p> <%
                    %> </td> <td> <%
                    %> <p> <%                                out.print(wishList.get(ii).getGenre());
                        %> </p> <%
                    %> </td> <td> <%
                    %> <p> <%                                out.print(wishList.get(ii).getYear());
                        %> </p> <%
                    %> </td> <td> <%
                    %> <p> <%                                out.print(wishList.get(ii).getDescription());
                        %> </p> <%
                    %> </td> <%
                %> </tr> <%                            }
                } else {
                %> 

            <p style="text-align: center">
                No results found. Please try searching again.
            </p>

            <%
                }
            %>
        </table>

        <footer>
            <a href="about.jsp">About Us</a>
        </footer>
    </body>
</html>