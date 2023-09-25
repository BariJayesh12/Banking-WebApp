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


	String name=request.getParameter("name");
	long accountnumber=Long.parseLong(request.getParameter("accountnumber"));
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mahabank","root","1332");
	PreparedStatement ps=con.prepareStatement("update cust set name=? where accountnumber=?");
	ps.setString(1, name);
	ps.setLong(2, accountnumber);
	ps.execute();
	
	RequestDispatcher rd=request.getRequestDispatcher("UserInfoDisplay.jsp");
	rd.forward(request, response);




%>

</body>
</html>