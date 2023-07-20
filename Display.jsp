<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
    crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
    crossorigin="anonymous">
</head>
<style>
	.container{
		width: 30%;
	}
</style>
<body>
	<%!Connection con = null;
	PreparedStatement prepare = null;

	public Connection config() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/testDB?useSSL=false";
			con = DriverManager.getConnection(url, "root", "password123");
			if (con == null) {
				System.out.println("Connection Failed");
			} else {
				System.out.println("Database MySQL connected");
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return con;
	}%>
	<%
	String query = "Select * from productJsp;";
	con = config();
	try
	{
		prepare = con.prepareStatement(query);
		ResultSet resultSet = prepare.executeQuery(query);
		out.println("<div class='container mt-5'>");
		out.println("<h1 class='text-center '>Display Candidates</h1>");
		out.println("<div class=\"table-responsive pt-3 \">");
		out.println("<table class=\"table table-bordered table-hover table-dark table-striped mx-auto\">");
		out.println("<thead><tr>"
		        + "<th scope=\"col\">Product ID</th>"
		        + "<th scope=\"col\">Product Name</th>"
		        + "<th scope=\"col\">Price</th>"
		        + "</tr></thead>");
		out.println("<tbody>"); // Added tbody tag to wrap the table body content
		while (resultSet.next()) {
		    int pid = resultSet.getInt("id");
		    String name = resultSet.getString("name");
		    int price = resultSet.getInt("price");

		    // Rows should be on the same line with all the columns
		    out.println("<tr>"
		            + "<td>" + pid + "</td>"
		            + "<td>" + name + "</td>"
		            + "<td>" + price + "</td>"
		            + "</tr>");
		}
		out.println("</tbody>"); // Closed the tbody tag
		out.println("</table>");
		out.println("</div>");
		out.println("</div>");
	}catch(SQLException e)
	{
		
		e.printStackTrace();
	}
	%>
</body>
</html>