<%@ page import="java.sql.*" %>
<html>
<head>
  <title>Add Student</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="container">
  <h2>Add Student</h2>
  <form method="POST">
    <label>Name:</label>
    <input type="text" name="name" required />
    <label>Email:</label>
    <input type="email" name="email" required />
    <label for="course">Course:</label>
<select name="course" id="course" required>
  <option value="">-- Select Course --</option>
  <option value="Computer Engineering" >Computer Engineering</option>
  <option value="Information Technology" >Information Technology</option>
  <option value="Electronics Engineering" >Electronics Engineering</option>
  <option value="Electrical Engineering">Electrical Engineering</option>
  <option value="Mechanical Engineering">Mechanical Engineering</option>
  <option value="Civil Engineering">Civil Engineering</option>
  <option value="Chemical Engineering">Chemical Engineering</option>
</select><br><br>

    <input type="submit" name="btnSubmit" value="Add Student" />
  </form>

  <%
  if (request.getParameter("btnSubmit") != null) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String course = request.getParameter("course");
    try {
      DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentdb", "root", "meera");
      PreparedStatement pst = con.prepareStatement("INSERT INTO students(name, email, course) VALUES (?, ?, ?)");
      pst.setString(1, name);
      pst.setString(2, email);
      pst.setString(3, course);
      pst.executeUpdate();
      con.close();
      response.sendRedirect("view.jsp");
    } catch (Exception e) {
      out.println("Error: " + e);
    }
  }
  %>
</div>
</body>
</html>