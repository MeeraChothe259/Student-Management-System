<%@ page import="java.sql.*" %>
<html>
<head>
  <title>Update/Add Student</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="container">
<%
  String id = request.getParameter("updateId");
  String name = "", email = "", course = "";
  if (id != null) {
    try {
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentdb", "root", "meera");
      PreparedStatement pst = con.prepareStatement("SELECT * FROM students WHERE id=?");
      pst.setInt(1, Integer.parseInt(id));
      ResultSet rs = pst.executeQuery();
      if (rs.next()) {
        name = rs.getString("name");
        email = rs.getString("email");
        course = rs.getString("course");
      }
      con.close();
    } catch (Exception e) {
      out.println("Error loading student: " + e);
    }
  }
%>
  <h2><%= (id == null) ? "Add New Student" : "Update Student" %></h2>
  <form method="post">
    <input type="text" name="name" value="<%= name %>" placeholder="Name" required /><br><br>
    <input type="email" name="email" value="<%= email %>" placeholder="Email" required /><br><br>
    <label for="course">Course:</label>
    <select name="course" id="course" required>
    <option value="">-- Select Course --</option>
    <option value="Computer Engineering" <%= course.equals("Computer Engineering") ? "selected" : "" %>>Computer Engineering</option>
    <option value="Information Technology" <%= course.equals("Information Technology") ? "selected" : "" %>>Information Technology</option>
    <option value="Electronics Engineering" <%= course.equals("Electronics Engineering") ? "selected" : "" %>>Electronics Engineering</option>
    <option value="Electrical Engineering" <%= course.equals("Electrical Engineering") ? "selected" : "" %>>Electrical Engineering</option>
    <option value="Mechanical Engineering" <%= course.equals("Mechanical Engineering") ? "selected" : "" %>>Mechanical Engineering</option>
    <option value="Civil Engineering" <%= course.equals("Civil Engineering") ? "selected" : "" %>>Civil Engineering</option>
    <option value="Chemical Engineering" <%= course.equals("Chemical Engineering") ? "selected" : "" %>>Chemical Engineering</option>
    </select><br><br>

    <input type="submit" name="submit" value="Save" />
  </form>
<%
  if (request.getParameter("submit") != null) {
    name = request.getParameter("name");
    email = request.getParameter("email");
    course = request.getParameter("course");
    try {
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentdb", "root", "meera");
      if (id == null) {
        PreparedStatement pst = con.prepareStatement("INSERT INTO students(name, email, course) VALUES (?, ?, ?)");
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, course);
        pst.executeUpdate();
      } else {
        PreparedStatement pst = con.prepareStatement("UPDATE students SET name=?, email=?, course=? WHERE id=?");
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, course);
        pst.setInt(4, Integer.parseInt(id));
        pst.executeUpdate();
      }
      con.close();
      response.sendRedirect("view.jsp");
    } catch (Exception e) {
      out.println("Error saving student: " + e);
    }
  }
%>
</div>
</body>
</html>