<%
  User usr = (User) session.getAttribute("current-user");
  if (usr == null) {
    session.setAttribute("msg", "You have to login to access this page");
    response.sendRedirect("login.jsp");
    return;
  }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Order placed</title>
  <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp"%>
<script>
  window.onload = function(){
    localStorage.clear();
    console.log("localstorage is cleared")
    updateCart();
  }
</script>
<div class="container" style="margin-top: 80px;margin-left: 20px">
  <h1 >Order placed successfully..!</h1>
  <h2>Your product(s) will be delivered on given address in 2-3 days...!</h2>
  <h2> Address: <span style="color: brown"><%=usr.getAddress()%></span></h2><br>
  <h2> Mode: <span style="color: brown">Cash On Delivery</span></h2><br>
  <button class="btn btn-success" onclick="window.location.href='index.jsp'">Continue Shopping</button>
</div>


<%@include file="components/common_cart_modal.jsp" %>
</body>
</html>
