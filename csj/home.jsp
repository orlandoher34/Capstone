<!--
This Servlet serves as the default landing page of this web application and is used to collect user info
for login authentication.
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <center><img src="telecom.png" alt="Citizen INC." width="128" height="128"></center>
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="stylesheet.css">
  </head>
  
  <h1 ALIGN="CENTER">Citizen Inc. Room Scheduler</h1>
  
  <br>
  <br>
  <body>

<!-- SQL Connection used for the role dropdownbox values. -->

    <%
     Connection con= null;
     PreparedStatement ps = null;
     ResultSet rs = null;

     String driverName = "com.mysql.jdbc.Driver";
     String url = "jdbc:mysql://localhost:3306/CITIZEN";
     String user = "dbadmin";
     String password = "db123";

     String sql = "select distinct role from User";

     try {
        Class.forName(driverName);
        con = DriverManager.getConnection(url, user, password);
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery(); 
     %>

<!-- Form that stores username, password and role -->

      <form method="post" action="login.jsp">
        <center>
          <table border="1" cellpadding="3" cellspacing="2">
            <thead>
              <tr>
                <th colspan="2">Login Here</th>
              </tr>
            </thead>
            <tr>
              <td>Username:</td>
              <td><input type="text" name="userEmail"/></td>
            </tr>
            <tr>
              <td>Password:</td>
              <td><input type="password" name="userPassword"/></td>
            </tr>
            <tr>
              <td>Role:</td>
              <td><select name="role">
                <option value="select">select</option>
                <%
                   while(rs.next())
                   {
                   String role = rs.getString("role");
                   %>
                  <option value=<%=role%>><%=role%></option>
                  <% 
                     }
                     }
                     catch(SQLException sqe)
                     {
                     out.println("home"+sqe);
                     }
                     %>
                    </select>
                  </td>
                </tr>
                <tr>

                  <td colspan="2" align="center"><input type="submit" value="Login"/></td>
          </table>
            </center>
          </form>
        </body>
      </html>
