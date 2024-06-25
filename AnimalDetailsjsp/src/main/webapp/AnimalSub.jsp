<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="AnimalDetails.*" %>
<%
    String name = request.getParameter("name");
   String category = request.getParameter("category");
    String description = request.getParameter("description");
   String lifeExpectancy = request.getParameter("life_expectancy");
    String captcha = request.getParameter("captcha");
    String errorMessage = (String) request.getAttribute("errorMsg");
    boolean isEdit = request.getParameter("id") != null;
    String id = request.getParameter("id");
    
    

%>
<!DOCTYPE html>
<html>
<head>
    <title><%=isEdit?"Edit Animal Details":"Add New Animal" %></title>
</head>
<body>
   <center>
   <div style="background-color:gray">
   
    <h1><%= isEdit ? "Edit Animal" : "Add New Animal" %></h1>
    <% String msg=request.getParameter("msg");
    if ("notvalid".equals(msg)) { %>
        <font color="red" size="5"><%= "Captcha is incorrect" %></font>
    <% }else if("unsave".equals(msg)){ %>
      <font color="red" size="5"><%= "Failed to save" %></font><%} %>
    <form action="AnimalDb" method="post" enctype="multipart/form-data">
        <% if (isEdit) { %>
            <input type="hidden" name="id" value="<%= id %>" />
        <% } %>
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="<%= name != null ? name : "" %>" required><br><br>

        <label for="category">Category:</label>
        <select id="category" name="category" required>
            <option value="Mammal" <%= "Mammal".equals(category) ? "selected" : "" %>>Mammal</option>
          <option value="Bird" <%= "Bird".equals(category) ? "selected" : "" %>>Bird</option>
           <option value="Reptile" <%= "Reptile".equals(category) ? "selected" : "" %>>Reptile</option>
            <option value="Fish" <%= "Fish".equals(category) ? "selected" : "" %>>Fish</option>
        </select><br><br>

        <label for="image">Image:</label>
        <input type="file" id="image" name="image"><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required><%= description != null ? description : "" %></textarea><br><br>

        <label for="life_expectancy">Life Expectancy:</label>
        <select id="life_expectancy" name="life_expectancy" required>
            <option value="2-5" <%= "2-5".equals(lifeExpectancy) ? "selected" : "" %>>2-5 years</option>
            <option value="5-10" <%= "5-10".equals(lifeExpectancy) ? "selected" : "" %>>5-10 years</option>
            <option value="10-20" <%= "10-20".equals(lifeExpectancy) ? "selected" : "" %>>10-20 years</option>
            <option value="20+" <%= "20+".equals(lifeExpectancy) ? "selected" : "" %>>20+ years</option>
        </select><br><br>

        <label for="captcha">Captcha: What is 3 + 4?</label>
        <input type="text" id="captcha" name="captcha" required><br><br>


        <input type="submit" value="Submit" style="background-color:blue">
        
    </form>
    </div>
    </center>
</body>
</html>
