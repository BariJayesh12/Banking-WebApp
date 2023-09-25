package webapp;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CustomerLogin1")
public class CustomerLogin extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		long accountnumber=Long.parseLong(req.getParameter("accountnumber"));
		long pincode=Long.parseLong(req.getParameter("pincode"));
		
		
		HttpSession hs=req.getSession();
		hs.setAttribute("accountnumber", accountnumber);
		hs.setAttribute("pincode",pincode);
		
		long accountnumber2=(Long)hs.getAttribute("accountnumber");
		
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try {
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mahabank","root","1332");
				PreparedStatement ps=con.prepareStatement("select * from cust where accountnumber=? and pincode=?");
				
				ps.setLong(1, accountnumber);
				ps.setLong(2, pincode);
				
				ResultSet rs=ps.executeQuery();
				if(rs.next()) {
					PrintWriter pw=resp.getWriter();
					pw.println("Loging Successfull");
					
					RequestDispatcher rd=req.getRequestDispatcher("UserInfoDisplay.jsp");
					rd.forward(req, resp);
				}
				else {
					PrintWriter pw=resp.getWriter();
					pw.println("Invalid Credential");
					
					RequestDispatcher rd=req.getRequestDispatcher("CustomerLogin.html");
					rd.forward(req, resp);
					
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}

