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
<title>Admin Login</title>
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
	String email=request.getParameter("email");
	String password=request.getParameter("password");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mahabank","root","1332");
	PreparedStatement ps=con.prepareStatement("select * from admin where email=? and password=?");
	ps.setString(1, email);
	ps.setString(2, password);
	
	ResultSet rs=ps.executeQuery();
	rs.next();
	

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
            <label for="accountnumber">Email:</label>
            <input type="email" name="email" value="<%= rs.getString(3) %>" readonly="readonly">
        </div>



        <button><a href="Addmoney1.html">ADD MONEY</a></button>
        <button><a href="UpdateProfile1.jsp">PROFILE UPDATE</a></button>
        <button><a href="PinUpdate.html">PINCODE UPDATE</a></button>
    </div>

</body>
</html>