<%-- 
    Document   : Results
    Created on : Dec 5, 2016, 9:18:25 PM
    Author     : rohlf
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Results</title>
        <link rel="stylesheet" type="text/css" href="default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
    </head>
    <body>
        <ul>
            <li>
                <a href="home.html">
                    <img src="logo.png" alt="Logo" style="max-width:150px"/></li>
                </a>          
            <li>
              <form method="post" action="search">
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
            <li style="float:right; padding-top: 15px; padding-right: 15px"><a href="account.html">Account</a></li>
        </ul>
        
        <br>
        <br>
        <br>
        <br>
        <br>
        
        <table>            
            <%
                ResultSet rs2;                
                rs2 = (ResultSet)request.getAttribute("rs");
                ResultSetMetaData rsmd = rs2.getMetaData();
                int col = rsmd.getColumnCount();

                while(rs2.next()) {
                    %> <tr> <%
                    for(int ii = 1; ii <= col; ii++) {
                        if (ii > 1) {
                            out.print(", ");
                        }
                    %> <td> <p> <%
                        out.print(rs2.getString(ii));
                    %> </p> </td> <%
                    }
                    %> </tr> <%
                }

                rs2.close();
            %>
        </table>
        
        <footer>
            <a href="about.html">About</a>
        </footer>
    </body>
</html>