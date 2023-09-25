<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checking the email and password</title>
</head>
<body>
<%

		String email=request.getParameter("email");
		String password=request.getParameter("password");
		
		String bankemail="mahabank@gmail.com";
		String bankpassword="Pass@123";
		
		
		if(bankemail.equals(email)){
			
			if((bankpassword.equals(password))){
			
			RequestDispatcher rd=request.getRequestDispatcher("BankMenu.html");
			rd.forward(request, response);
			}
			else{
				PrintWriter pw=response.getWriter();
				pw.println("Invalid Password ");
			}
			
		}
		else{
			
			PrintWriter pw=response.getWriter();
			pw.println("Invalid Email ID");
		}
		
		
%>

</body>
</html>