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
        
        <p>
            User searched for <%=(String)request.getAttribute("search")%>
        </p>
        
        <p>
            Result set is <%
                ResultSet rs2;                
                rs2 = (ResultSet)request.getAttribute("rs");
                ResultSetMetaData rsmd = rs2.getMetaData();
                int col = rsmd.getColumnCount();
                
                while(rs2.next()) {
                    for(int ii = 1; ii <= col; ii++) {
                        if (ii > 1) {
                            out.print(", ");
                        }
                        
                        String colVal = rs2.getString(ii);
                        out.print(colVal);
                    }
                }
                
                rs2.close();
            %>
        </p>
        
        <footer>
            <a href="about.html">About</a>
        </footer>
    </body>
</html>