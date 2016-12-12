<%-- 
    Document   : Product
    Created on : Dec 5, 2016, 10:04:04 PM
    Author     : rohlf
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
        
        <script>
            function confirmDelete() {
                if(window.confirm("Are you sure you want to delete this book from the database?" + getParameterByName(""))) {
                    window.open("../home.jsp", "_self")
                }        
            }
        </script>
    </head>
    <body>
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/home.jsp">
                    <img src="${pageContext.request.contextPath}/logo.png" alt="Logo" style="max-width:150px"/>
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
        <%
            Connection conn = null;
            ResultSet bookRS = null;
            ResultSet priceRS = null;
            Book book = new Book();
            double amPrice = 0;
            double bnPrice = 0;
            double bmPrice = 0;
            double wmPrice = 0;
            DecimalFormat df = new DecimalFormat("#0.00");

            try {
                Class.forName("com.mysql.jdbc.Driver");

                conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");

                String bookSQL = "SELECT title, author, genre, year, description, isbn FROM Books WHERE isbn LIKE ?";
                PreparedStatement bookPS = conn.prepareStatement(bookSQL);
                bookPS.setString(1, request.getParameter("isbn"));
                bookRS = bookPS.executeQuery();

                String priceSQL = "SELECT vendor_id, price FROM Prices WHERE isbn = \"" + request.getParameter("isbn") + "\"";
                PreparedStatement pricePS = conn.prepareStatement(priceSQL);
                priceRS = pricePS.executeQuery();

                while (bookRS.next()) {
                    book.title = bookRS.getString("title");
                    book.author = bookRS.getString("author");
                    book.genre = bookRS.getString("genre");
                    book.year = bookRS.getInt("year");
                    book.description = bookRS.getString("description");
                    book.isbn = bookRS.getString("isbn");
                }

                priceRS.absolute(1);
                amPrice = priceRS.getDouble("price");
                priceRS.next();
                bnPrice = priceRS.getDouble("price");
                priceRS.next();
                bmPrice = priceRS.getDouble("price");
                priceRS.next();
                wmPrice = priceRS.getDouble("price");
            } catch (ClassNotFoundException | SQLException e) {
                System.out.println("Cause is " + e.toString());
            } finally {
                bookRS.close();
                priceRS.close();
                conn.close();
            }

            double prices[] = {amPrice, bnPrice, bmPrice, wmPrice};
            double lowest = 0.0;

            for (int ii = 0; ii < 4; ii++) {
                if (ii == 0 && prices[ii] != -1) {
                    lowest = amPrice;
                } else {
                    if (prices[ii] < lowest && prices[ii] != -1) {
                        lowest = prices[ii];
                    }
                }
            }
        %> 

        <div class="product">
            <img src="${pageContext.request.contextPath}/img/<%=book.getIsbn()%>.jpg" alt="Book Cover"/>      
            <h2> <%=book.getTitle()%> </h2>
            <hr/>
            <p> <b>Author:</b> <%=book.getAuthor()%></p>            
            <p> <b>Genre:</b> <%=book.getGenre()%> </p>
            <p> <b>Year Published:</b> <%=book.getYear()%> </p>
            <p> <b>Description:</b> <%=book.getDescription()%> </p>
            <p> <b>ISBN:</b> <%=book.getIsbn()%> </p>

            <%
                ArrayList<Book> wishList = new ArrayList();
                wishList = (ArrayList<Book>) session.getAttribute("wishList");

                if (((Boolean) session.getAttribute("loggedIn") == null || (Boolean) session.getAttribute("loggedIn") == false) || wishList == null || Book.containsBook(wishList, book.getIsbn())) {
                } else {
                    out.println("<form action=\"../wishlistupdate\" method=\"post\"><button name=\"wishlistupdate\" value=\"" + book.getIsbn() + "\">Add to Wishlist</button></form>");
                }

                if (((Boolean) session.getAttribute("loggedIn") == null || (Boolean) session.getAttribute("loggedIn") == false)) {
                } else if (wishList == null || Book.containsBook(wishList, book.getIsbn())) {
                    out.println("<form action=\"../wishlistremove\" method=\"post\"><button name=\"wishlistremove\" value=\"" + book.getIsbn() + "\">Remove from Wishlist</button></form>");
                }
                
                if ((Boolean)session.getAttribute("admin") != null && (Boolean)session.getAttribute("admin")) {
                    out.println("<br/><form action=\"" + request.getContextPath() + "/jsp/EditBook.jsp?isbn=" + book.getIsbn() + "\" method=\"post\"><button name=\"editbook\" value=\"" + book.getIsbn() + "\">Edit Book</button></form><br/>");
                    out.println("<form action=\"" + request.getContextPath() + "/jsp/DeleteBook.jsp?isbn=" + book.getIsbn() + "\" method=\"post\"><button name=\"editbook\">Remove Book</button></form>");
                } 
            %>

        </div>

        <div class="section group" align="center" style="width: 900px; padding-left: 15px; padding-right: 15px; padding-top: 30px;
             display: block; margin-left: auto; margin-right: auto;">
            <div class="col span_1_of_4">
                <h2>Amazon</h2>
                <hr>
                <%                    if (amPrice
                            == -1) {
                %> <p> Price Not Available </p> <%
                } else if (amPrice == lowest) {
                %> <h2 style="font-weight: bold; color: #69B578"> $<%=df.format(amPrice)%> </h2> <%
                } else {
                %> <h2> $<%=df.format(amPrice)%> </h2> <%
                    }
                %>
            </div>
            <div class="col span_1_of_4">
                <h2>Barnes & Noble</h2>
                <hr>
                <%
                    if (bnPrice
                            == -1) {
                %> <p> Price Not Available </p> <%
                } else if (bnPrice == lowest) {
                %> <h2 style="font-weight: bold; color: #69B578"> $<%=df.format(bnPrice)%> </h2> <%
                } else {
                %> <h2> $<%=df.format(bnPrice)%> </h2> <%
                    }
                %>
            </div>
            <div class="col span_1_of_4">
                <h2>Books-A-Million</h2>
                <hr>
                <%
                    if (bmPrice
                            == -1) {
                %> <p> Price Not Available </p> <%
                } else if (bmPrice == lowest) {
                %> <h2 style="font-weight: bold; color: #69B578"> $<%=df.format(bmPrice)%> </h2> <%
                } else {
                %> <h2> $<%=df.format(bmPrice)%> </h2> <%
                    }
                %>
            </div>
            <div class="col span_1_of_4">
                <h2>WalMart</h2>
                <hr>
                <%
                    if (wmPrice
                            == -1) {
                %> <p> Price Not Available </p> <%
                } else if (wmPrice == lowest) {
                %> <h2 style="font-weight: bold; color: #69B578"> $<%=df.format(wmPrice)%> </h2> <%
                } else {
                %> <h2> $<%=df.format(wmPrice)%> </h2> <%
                    }
                %>
            </div>
        </div>

        <footer>
            <a href="${pageContext.request.contextPath}/about.jsp">About Us</a>
        </footer>
    </body>
</html>