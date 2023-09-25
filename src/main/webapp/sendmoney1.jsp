<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Send money</title>
</head>
<body>
<%
	HttpSession hs=request.getSession();
	long accountnumber=(Long)hs.getAttribute("accountnumber");
	
	long accountnumber1=Long.parseLong(request.getParameter("accountnumber"));
	double balance=Double.parseDouble(request.getParameter("balance"));
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mahabank","root","1332");
	PreparedStatement ps=con.prepareStatement("select * from cust where accountnumber=?");
	ps.setLong(1, accountnumber);
	
	ResultSet rs=ps.executeQuery();
	rs.next();
	double oldbal=rs.getDouble(5);//main account 
	
	PreparedStatement ps2=con.prepareStatement("select * from cust where accountnumber=?");
	ps2.setLong(1, accountnumber1);
	
	ResultSet rs2=ps.executeQuery();
	rs2.next();
	double oldbal2=rs2.getDouble(5);//senders account balance
	rs2.getLong(3);
	
	
	
		if(oldbal>=balance){
			
				 double credit=oldbal2+balance;
				 PreparedStatement ps3=con.prepareStatement("update cust set balance=? where accountnumber=? ");
				 ps3.setDouble(1, credit);
				 ps3.setLong(2, accountnumber1);
				 ps3.execute();
				 
				 double credit2=oldbal-balance;
				 
				 PreparedStatement ps4=con.prepareStatement("update cust set balance=? where accountnumber=? ");
				 ps4.setDouble(1, credit2);
				 ps4.setLong(2, accountnumber);
				 ps4.execute();
				 
				 PrintWriter pw=response.getWriter();
					pw.println("Transection done");
					RequestDispatcher rd=request.getRequestDispatcher("UserInfoDisplay.jsp");
					rd.forward(request, response);
				 
			
		}
		else{
			PrintWriter pw=response.getWriter();
			pw.println("insufficient fund");
			
		}
	
	
	
	
%>

</body>
</html>