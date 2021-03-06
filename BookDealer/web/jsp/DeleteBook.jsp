<%-- 
    Document   : Delete
    Created on : Dec 11, 2016, 4:05:29 AM
    Author     : Rebecca Andrews
--%>

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Delete</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
    </head>
    <body>
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/home.jsp">
                    <img src="${pageContext.request.contextPath}/logo.png" alt="Logo" style="max-width:150px"/>
                </a>          
            <li>
                <form id="search" method="post" action="search">
                    <input style='width:20em' name="search" type="text" placeholder="Search..." required>
                    <select name="type">
                        <option selected="selected" disabled>Select an Option</option>
                        <option value="title">Title</option>
                        <option value="author">Author</option>
                        <option value="isbn">ISBN</option>
                    </select>
                    <input type="submit" value='Search'>
                </form>          
            </li>
            <%
                String isbn = request.getParameter("isbn");
                System.out.println(isbn);
                
                if ((Boolean) session.getAttribute("loggedIn") == null || (Boolean) session.getAttribute("loggedIn") == false) {
                    response.sendRedirect("../login.jsp");
                } else {
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px;\"><a href=\"" + request.getContextPath() + "/logout\">|&nbsp;&nbsp;&nbsp;&nbsp;Logout</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px;\"><a href=\"" + request.getContextPath() + "/wishlist\">|&nbsp;&nbsp;&nbsp;Wishlist</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"" + request.getContextPath() + "/jsp/Account.jsp\">" + session.getAttribute("userName") + "</a></li>");
                }
            %>
        </ul>

        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>

    <center> 			
	<h2>Delete Book</h2> 			
	<p style="padding-bottom:15px;">Clicking the button below will <span style="color:red;">permanently delete this book.</span></p> 			
	<form method="post" action="../removebook">
            <input type="hidden" name="isbn" id="isbn" value="<%=isbn%>">
            <input type="submit" value="Delete Book"/> 			
	</form> 			
    </center> 

    <%
        if (request.getAttribute("errorMessage") != null) {
            out.println("<br/><center><p>" + request.getAttribute("errorMessage") + "</p></center>");
        }
    %>
    <footer>
        <a href="${pageContext.request.contextPath}/about.jsp">About Us</a>
    </footer>
</body>
</html>
