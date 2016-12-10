<%-- 
    Document   : Account
    Created on : Dec 7, 2016, 1:03:48 AM
    Author     : rohlf
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account</title>
        <link rel="stylesheet" type="text/css" href="../default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
    </head>
    <body>
        <ul>
            <li>
                <a href="../home.jsp">
                    <img src="../logo.png" alt="Logo" style="max-width:150px"/>
                </a>          
            <li>
                <form id="search" method="post" action="../search">
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

        <footer>
            <a href="../about.jsp">About Us</a>
        </footer>
    </body>
</html>
