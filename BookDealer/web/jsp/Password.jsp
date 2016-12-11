<%-- 
    Document   : Password
    Created on : Dec 11, 2016, 3:15:07 AM
    Author     : rohlf
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/default.css"/>
        
        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
            .errmsg { 
                color: red;
                font-size: 12px;
            }
        </style>
        
        <script type="text/javascript">
            function validateForm() {
                var valid = true;
                
                // validate pass
                var pass    = get('pass').value;
                var cnfpass = get('cnfpass').value;
                get('passerr').innerHTML = '';
                if (!/^[!$?\-a-zA-Z0-9]*$/.test(pass)) {
                    valid = false;
                    get('passerr').innerHTML = '<p>Passwords can contain only a-z, A-Z, 0-9, \'!\', \'$\', and \'?\'.</p>'
                }
                else if (pass !== cnfpass){
                    valid = false;
                    get('passerr').innerHTML = '<p>The passwords you entered do not match.</p>';
                }
                else if (pass.length < 6) {
                    valid = false;
                    get('passerr').innerHTML = '<p>Passwords must be at least 6 characters long.</p>'
                }
                
                return valid;
            }
            
            // shortcut for accessing DOM elements by id
            function get(id) {
                return document.getElementById(id);
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
                    response.sendRedirect("../login.jsp");
                } else {
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
        <br/>
        
        <center><h2>Change Password</h2>            
            <form method="post" action="../password"
                  id="passForm" onsubmit="return validateForm()">
                <p> 
                    <label>Password: <br />
                        <input type="password" id="pass" name="pass" size="30" required="required" onchange="this.value = this.value.trim()" />
                    </label>
                </p>

                <p style="padding-bottom: 10px;"> 
                    <label>Confirm Password: <br />
                        <input type="password" id="cnfpass" name="cnfpass" size="30" required="required" onchange="this.value = this.value.trim()"/>
                    </label>
                    <span id="passerr" class="errmsg"> </span>
                </p>

                <p> 
                    <span style="padding-left: 13px;">
                        <input type="submit" name="send" value="Submit" id="submit" />
                    </span>
                </p>
            </form>
        </center>

        <footer>
            <a href="../about.jsp">About Us</a>
        </footer>
    </body>
</html>
