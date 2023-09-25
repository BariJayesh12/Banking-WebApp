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
		HttpSession hs=request.getSession();
	
		long accountnumber=(Long)hs.getAttribute("accountnumber");
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mahabank","root","1332");
		PreparedStatement ps=con.prepareStatement("select * from cust where accountnumber=?");
		ps.setLong(1, accountnumber);
		
		ResultSet rs= ps.executeQuery();
		rs.next();
	%>

	<fieldset  align="center" style="color:red">
		<legend  align="center" style="color:blue">Account Details</legend>
			<form  action="update1.jsp">
	
					Id 			:<input type="number" name="id" value="<%= rs.getInt(1) %>" readonly="readonly"> <br><br>
					Name 		:<input type="text" name="name" value="<%= rs.getString(2) %>" > <br><br>
					A/C Number 	:<input type="number" name="accountnumber" value="<%= rs.getLong(3) %>" readonly="readonly"><br><br>
					Balance 	:<input type="number" name="balance" value="<%= rs.getDouble(5) %>" readonly="readonly"><br><br>
					<input type="submit">
					
			</form>
			
			
	</fieldset>

</body>
</html>