<!--
This servlet allows an admin user to change the user role of another user to
elevate theor access to admin or demote them to a user.
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
  <br>
  <br>
  <body>
    <nav class="topright">
      <a href="Admin.jsp">Dashboard&nbsp;</a>
      <a href="home.jsp">Logout&nbsp;</a>
    </nav>

    <!-- SQL Connection used for the role dropdownbox values. -->

    <%
       Connection con= null;
       PreparedStatement ps = null;
       ResultSet rs = null;

       String driverName = "com.mysql.jdbc.Driver";
       String url = "jdbc:mysql://localhost:3306/CITIZEN";
       String user = "dbadmin";
       String password = "db123";

       String sql = "select * from User";

       try {
       Class.forName(driverName);
       con = DriverManager.getConnection(url, user, password);
       ps = con.prepareStatement(sql);
       rs = ps.executeQuery();
       %>

      <!-- Form that stores username, and desired role -->

      <form method="post" action="roleUpdate.jsp">
        <center>
          <h1>Change User Role</h1>
          User:
          <select name="userEmail">
            <option value="select">select</option>
            <%
               while(rs.next())
               {
               String userEmail = rs.getString("userEmail");
               %>
              <option value=<%=userEmail%>><%=userEmail%></option>
              <%
                }
              }
                 catch(SQLException sqe)
                 {
                 out.println("home"+sqe);
                 }
                 %>
            </select>
              Role:
              <select name="role" id="role">
                <option value="select">select</option>
                <option value="admin">admin</option>
                <option value="user">user</option>
                <input type="submit" value="Submit"/>
          </center>
       </form>
  </body>
</html>
