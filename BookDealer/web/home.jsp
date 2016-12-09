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
                    session.setAttribute("previousURL", "./home.jsp");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"./login.jsp\">Login</a></li>");
                } else {    
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"logout\">Logout</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"./jsp/Wishlist.jsp\">Wishlist</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"./jsp/Account.jsp\">Hello, " + session.getAttribute("userName") + "</a></li>");
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
            <a href="about.jsp">About Us</a>
        </footer>
    </body>
</html>
