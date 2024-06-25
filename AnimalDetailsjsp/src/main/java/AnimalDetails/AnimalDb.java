package AnimalDetails;
import java.sql.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;

/**
 * Servlet implementation class AnimalDb
 *
 */
 @MultipartConfig
public class AnimalDb extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnimalDb() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id");
	    String name = request.getParameter("name");
	    String category = request.getParameter("category");
	    String description = request.getParameter("description");
	    String lifeExpectancy = request.getParameter("life_expectancy");
	    String captcha = request.getParameter("captcha");

	    // Captcha validation
	    if (!"7".equals(captcha)) {
	        response.sendRedirect("AnimalSub.jsp?msg=notvalid");
	       
	    }


	    // File upload
	    Part imagePart = request.getPart("image");
	    InputStream imageStream = null;
	    if (imagePart != null && imagePart.getSize() > 0) {
	        imageStream = imagePart.getInputStream();
	    }

	    Connection conn = null;
	    PreparedStatement ps = null;

	    try {
	        // Database connection
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AnimalDetails", "root", "vikijadhav@28");

	        if (id != null) {
	            // Update animal
	            if (imageStream != null) {
	                String sql = "update animalsDetails set name=?, category=?, description=?, life_expectancy=?, image=? WHERE id=?";
	                ps= conn.prepareStatement(sql);
	                ps.setString(1, name);
	                ps.setString(2, category);
	                ps.setString(3, description);
	                ps.setString(4, lifeExpectancy);
	                ps.setBlob(5, imageStream);
	                ps.setInt(6, Integer.parseInt(id));
	            } else {
	                String sql = "update  animalsDetails set name=?, category=?, description=?, life_expectancy=? WHERE id=?";
	                ps = conn.prepareStatement(sql);
	                ps.setString(1, name);
	                ps.setString(2, category);
	                ps.setString(3, description);
	                ps.setString(4, lifeExpectancy);
	                ps.setInt(5, Integer.parseInt(id));
	            }
	        } else {
	            // Insert new animal details
	            String sql = "insert into animalsDetails (name, category, description, life_expectancy, image) VALUES (?, ?, ?, ?, ?)";
	            ps = conn.prepareStatement(sql);
	            ps.setString(1, name);
	            ps.setString(2, category);
	            ps.setString(3, description);
	            ps.setString(4, lifeExpectancy);
	            if (imageStream != null) {
	                ps.setBlob(5, imageStream);
	            } else {
	                ps.setNull(5, Types.BLOB);
	            }
	        }

	     
	        if (ps.executeUpdate()> 0) {
	            response.sendRedirect("AnimalList.jsp");
	        } else {
	                response.sendRedirect("AnimalSub.jsp?msg=unsave");
	        }

	    } catch (Exception e) 
	    {
	        e.printStackTrace();
	    }
	        
	       
		doGet(request, response);
	}

}
