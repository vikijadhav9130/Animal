<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    String sort = request.getParameter("sort");
    String sortOrder = "name"; // Default sort order
    if ("category".equals(sort)) {
        sortOrder = "category";
    } else if ("life_expectancy".equals(sort)) {
        sortOrder = "life_expectancy";
    }

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AnimalDetails", "root", "vikijadhav@28");
        String sql = "SELECT id, name, category,image, description, life_expectancy FROM animalsDetails ORDER BY " + sortOrder;
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<title>List of Animals</title>
</head>
<body>
<center>
<%
  //Mesages
  String msg=request.getParameter("msg");
 if ("Undelete".equals(msg)) { %>
        <font color="red" size="5"><%= "Failed to delete" %></font>
    <% }else if("delete".equals(msg)){ %>
      <font color="red" size="5"><%= "Deleted" %></font><%} %>
    <h1>List of Animals</h1>
    <a href="AnimalSub.jsp">Add New Animal</a>
    <br><br>
    <form method="get">
       <!--sorting  -->
        <label for="sort">Sort By:</label>
        <select id="sort" name="sort" onchange="this.form.submit()">
          <option value="name" <%= "name".equals(sortOrder) ? "selected" : "" %>>Name</option>
            <option value="category" <%= "category".equals(sortOrder) ? "selected" : "" %>>Category</option>
          <option value="life_expectancy" <%= "life_expectancy".equals(sortOrder) ? "selected" : "" %>>Life Expectancy</option>
        </select>
    </form>
    <br><br>
    <table border="1" style="width: 100%; border: 1px solid black; border-collapse: collapse;">
        <tr>
            <th>Name</th>
            <th>Category</th>
            <th>Description</th>
            <th>Life Expectancy</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
        <%
         while (rs.next()) {
            int animalId = rs.getInt("id");
              String animalname = rs.getString("name");
                String animalcategory = rs.getString("category");
                String animaldescription = rs.getString("description");
                String animalLifeexpectancy = rs.getString("life_expectancy");
                Blob animalImageBlob = rs.getBlob("image");
                String encodedImage = null;

                if (animalImageBlob != null) {
                    byte[] imageBytes = animalImageBlob.getBytes(1, (int) animalImageBlob.length());
                    encodedImage = Base64.getEncoder().encodeToString(imageBytes);
                }
                 
        %>
        <tr>
          <td><%= animalname %></td>
          <td><%= animalcategory %></td>
          <td><%= animaldescription %></td>
          <td><%= animalLifeexpectancy %></td>
         
           <td>
                <% if (encodedImage != null) { %>
                    <img src="data:image/jpg;base64,<%= encodedImage %>" width="100"/>
                <% } else { %>
                    No image
                <% } %>
            </td>
           <td>
              <a href="AnimalSub.jsp?name=<%= animalname%>">Edit</a><br>
              <a href="DeleteAnimal.jsp?name=<%= animalname %>">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    </center>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } 
%>

