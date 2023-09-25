<%@page import="java.sql.SQLException"%>
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
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            background-color: #ffffff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            padding: 20px;
            max-width: 600px;
            margin: 20px auto;
        }
        h1 {
            color: #007bff;
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            font-size: 16px;
        }
        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 12px 24px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.2s;
            display: block;
            margin: 10px auto;
            text-align: center;
        }
        button:hover {
            background-color: #0056b3;
        }
        .logo {
            display: block;
            margin: 0 auto;
            max-width: 150px;
        }
    </style>
</head>
<body>
<%
long accountnumber=Long.parseLong(request.getParameter("accountnumber"));

long govid= Long.parseLong(request.getParameter("govid"));

double balance=Double.parseDouble(request.getParameter("balance"));

HttpSession hs=request.getSession();
hs.setAttribute("accountnumber", accountnumber);

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mahabank","root","1332");
	PreparedStatement ps=con.prepareStatement("select * from cust where accountnumber=? and govid=?");
	ps.setLong(1, accountnumber);
	ps.setLong(2, govid);
	
	ResultSet rs=ps.executeQuery();
	//rs.next();
	if(rs.next()) {
		
		 double oldbal=rs.getDouble(3);
		 double credit=oldbal+balance;
		 PreparedStatement ps2=con.prepareStatement("update cust set balance=? where accountnumber=? and govid=?");
		 ps2.setDouble(1,credit);
		 ps2.setLong(2, accountnumber);
		 ps2.setLong(3, govid);
		 ps2.execute();
		// ResultSet rs2=ps2.executeQuery();
		 //rs2.next();
		 /*RequestDispatcher rd=request.getRequestDispatcher("UserInfoDisplay.jsp");
		 rd.forward(request, response);*/
		 
		
	}
	else {
		PrintWriter pw=response.getWriter();
		pw.println("Invalid credential");
	}
	
	


%>

<div class="container">
        <img src="https://cdn.dribbble.com/users/5214489/screenshots/14862674/jb_bj_logo_letter_design.jpg" alt="Bank Logo" class="logo">
        <h1>Account Details</h1>
        <div class="form-group">
            <label for="id">Gov Id:</label>
            <input type="number" name="id" value="<%= rs.getInt(1) %>" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" name="name" value="<%= rs.getString(2) %>" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="accountnumber">A/C Number:</label>
            <input type="number" name="accountnumber" value="<%= rs.getLong(3) %>" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="balance">Balance:</label>
            <input type="number" name="balance" value="<%= rs.getDouble(5) %>" readonly="readonly">
        </div>

        
    </div>

</body>
</html>