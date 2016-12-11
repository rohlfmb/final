<%-- 
    Document   : Results
    Created on : Dec 5, 2016, 9:18:25 PM
    Author     : rohlf
--%>

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
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"logout\">Logout</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"wishlist\">Wishlist</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"./jsp/Account.jsp\">Hello, " + session.getAttribute("userName") + "</a></li>");
                }
            %>
        </ul>

        <br>
        <br>
        <br>
        <br>
        <br>

        <%
            ArrayList<Book> wishList = new ArrayList();
            wishList = (ArrayList<Book>) session.getAttribute("wishList");

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
                    %> <a href="./jsp/Product.jsp?isbn=<%=wishList.get(ii).getIsbn()%>" style="font-family: Raleway; color: #69B578; font-weight: bold;"> <%
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
                    %> <p> <%                                if (wishList.get(ii).getDescription().length() >= 100) {
                            out.print(wishList.get(ii).getDescription().substring(0, 100));
                        } else {
                            out.print(wishList.get(ii).getDescription());
                        }
                        %> </p> <%
                    %> </td> <%
                %> </tr> <%                            }
                } else {
                %> 

            <br>
            <br>
            <br>
            
            <center>
            <h2>No Books in your Wishlist.</h2>
            <p>You can add books to your Wishlist on a product's page.</p>
            </center>

            <%
                }
            %>
        </table>

        <footer>
            <a href="about.jsp">About Us</a>
        </footer>
    </body>
</html>