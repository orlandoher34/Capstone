<!--
This servlet processes a bad user login attempt from the login servlet and redirects
them back to the login page with a message totry again.
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Login Error</title>
  </head>
  <body>
    <center><p style="color:red">Please verify your information and try again. If this contiues please call support.</p></center>
    <%
       getServletContext().getRequestDispatcher("/home.jsp").include(request, response);
       %>
  </body>
</html>