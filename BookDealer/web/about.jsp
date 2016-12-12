<!DOCTYPE HTML>

<html>
    <head>
        <title>About Book Deals</title>
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
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"" + request.getContextPath() + "/login.jsp\">Login</a></li>");
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

        <p style="text-align: center; font-weight: bold; font-size: 36px;">
            The BookDeals Team
        </p>

        <hr>

        <div class="section group" align="center">
            <div class="col span_1_of_4">              
                <h2>Rebecca Andrews</h2>

                <p>
                    Rebecca is a Senior Computer Science major at JMU and is pursuing a career in software development.
                    She has most recently worked at NASA where she maintained their WordPress sites.
                </p>
            </div>
            <div class="col span_1_of_4">
                <h2>Paige Campbell</h2>

                <p>
                    Paige is a Senior Computer Science major at JMU. She likes working on the backend of projects
                    with databases. She has worked with Northrop Grumman in the past and helped maintain their databases.
                </p>
            </div>
            <div class="col span_1_of_4">
                <h2>Brendon Guss</h2>

                <p>
                    Brendon is a Senior Computer Science major at JMU. He also enjoys working on the backend of projects.
                    He currently works at the JMU IT Help Desk.
                </p>
            </div>
            <div class="col span_1_of_4">
                <h2>Matt Rohlf</h2>

                <p style="padding-right: 15px;">
                    Matt is a Senior Computer Science major at JMU. He likes working mainly on the front-end of projects
                    and helps connect them to the backend. He is currently an intern at Axon, AI in Harrisonburg.
                </p>
            </div>
        </div>

        <footer>
            <a href="${pageContext.request.contextPath}/about.jsp">About Us</a>
        </footer>
    </body>
</html>
