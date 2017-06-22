<!--
This servlet processes information collected in the form on the update servlet.
It then updates the user record with the desired role and retruns user
back to update page with a success message.
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>role Update</title>
  </head>
  <body>

    <!-- SQL Connection used for the role dropdownbox values. -->

    <%
       Connection con= null;
       PreparedStatement ps = null;
       ResultSet rs = null;

       String driverName = "com.mysql.jdbc.Driver";
       String url = "jdbc:mysql://localhost:3306/CITIZEN";
       String user = "dbadmin";
       String dbpsw = "db123";

       String sql = "update User set role=? where userEmail=?";

       String userEmail = request.getParameter("userEmail");
       String role = request.getParameter("role");

   if(!(userEmail.equals("select")) && !(role.equals("select")))	
     {
      try{
       Class.forName(driverName);
       con = DriverManager.getConnection(url, user, dbpsw);	
       PreparedStatement statement = con.prepareStatement(sql);
       statement.setString(1, role);
       statement.setString(2, userEmail);

       int rowsUpdated = statement.executeUpdate();
       if (rowsUpdated > 0) {
              
%>
              <center><p style="color:blue">An existing user was updated successfully!</p></center>
              <%
              getServletContext().getRequestDispatcher("/update.jsp").include(request, response);
              }
              
else
              response.sendRedirect("error.jsp");
              statement.close();
              con.close();
}
catch(SQLException sqe)  {
              out.println(sqe);
              }
}
else  {
%>

<center><p style="color:red">Please select a valid username and role!</p></center>
              <%
              getServletContext().getRequestDispatcher("/update.jsp").include(request, response);
              }
              %>
</body>
</html>

