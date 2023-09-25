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

@WebServlet("/savecustomerotp")
public class SaveCustomerOtp extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession hs=req.getSession();
		long id=(Long) hs.getAttribute("id");
		String name=(String) hs.getAttribute("name");
		String email=(String) hs.getAttribute("email");
		long pincode=(Long) hs.getAttribute("pincode");
		long accountnumber=(Long) hs.getAttribute("accountnumber");
		double balance= (Double) hs.getAttribute("balance");
		
		if (Integer.parseInt(req.getParameter("otp1")) == (Integer)hs.getAttribute("otp")) {
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				try {
					Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mahabank","root","1332");
					PreparedStatement ps=con.prepareStatement("insert into cust(govid,name,accountnumber,pincode,balance,email) values(?,?,?,?,?,?)");
					ps.setLong(1, id);
					ps.setString(2, name);
					ps.setLong(3, accountnumber);
					ps.setLong(4, pincode);
					ps.setDouble(5, balance);
					ps.setString(6, email);
					ps.execute();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			PrintWriter pw=resp.getWriter();
			pw.println("<h1 align=\"center\">Account is created succesfully</h1><br>");
			
			RequestDispatcher rd=req.getRequestDispatcher("CustomerLogin.html");
			rd.forward(req, resp);
			
		}
		else {
			PrintWriter pw=resp.getWriter();
			pw.println("Invalid Otp");
			
		}
	}

}
