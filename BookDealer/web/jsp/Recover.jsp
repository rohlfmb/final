<%-- 
    Document   : Recover
    Created on : Dec 7, 2016, 1:03:48 AM
    Author     : rohlf
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bookdeals.Book"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recover Password</title>
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
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"wishlist\">Wishlist</a></li>");
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
//            String userName = (String)session.getAttribute("userName");
//
//            // SQL Stuff...
//            Connection conn = null;
//            ResultSet rs = null;
//            ArrayList<Book> books = new ArrayList();
//            String phNum = "";
//
//            try {
//                Class.forName("com.mysql.jdbc.Driver");
//
//                conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");
//
//                String sql = "SELECT * FROM Users WHERE username=\"" + userName + "\";";
//                PreparedStatement ps = conn.prepareStatement(sql);
//                
//                rs = ps.executeQuery();
//                
//                rs.next();
//                phNum = rs.getString("phone_num");                
//                
//                rs.close();
//            }
//            catch(Exception e) {
//                System.out.println("in recover.jsp servlet");
//                System.out.println("Error for: " + e.getLocalizedMessage());
//            }
            
        %>
        
        <center>
            <h2>Recover Password</h2>
            
            <form id="recoverForm" action="login" method="post" >   
                
                <div class="section group">
                    <div class="col span_1_of_2">
                        <p>
                            <label>Username: 
                                <input type="text" name="username">
                            </label>
                        </p>
                    </div>

                    <div class="col span_1_of_2">
                        <p>
                            <input type="radio" name="recovery" >Email
                            <br/>
                            <input type="radio" name="recovery" <% 
                                    if(false) {//phNum.equals("111-111-1111")) {
                                        %> disabled>Phone Number<%
                                    }
                                    else{
                                        %> >Phone Number<%
                                    }
                                    %>
                        </p>
                    </div>
                </div>
                <input type="submit" value="Recover Password">
            </form>
        </center>

        <footer>
            <a href="../about.jsp">About Us</a>
        </footer>
    </body>
</html>
