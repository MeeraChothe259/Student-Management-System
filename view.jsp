<%@ page import="java.sql.*" %>
<html>
<head>
  <title>View Students</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="card-container">
<%

try {
  DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentdb", "root", "meera");
  Statement st = con.createStatement();
  ResultSet rs = st.executeQuery("SELECT * FROM students");

  while (rs.next()) {
    int id = rs.getInt(1);
    String name = rs.getString(2);
 
%>
  <div class="card">
    <h2><%= rs.getString("name") %></h2>
    <p>Email: <%= rs.getString("email") %></p>
    <p>Course: <%= rs.getString("course") %></p>
    <a href="update.jsp?updateId=<%=id%>">
      <button>Edit</button>
    </a>
    <a href="delete.jsp?deleteId=<%=id%>&deleteName=<%=name%>">
      <button>Delete</button>
    </a>
  </div>
<%
  }
  con.close();
} catch (Exception e) {
  out.println("View Error: " + e);
}
%>
</div>
</body>
</html>