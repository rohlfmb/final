<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

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
                    <select name="type">
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

        <form action="login" method="post" id="loginForm">
            <input type="text" name="username"><br>
            <input type="password" name="password"><br>
            <input type="submit" value="Login">
        </form>
        <%
            if (request.getAttribute("errorMessage") != null)
            {
                out.println("<p>" + request.getAttribute("errorMessage") + "</p>");
            }
        %>
        <footer>
            <a href="about.jsp">About Us</a>
        </footer>
    </body>
</html>