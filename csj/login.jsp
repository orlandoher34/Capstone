<!--
This servlet collects the user info input on the home page and 
validates the input against the user database. It then redirects the user to the appropriate page or calls the error servlet.
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Login</title>
  </head>
  <body>

    <!-- Create db connection variables -->

    <%! String userdbName;
        String userdbPsw;
        String dbUsertype;
        %>

      <!-- Connect to db, load values from home page, and set sql statement. -->

      <%
         Connection con= null;
         PreparedStatement ps = null;
         ResultSet rs = null;
         
         String driverName = "com.mysql.jdbc.Driver";
         String url = "jdbc:mysql://localhost:3306/CITIZEN";
         String user = "dbadmin";
         String dbpsw = "db123";
         
         String sql = "select * from User where userEmail=? and userPassword=? and role=?";
         
         String userEmail = request.getParameter("userEmail");
         String userPassword = request.getParameter("userPassword");
         String role = request.getParameter("role");

      /** If statement to authenticate credentials and redirect to appropriate page based on role. */

         if((!(userEmail.equals(null) || userEmail.equals("")) && !(userPassword.equals(null) || userPassword.equals(""))) && !role.equals("select"))
         {

          try{
              Class.forName(driverName);
              con = DriverManager.getConnection(url, user, dbpsw);
              ps = con.prepareStatement(sql);
              ps.setString(1, userEmail);
              ps.setString(2, userPassword);
              ps.setString(3, role);
              rs = ps.executeQuery();
          if(rs.next()) {
              userdbName = rs.getString("userEmail");
              userdbPsw = rs.getString("userPassword");
              dbUsertype = rs.getString("role");

      /** Redirect successfull Admin login */

         if(userEmail.equals(userdbName) && userPassword.equals(userdbPsw) && role.equals("admin"))  {
              session.setAttribute("userEmail",userdbName);
              session.setAttribute("role", dbUsertype); 
              response.sendRedirect("Admin.jsp"); 
              }

      /** Redirect successfull user login */

          else if(userEmail.equals(userdbName) && userPassword.equals(userdbPsw) && role.equals("user"))  {
              session.setAttribute("userEmail",userdbName);
              session.setAttribute("role", dbUsertype);
              response.sendRedirect("RoomScheduler.jsp");
              }
              }

      /** Redirect unsuccessfull login */

         else
              response.sendRedirect("error.jsp");
              rs.close();
              ps.close();
            }
         catch(SQLException sqe)  {
              out.println(sqe);
              }
          }
        else  {
        %>
              <center><p style="color:red">Error In Login</p></center>
              <%
              getServletContext().getRequestDispatcher("/home.jsp").include(request, response);
              }
              %>
  </body>
</html>
