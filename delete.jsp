<%@ page import="java.sql.*" %>
<html>
<head>
  <title>Delete Student</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="container">
  <h2>Are you sure you want to delete this student?</h2>
  <%
    String id = request.getParameter("deleteId");
    String name = request.getParameter("deleteName");
  %>
  <p><strong>Name:</strong> <%= name %></p>
  <form method="post">
    <input type="hidden" name="id" value="<%= id %>" />
    <input type="submit" name="confirmDelete" value="Delete" />
    <a href="view.jsp"><button type="button">Cancel</button></a>
  </form>

  <%
    if (request.getParameter("confirmDelete") != null) {
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentdb", "root", "meera");
        PreparedStatement pst = con.prepareStatement("DELETE FROM students WHERE id=?");
        pst.setInt(1, Integer.parseInt(id));
        pst.executeUpdate();
        con.close();
        response.sendRedirect("view.jsp");
      } catch (Exception e) {
        out.println("Error deleting student: " + e);
      }
    }
  %>
</div>
</body>
</html>