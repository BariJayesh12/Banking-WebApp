package webapp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Createadmin")
public class CreateAdmin extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				
		
		HttpSession hs=req.getSession();
		int id=(Integer) hs.getAttribute("id");
		String name=(String) hs.getAttribute("name");
		String email=(String) hs.getAttribute("email");
		String password=(String) hs.getAttribute("password");
		
		if (Integer.parseInt(req.getParameter("otp1")) == (Integer)hs.getAttribute("otp"))
		{
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				
					Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mahabank","root","1332");
					PreparedStatement ps=con.prepareStatement("Insert into admin(id,name,email,password)values(?,?,?,?)");
					ps.setInt(1, id);
					ps.setString(2, name);
					ps.setString(3, email);
					ps.setString(4, password);
					ps.execute();
					
				 
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			PrintWriter pw=resp.getWriter();
			pw.println("<h1 align=\"center\">Account is created succesfully</h1><br>");
			
			RequestDispatcher rd=req.getRequestDispatcher("AdminLogin.html");
			rd.forward(req, resp);
		
			
		}
		else {
			RequestDispatcher rd=req.getRequestDispatcher("otp1.html");
			rd.forward(req, resp);
		}
		
		
		
	}

}
