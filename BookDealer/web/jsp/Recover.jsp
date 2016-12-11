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
        </ul>
        
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        
        <center>
            <h2>Recover Password</h2>
        </center>
        <form id="recoverForm" action="../sent.html" method="post" >   

            <div class="section group">
                <div class="col span_1_of_2">
                    <p>
                        <label>Username: </label>
                    </p>
                    <p>
                        <label>Recovery Method: </label>
                    </p>
                </div>

                <div class="col span_1_of_2">
                    <p><input type="text" name="username"></p>
                    <p style="padding-top:8px; padding-bottom:12px;">
                        <input type="radio" name="recovery" >Email
                        <br />
                        <input type="radio" name="recovery" 
                        <% 
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
            <center><input type="submit" value="Recover Password"></center>
        </form>

        <footer>
            <a href="../about.jsp">About Us</a>
        </footer>
    </body>
</html>
