<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<style>
body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 50vh;
	margin: 0;
}

.card-container {
	width: 700px;
	max-width: 1000px;
	padding: 20px;
}

.card {
	margin: auto; /* Add this to center the card horizontally */
	height: 100%;
	text-align: center;
}
.card-title {
	font-size: 45px;
}

.card-subtitle {
	font-size: 35px;
}

/* Increase the font size for the display button */
.btn-primary {
	font-size: 25px;
}
td{
	font-szie: 25px;
	font-weight: bold;	
}
</style>
</head>
<body>
	<%
	Connection con = null;
	PreparedStatement prepare = null;

	try {
		int productId = Integer.parseInt(request.getParameter("productId"));
		String id_str = Integer.toString(productId);
		String productName = request.getParameter("productName");
		int price = Integer.parseInt(request.getParameter("price"));
		System.out.println(productId);
		System.out.println(productName);
		System.out.println(price);
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/testDB?useSSL=false";
		con = DriverManager.getConnection(url, "root", "password123");
		if (con != null) {
			String insert_query = "INSERT INTO productJsp(id, name, price) VALUES(?,?,?)";
			prepare = con.prepareStatement(insert_query, Statement.RETURN_GENERATED_KEYS);

			prepare.setInt(1, productId);
			prepare.setString(2, productName);
			prepare.setInt(3, price);

			int rowsAffected = prepare.executeUpdate();
			if (rowsAffected > 0) {
		String htmlCode = "<div class=\"card-container pt-5 mt-5 \">\n" + "    <div class=\"card mx-auto\">\n"
				+ "        <div class=\"card-body\">\n" + "            <h2 class=\"card-title\">Display</h2>\n"
				+ "            <h3 class=\"card-subtitle mb-3 text-muted\">Successfully Update DB</h3>\n"
				+ "            <form action=\"Display.jsp\" method=\"post\">\n"
				+ "                <table class=\"table\">\n" + "                    <tr>\n"
				+ "                        <td>Your Candidate Number: " + productId + "</td>\n" + "</tr>\n" + "                    <tr>\n"
				+ "                        <td><input type=\"submit\" value=\"Display\" class=\"btn btn-primary\"></td>\n"
				+ "                    </tr>\n" + "                </table>\n" + "            </form>\n"
				+ "        </div>\n" + "    </div>\n" + "</div>";
		out.println(htmlCode);
			} else {
		out.println("Failed to insert.");
			}

		} else {
			out.println("Connection Failed");
		}

	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
		out.println("An error occurred while processing the request.");
	} catch (NumberFormatException e) {
		out.println("Invalid input. Please enter numeric values for Product ID and Price.");
	} finally {
		try {
			if (prepare != null) {
		prepare.close();
			}
			if (con != null) {
		con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	%>
</body>
</html>
