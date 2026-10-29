<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Saved! All Records</title>
    <style>
    body{font-family:Arial;background:#f4f7fb;}
    h2{text-align:center; color:#3B5EA6;}
    table{ margin:auto;width:80%;background:while;}
    th,td{border :1px solid #bbb;padding:10px; text-align:center;}
    .total{text-align:center;margin:20px}
    </style>
</head>
<body>
<% Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/rationdb",
        "root",
        "khushi@25saha"
    );
    String item = request.getParameter("item");
    String quantity = request.getParameter("quantity");
    String rateperkg=request.getParameter("rate per kg");
    if (item!=null && quantity!=null && rateperkg!=null
    && !quantity.trim().isEmpty() && !rateperkg.trim().isEmpty()) {
    double qty=Double.parseDouble(quantity);
    double rate=Double.parseDouble(rateperkg);
    if (qty<0 ||rate<0){
    throw new IllegalArgumentException("Quantity and rate cannot be negative"):
    }
            PreparedStatement ps = con.prepareStatement(
            "INSERT INTO ration_stock(item,qty_kg,rate) VALUES(?,?,?)"
        );
        ps.setString(1, item);
        ps.setString(2, qty);
        ps.setString(3, rate);
        ps.executeUpdate();
        ps.close();
    }
    <h2>Saved! all records</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Item</th>
            <th>Quantity</th>
            <th>rate per kg</th>
        </tr>
    <%
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM ration_stock");
        double totalQuantity = 0;
        while (rs.next()) {
    %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("item") %></td>
            <td><%= rs.getString("qty") %></td>
            <td><%= rs.getString("rate")%></td>
            <td><%=
        </tr>
    <%
        }
        rs.close();
        st.close();
        con.close();
    %>
    </table>
    <p align="center">
        <a href="index.html">Add another Record</a>
    </p>
</body>
</html>



