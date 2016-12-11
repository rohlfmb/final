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
                <form id="search" method="post" action="search">
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
        <br/>
        <br/>
        <br/>
        
        <center>
            <form id="loginForm" action="login" method="post">
                <p>
                    <label>Username:
                        <input type="text" size="30" name="username" required>
                    </label>                    
                </p>
                
                <p style="padding-bottom:10px">
                    <label>Password:
                        <input type="password" name="password" required>
                    </label>
                </p>
                
                <input type="submit" value="Login">
                <br />&nbsp;
            </form>
        </center>
        <br />
        <center>
            <div class="section group">
                <div class="col span_1_of_4">&nbsp;</div>
                <div class="col span_2_of_4">
                    <form action="./register.html">
                        <input type="submit" value="Register" style="margin-top: 15px; float: left; margin-left: 100px">
                    </form>
                    <form action="./jsp/Recover.jsp">
                        <input type="submit" value="Recover Password" style="margin-top: 15px; float: right; margin-right: 100px">
                    </form>
                </div>
                <div class="col span_1_of_4">&nbsp;</div>
        </center>
    
        <%
            if (request.getAttribute("errorMessage") != null)
            {
                out.println("<br/><center><p>" + request.getAttribute("errorMessage") + "</p></center>");
            }
        %>
        <footer>
            <a href="about.jsp">About Us</a>
        </footer>
    </body>
</html>
