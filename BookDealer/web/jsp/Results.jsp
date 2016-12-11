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
        <title>Results</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
    </head>
    <body>
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/home.jsp">
                    <img src="${pageContext.request.contextPath}/logo.png" alt="Logo" style="max-width:150px;"/>
                </a>          
            <li>
                <form id="search" method="post" action="search">
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
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"login.jsp\">Login</a></li>");
                } else {
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px;\"><a href=\"../logout\">|&nbsp;&nbsp;&nbsp;&nbsp;Logout</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px;\"><a href=\"../wishlist\">|&nbsp;&nbsp;&nbsp;Wishlist</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"Account.jsp\">" + session.getAttribute("userName") + "</a></li>");
                }
            %>
        </ul>

        <br>
        <br>
        <br>
        <br>
        <br>

        <%
            ArrayList<Book> books = new ArrayList();
            books = (ArrayList<Book>) request.getAttribute("books");

            if (books.size() > 0) {
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
                for (int ii = 0; ii < books.size(); ii++) {
            %> <tr style="border-bottom: 1pt solid #D3D0CB"> <%
                %> <td style="padding-left: 10px;"> <%
                    %> <a href="./jsp/Product.jsp?isbn=<%=books.get(ii).getIsbn()%>" style="font-family: Raleway; color: #69B578; font-weight: bold;"> <%
                        out.print(books.get(ii).getTitle());
                        %> </a> <%
                    %> </td> <td> <%
                    %> <p> <% out.print(books.get(ii).getAuthor()); %> </p> <%
                    %> </td> <td> <%
                    %> <p> <% out.print(books.get(ii).getGenre()); %> </p> <%
                    %> </td> <td> <%
                    %> <p> <% out.print(books.get(ii).getYear()); %> </p> <%
                    %> </td> <td style="padding-right: 10px;"> <%
                    %> <p> <%                                
                        if (books.get(ii).getDescription().length() >= 125) {
                            out.print(books.get(ii).getDescription().substring(0, 125) + "...");
                        } else {
                            out.print(books.get(ii).getDescription());
                        }
                        %> </p> <%
                    %> </td> <%
                %> </tr> <% }
                } else {
                %>  <p style="text-align: center">
                        No results found. Please try searching again.
                    </p> <%
                }
            %>
        </table>

        <footer>
            <a href="about.jsp">About Us</a>
        </footer>
    </body>
</html>