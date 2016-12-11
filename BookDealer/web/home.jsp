<!DOCTYPE HTML>

<html>
    <head>
        <title>Book Deals</title>
        <link rel="stylesheet" type="text/css" href="home.css"/>

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
            </li>
            <%
                if ((Boolean) session.getAttribute("loggedIn") == null || (Boolean) session.getAttribute("loggedIn") == false) {
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"" + request.getContextPath() + "/login.jsp\">Login</a></li>");
                } else {
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px;\"><a href=\"" + request.getContextPath() + "/logout\">|&nbsp;&nbsp;&nbsp;&nbsp;Logout</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px;\"><a href=\"" + request.getContextPath() + "/wishlist\">|&nbsp;&nbsp;&nbsp;Wishlist</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"" + request.getContextPath() + "/jsp/Account.jsp\">" + session.getAttribute("userName") + "</a></li>");
                }
            %>
        </ul>

        <form method="post" action="search">
            <input style='width:20em' name="search" type="text" placeholder="Search..." required>
            <select name="type" required required>
                <option selected="selected" disabled>Select an Option</option>
                <option value="title">Title</option>
                <option value="author">Author</option>
                <option value="isbn">ISBN</option>
            </select>
            <input type="submit" value='Search'>
        </form>
        
        <br/>
        <br/>
        <br/>
        
        <p style="text-align: center;">
            BookDeals is a website made to help you find the cheapest price for any book you want to find.
        </p>
        
        <footer>
            <a href="${pageContext.request.contextPath}/about.jsp">About Us</a>
        </footer>
    </body>
</html>
