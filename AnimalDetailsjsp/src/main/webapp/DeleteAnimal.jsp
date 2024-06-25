<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String name= request.getParameter("name");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AnimalDetails", "root", "vikijadhav@28");

        // Delete animal
        String sql = "DELETE FROM animalsDetails WHERE name=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);

        if (pstmt.executeUpdate() > 0) {
            response.sendRedirect("AnimalList.jsp");
        } else {
            response.sendRedirect("AnimalSub.jsp?msg=undelete");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
