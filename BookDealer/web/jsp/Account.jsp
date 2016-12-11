<%-- 
    Document   : Account
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
        <title>Account</title>
        <link rel="stylesheet" type="text/css" href="../default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
            .errmsg { 
                color: red;
                font-size: 12px;
            }
        </style>
        
        <script type="text/javascript">
            // Set Up AJAX
            var request;
            window.onload = function() {
                try { // Firefox, Opera, IE7
                    request = new XMLHttpRequest();
                }
                catch (e) {
                    try { // IE6
                        request = new ActiveXObject('MSXML2.XMLHTTP.5.0');
                    }
                    catch (e) {
                        request = false;
                    }
                }
                if (!request)
                    alert('Ajax setup failed');
            };
            
            // Process AJAX for userid
            function userAjax(value) {
                var url = 'checkuser?id=' + value;
                request.open('GET', url, true);
                request.onreadystatechange = updateUser;
                request.send(null);
            }

            // validate form data
            function validateForm() {
                var valid = true;
                
                // validate name
                var firstname = get('firstname').value;
                get('firsterr').innerHTML = '';
                if (!/^[\-. a-zA-Z]*$/.test(firstname)) {
                    valid = false;
                    get('firsterr').innerHTML = '<p>Name can contain only a-z, A-Z, space, period, and hyphen.</p>'
                }
                
                // validate name
                var lastname = get('lastname').value;
                get('lasterr').innerHTML = '';
                if (!/^[\-. a-zA-Z]*$/.test(lastname)) {
                    valid = false;
                    get('lasterr').innerHTML = '<p>Name can contain only a-z, A-Z, space, period, and hyphen.</p>'
                }
                
                // validate email and cnfmamil
                var email   = get('email').value;
                var cnfmail = get('cnfmail').value;
                get('emailerr').innerHTML = '';
                if (!/^[.@\-a-zA-Z0-9]*$/.test(email)) {
                    valid = false;
                    get('emailerr').innerHTML = '<p>Email address can contain only a-z, A-Z, 0-9, period, and @.</p>'
                }
                else if (email != cnfmail) {
                    valid = false;
                    get('emailerr').innerHTML = '<p>The email addresses you entered do not match.</p>'
                }
                
                // validate user
                var user = get('user').value;
                get('usererr').innerHTML = '';
                if (!/^[\-_a-zA-Z0-9]*$/.test(user)) {
                    valid = false;
                    get('usererr').innerHTML = '<p>Username can contain only a-z, A-Z, 0-9, underscore, and hyphen.</p>'
                }
                if ((get('user').style.color) == "red") {
                    valid = false
                    get ('usererr').innerHTML = '<p>That username is already in use.</p>';
                }
                
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
                
                // validate phone
                var phone = get('phone').value;
                get('phoneerr').innerHTML = '';
                if (phone === null) {
                    phone = '111-111-1111';
                }
                else if (!/^[0-9]{3}\-[0-9]{3}\-[0-9]{4}$/.test(phone)) {
                    valid = false;
                    get('phoneerr').innerHTML = '<p>Phone numbers must match the format \'xxx-xxx-xxxx\'.</p>';
                }
                
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
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"Account.jsp\">Hello, " + session.getAttribute("userName") + "</a></li>");
                }
            %>
        </ul>
        
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        
        <%
            String userName = (String)session.getAttribute("userName");

            // SQL Stuff...
            Connection conn = null;
            ResultSet rs = null;
            ArrayList<Book> books = new ArrayList();
            String fName = "";
            String lName = "";
            String email = "";
            String phNum = "";

            try {
                Class.forName("com.mysql.jdbc.Driver");

                conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");

                String sql = "SELECT * FROM Users WHERE username=\"" + userName + "\";";
                PreparedStatement ps = conn.prepareStatement(sql);
                
                rs = ps.executeQuery();
                
                rs.next();
                fName = rs.getString("first_name");
                lName = rs.getString("last_name");
                email = rs.getString("email");
                phNum = rs.getString("phone_num");                
                if(phNum.equals("111-111-1111")) {
                    phNum = "";
                }
                
                rs.close();
            }
            catch(Exception e) {
                System.out.println("Error for: " + e.getLocalizedMessage());
            }
            
        %>
        
        <center><h2>Account Information</h2>
            
        <form method="post" action="updateAccount"
              id="reg" onsubmit="return validateForm()">

            <div class="section group">
                <div class="col span_1_of_2">
                    <p> 
                        <label>First Name: <br />
                            <input type="text" id="firstname" name="firstname" size="30" required="required" onchange="this.value = this.value.trim()" value="<%=fName%>" />
                        </label>
                        <span id="firsterr" class="errmsg"> </span>
                    </p>
                    
                    <p> 
                        <label>Last Name: <br />
                            <input type="text" id="lastname" name="lastname" size="30" required="required" onchange="this.value = this.value.trim()" value ="<%=lName%>"/>
                        </label>
                        <span id="lasterr" class="errmsg"> </span>
                    </p>
                    
                    <p>
                        <label>Country: <br />
                            <select id="country" name="country" required="required" >
                                <option selected disabled hidden>Select a Country</option>
                                <option value="canada">Canada</option>
                                <option value="france">France</option>
                                <option value="germany">Germany</option>
                                <option value="spain">Spain</option>
                                <option value="usa">United States</option>
                            </select>
                        </label>
                        <span id="countryerr" class="errmsg"> </span>
                    </p>
                </div>

                <div class="col span_1_of_2">
                    <p>
                        <label>Email Address: <br />
                            <input type="email" id="email" name="email" size="30" required="required" onchange="this.value = this.value.trim()" value="<%=email%>"/>
                        </label>
                    </p>

                    <p>
                        <label>Confirm Email Address: <br />
                            <input type="email" id="cnfmail" name="cnfmail" size="30" required="required" onchange="this.value = this.value.trim()" />
                        </label>
                        <span id="emailerr" class="errmsg"> </span>
                    </p>

                    <p>
                        <label>Phone Number: (USA only)<br />
                            <input type="text" id="phone" name="phone" maxlength="12" size="30" onchange="this.value = this.value.trim()" value="<%=phNum%>"/>
                        </label>
                        <span id="phoneerr" class="errmsg"> </span>
                    </p>

                    

                    
                </div>
            </div>
                        
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
