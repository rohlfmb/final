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
        <title>Edit Product Information</title>
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
                if ((Boolean)session.getAttribute("admin") == null || !(Boolean)session.getAttribute("admin")) {
                    response.sendRedirect("../home.jsp");
                }  
                else if ((Boolean) session.getAttribute("loggedIn") == null || (Boolean) session.getAttribute("loggedIn") == false) {
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"../login.jsp\">Login</a></li>");
                }                
                else {
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px;\"><a href=\"../logout\">|&nbsp;&nbsp;&nbsp;&nbsp;Logout</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px;\"><a href=\"../wishlist\">|&nbsp;&nbsp;&nbsp;Wishlist</a></li>");
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"Account.jsp\">" + session.getAttribute("userName") + "</a></li>");
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
            <form action="../updatebook" id="uBook">
                <p>
                    <label><b>Author:</b><br/>
                        <input type="text" name="author" id="author" value="<%=book.getAuthor()%>">
                    </label>
                </p>
                <p>
                    <label>Genre:<br/>
                        <input type="text" name="genre" id="genre" value="<%=book.getGenre()%>">
                    </label>
                </p>
                <p>
                    <label>Year Published:<br/>
                        <input type="text" name="year" id="year" value="<%=book.getYear()%>" size="3">
                    </label>
                </p>
                <p><b>Description:</b></p>
                    <textarea id="description" name="description" style="resize: none;" cols="65" rows="2"></textarea>
                    <script>
                        document.getElementById("description").innerHTML="<%=book.getDescription()%>";
                    </script>  
                <input type="hidden" name="isbn" id="isbn" value="<%=book.getIsbn()%>">
                <p> <b>ISBN:</b> <%=book.getIsbn()%> </p>
                <input type="submit" name="send" value="Edit Book Information" id="submit" />
            </form>
            

        </div>

        <div class="section group" align="center" style="width: 900px; padding-left: 15px; padding-right: 15px; padding-top: 30px;
             display: block; margin-left: auto; margin-right: auto;">
            <div class="col span_1_of_4">
                <h2>Amazon</h2>

                <%                    if (amPrice
                            == -1) {
                %> <p> Price Not Available </p> <%
                } else if (amPrice == lowest) {
                %> <p style="font-weight: bold; color: #69B578"> $<%=df.format(amPrice)%> </p> <%
                } else {
                %> <p> $<%=df.format(amPrice)%> </p> <%
                    }
                %>
            </div>
            <div class="col span_1_of_4">
                <h2>Barnes & Noble</h2>

                <%
                    if (bnPrice
                            == -1) {
                %> <p> Price Not Available </p> <%
                } else if (bnPrice == lowest) {
                %> <p style="font-weight: bold; color: #69B578"> $<%=df.format(bnPrice)%> </p> <%
                } else {
                %> <p> $<%=df.format(bnPrice)%> </p> <%
                    }
                %>
            </div>
            <div class="col span_1_of_4">
                <h2>Books-A-Million</h2>

                <%
                    if (bmPrice
                            == -1) {
                %> <p> Price Not Available </p> <%
                } else if (bmPrice == lowest) {
                %> <p style="font-weight: bold; color: #69B578"> $<%=df.format(bmPrice)%> </p> <%
                } else {
                %> <p> $<%=df.format(bmPrice)%> </p> <%
                    }
                %>
            </div>
            <div class="col span_1_of_4">
                <h2>WalMart</h2>

                <%
                    if (wmPrice
                            == -1) {
                %> <p> Price Not Available </p> <%
                } else if (wmPrice == lowest) {
                %> <p style="font-weight: bold; color: #69B578"> $<%=df.format(wmPrice)%> </p> <%
                } else {
                %> <p> $<%=df.format(wmPrice)%> </p> <%
                    }
                %>
            </div>
        </div>

        <footer>
            <a href="../about.jsp">About Us</a>
        </footer>
    </body>
</html>