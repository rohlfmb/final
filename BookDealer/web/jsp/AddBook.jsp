<%-- 
    Document   : Product
    Created on : Dec 5, 2016, 10:04:04 PM
    Author     : rohlf
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="bookdeals.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Book</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/default.css"/>

        <style>
            @import url('https://fonts.googleapis.com/css?family=Raleway:300,400,700');
        </style>
        
        <script type="text/javascript">
            function clearForm() {
                if (confirm('Are you sure you want to clear the submission form?')) {
                    get('reg').reset();
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
                if ((Boolean)session.getAttribute("admin") == null || !(Boolean)session.getAttribute("admin")) {
                    response.sendRedirect("../home.jsp");
                }  
                else if ((Boolean) session.getAttribute("loggedIn") == null || (Boolean) session.getAttribute("loggedIn") == false) {
                    out.println("<li style=\"float:right; padding-top: 15px; padding-right: 15px\"><a href=\"../login.jsp\">Login</a></li>");
                }                
                else {
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
        
        <center><h2>Add Book</h2>
            <form method="post" action="../addbook" id="reg">
                <div class="section group">
                    <div class="col span_1_of_2">
                        <p> 
                            <label><b>Title:</b><br />
                                <input type="text" id="title" name="title" size="30" required="required" onchange="this.value = this.value.trim()" />
                            </label>
                        </p>

                        <p> 
                            <label><b>Author:</b> <br />
                                <input type="text" id="author" name="author" size="30" required="required" onchange="this.value = this.value.trim()" />
                            </label>
                        </p>

                        <p>
                            <label><b>Year:</b> <br />
                                <input type="text" id="year" name="year" size="30" required="required" onchange="this.value = this.value.trim()" />
                            </label>
                            <span id="yearerr" class="errmsg"> </span>
                        </p>

                        <p>
                            <label><b>ISBN:</b> <br />
                                <input type="text" id="isbn" name="isbn" size="30" required="required" onchange="this.value = this.value.trim() "/>
                            </label>
                        </p>
                        
                        <br/>
                        <br/>
                        <br/>

                        <p>
                            <label><b>Amazon Price:</b> <br />
                                <input type="text" id="amPrice" name="amPrice" size="30" required="required" onchange="this.value = this.value.trim()"/>
                            </label>
                        </p>
                        
                        <p>
                            <label><b>Books-A-Million Price:</b> <br />
                                <input type="text" id="bmPrice" name="bmPrice" size="30" required="required" onchange="this.value = this.value.trim()"/>
                            </label>
                        </p>
                    </div>

                    <div class="col span_1_of_2">
                        <p>
                            <label><b>Publisher:</b> <br />
                                <input type="text" id="publisher" name="publisher" size="30" required="required" onchange="this.value = this.value.trim()" />
                            </label>
                        </p>

                        <p>
                            <label><b>Genre:</b> <br />
                                <input type="text" id="genre" name="genre" size="30" required="required" onchange="this.value = this.value.trim()" />
                            </label>
                        </p>

                        <p>
                            <label><b>Hardcover or Paperback:</b><br />
                                <input type="text" id="type" name="type" maxlength="12" size="30" onchange="this.value = this.value.trim()" />
                            </label>
                        </p>

                        <p>
                            <label><b>Description:</b> <br />
                                <textarea style="padding-bottom: 10px; background-color: #F9F9F9; resize: none; border: 1px solid #242228;" id="description" name="description" cols="27" rows="5"></textarea>
                            </label>
                        </p>
                        
                        <p>
                            <label><b>Barnes & Noble Price:</b> <br />
                                <input type="text" id="bnPrice" name="bnPrice" maxlength="12" size="30" onchange="this.value = this.value.trim()" />
                            </label>
                        </p>
                        
                        <p>
                            <label><b>Walmart Price:</b> <br />
                                <input type="text" id="wmPrice" name="wmPrice" maxlength="12" size="30" onchange="this.value = this.value.trim()" />
                            </label>
                        </p>

                        <p> 
                            <br />
                            <input type="submit" name="send" value="Submit" id="submit" />
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" value="Clear Form" id="clear" onclick="clearForm()"/>
                        </p>
                    </div>
                </div>
            </form>
        </center>

        <footer>
            <a href="../about.jsp">About Us</a>
        </footer>
    </body>
</html>