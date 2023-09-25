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
<title>Insert title here</title>
</head>
<body>
<%

	long pincode=Long.parseLong(request.getParameter("pincode"));
	long pincode1=Long.parseLong(request.getParameter("pincode1"));
	long pincode2=Long.parseLong(request.getParameter("pincode2"));
	
	HttpSession hs=request.getSession();
	long accountnumber=(Long)hs.getAttribute("accountnumber");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mahabank","root","1332");
	if(pincode1==pincode2){
		
		PreparedStatement ps1=con.prepareStatement("select * from cust where accountnumber=? and pincode=?");
		ps1.setLong(1, accountnumber);
		ps1.setLong(2, pincode);
		ResultSet rs=ps1.executeQuery();
		//rs.next();
		if(rs.next()){
		
		
		PreparedStatement ps=con.prepareStatement("update cust set pincode=? where accountnumber=? and pincode=?");
		ps.setLong(1, pincode1);
		ps.setLong(2, accountnumber);
		ps.setLong(3, pincode);
		ps.execute();
		
		PrintWriter pw=response.getWriter();
		pw.println("PINCODE CHANGED");
		
		RequestDispatcher rd=request.getRequestDispatcher("UserInfoDisplay.jsp");
		rd.forward(request, response);
		}
		else{
			PrintWriter pw=response.getWriter();
			pw.println("old Pincode dosn't match");
		}
	}
	else{
		
		PrintWriter pw=response.getWriter();
		pw.println("Pin dosn't match");
	}
%>

</body>
</html>