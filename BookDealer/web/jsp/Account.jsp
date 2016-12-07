<%-- 
    Document   : Account
    Created on : Dec 7, 2016, 1:03:48 AM
    Author     : rohlf
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account</title>
        <link rel="stylesheet" type="text/css" href="../default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
    </head>
    <body>
        <ul>
            <li>
                <a href="../home.html">
                    <img src="../logo.png" alt="Logo" style="max-width:150px"/>
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
            <li style="float:right; padding-top: 15px; padding-right: 15px"><a href="Account.jsp">Account</a></li>
        </ul>
        
        <footer>
            <a href="../about.html">About</a>
        </footer>
    </body>
</html>
