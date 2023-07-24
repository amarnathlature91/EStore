<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Object order = session.getAttribute("order");
    User usr = (User) session.getAttribute("current-user");
    if (usr == null) {
        session.setAttribute("msg", "You have to login to access this page");
        response.sendRedirect("login.jsp");
        return;
    } else if (usr.getRole().equals("user")) {
        session.setAttribute("msg", "Only Admin can access this page");
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Search Order</title>
    <%@include file="components/common_css_js.jsp"%>
</head>
<body>
<%@include file="components/navbar.jsp"%>
<div class="container text-center" style="text-align: center;margin-top: 80px" >
    <h2>Search Order By ID</h2><br>
    <form method="post" action="/EStore_war_exploded/SearchForOrder" >
        <input class="form-control rounded" type="text" required placeholder="Enter Order-Id" name="orderId" id="orderId">
        <br>
        <input type="submit" class="btn btn-outline-primary" value="Search">
    </form>

    <c:if test="${not empty order}">
        <table class="table">
            <thead class="thead-dark">
            <tr>
                <th>Order ID</th>
                <th>Total Products</th>
                <th>Total Amount</th>
                <th>Address</th>
                <th>Billing Name</th>
                <th>Contact</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>${order.id}</td>
                <td>${order.totalProducts}</td>
                <td>${order.orderTotal}</td>
                <td>${order.address}</td>
                <td>${order.billingName}</td>
                <td>${order.contact}</td>
                <td>${order.status}</td>
            </tr>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty order}">
        <p>No user found with the specified ID.</p>
    </c:if>
</div>
</body>
</html>
