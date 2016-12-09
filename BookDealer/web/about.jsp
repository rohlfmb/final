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
                    session.setAttribute("previousURL", "about.jsp");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"./login.jsp\">Login</a></li>");
                } else {
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"logout\">Logout</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"./jsp/Wishlist.jsp\">Wishlist</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"./jsp/Account.jsp\">Hello, " + session.getAttribute("userName") + "</a></li>");
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
                Placeholder.
            </p>
	</div>
	<div class="col span_1_of_4">
            <h2>Paige Campbell</h2>
            
            <p>
                Placeholder.
            </p>
	</div>
	<div class="col span_1_of_4">
            <h2>Brendon Guss</h2>
            
            <p>
                Placeholder.
            </p>
	</div>
	<div class="col span_1_of_4">
            <h2>Matthew Rohlf</h2>
            
            <p>
                Placeholder.
            </p>
	</div>
    </div>
    
    <footer>
        <a href="about.jsp">About Us</a>
    </footer>
  </body>
</html>
