<%-- 
    Document   : Registration
    Created on : Dec 5, 2016, 9:18:13 PM
    Author     : andre2rm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../default.css"/>
        <title>JSP Page</title>
        
        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
    </head>
    <body>
        <ul>
        <li>
            <a href="home.html">
                <img src="../logo.png" alt="Logo" style="max-width:150px"/></li>
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
        
        </ul><h1>Register</h1>
        
        <form action="register" method="post" id="reg">
            <p><label>Name: </label><input type="text" name="name"></p>
            <p><label>Email Address: </label><input type="text" name="email"></p>
            <p><label>Username: </label><input type="text" name="username"></p>
            <p><label>Password: </label><input type="text" name="password"></p>
            <p><label>Confirm Password: </label><input type="text" name="confirm"></p>
            <p><label>Phone Number: </label><input type="text" name="phone"></p>
            <p><label>Country: </label>
                <select name="country">
                    <option value="canada">Canada</option>
                    <option value="france">France</option>
                    <option value="germany">Germany</option>
                    <option value="spain">Spain</option>
                    <option value="usa">United States</option>
                </select>
            </p><br>
            <p><button type="text" value="text">Submit</button></p>
        </form>
        
        <footer>
            <a href="about.html">About</a>
        </footer>
    </body>
</html>
