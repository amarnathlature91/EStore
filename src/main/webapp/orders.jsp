<%@ page import="com.estore.dao.OrderDao" %>
<%@ page import="com.estore.helper.FactoryProvider" %>
<%@ page import="com.estore.entities.Order" %>
<%@ page import="java.util.List" %>
<%
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

    OrderDao od = new OrderDao(FactoryProvider.getFactory());
    List<Order> NSOrders = od.getOrdersByStatus("ordered");
    List<Order> SHOrders = od.getOrdersByStatus("shipped");
    List<Order> DLOrders = od.getOrdersByStatus("delivered");
    List<Order> RTOrders = od.getOrdersByStatus("returned");
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Orders</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>
<div class="container text-center" style="margin-top: 100px">
    <h1>Orders</h1>
</div>
<div class="container" style="margin-top: 10px">


    <ul class="nav nav-pills mb-8" id="pills-tab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" data-toggle="pill" href="#pills-nonShipped" role="tab"
               aria-controls="pills-nonShipped" aria-selected="true">Non-Shipped</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="pill" href="#pills-shipped" role="tab"
               aria-controls="pills-shipped" aria-selected="false">Shipped</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="pill" href="#pills-delivered" role="tab"
               aria-controls="pills-delivered" aria-selected="false">Delivered</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="pill" href="#pills-returned" role="tab"
               aria-controls="pills-returned" aria-selected="false">Returned</a>
        </li>
    </ul>

    <%--    non shipped orders tab--%>
    <div class="tab-content" id="pills-tabContent">
        <div class="tab-pane fade show active" id="pills-nonShipped" role="tabpanel" aria-labelledby="pills-home-tab">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">Order-ID</th>
                    <th scope="col">Address</th>
                    <th scope="col">Contact</th>
                    <th scope="col">Amount</th>
                    <th scope="col">Status</th>
                    <th scope="col">Delete</th>
                    <th scope="col">Change Status</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Order o : NSOrders) {
                %>
                <tr>
                    <td><%=o.getId()%>
                    </td>
                    <td><%=o.getAddress()%>
                    </td>
                    <td><%=o.getContact()%>
                    </td>
                    <td><%=o.getOrderTotal()%>
                    </td>
                    <td><%=o.getStatus()%>
                    </td>
                    <td>
                        <form action="/EStore_war_exploded/OrderOperationServlet" method="post">
                            <input type="hidden" name="oId" value="<%= o.getId() %>">
                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Are you sure you want to delete this order?')">Delete
                            </button>
                        </form>
                    </td>
                    <td>
                        <form action="/EStore_war_exploded/OrderOperationServlet" method="post">
                            <input type="hidden" name="oId" value="<%= o.getId() %>">
                            <input type="hidden" name="status" value="shipped">
                            <button type="submit" class="btn btn-warning"
                                    onclick="return confirm('Are you sure you want to Change status to shipped?')">
                                Shipped
                            </button>
                        </form>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>

        <%--    shipped orders tab--%>
        <div class="tab-pane fade" id="pills-shipped" role="tabpanel" aria-labelledby="pills-profile-tab">

            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">Order-ID</th>
                    <th scope="col">Address</th>
                    <th scope="col">Contact</th>
                    <th scope="col">Amount</th>
                    <th scope="col">Status</th>
                    <th scope="col">Delete</th>
                    <th scope="col">Change Status</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Order o : SHOrders) {
                %>
                <tr>
                    <td><%=o.getId()%>
                    </td>
                    <td><%=o.getAddress()%>
                    </td>
                    <td><%=o.getContact()%>
                    </td>
                    <td><%=o.getOrderTotal()%>
                    </td>
                    <td><%=o.getStatus()%>
                    </td>
                    <td>
                        <form action="/EStore_war_exploded/OrderOperationServlet" method="post">
                            <input type="hidden" name="oId" value="<%= o.getId() %>">
                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Are you sure you want to delete this order?')">Delete
                            </button>
                        </form>
                    </td>
                    <td>
                        <form action="/EStore_war_exploded/OrderOperationServlet" method="post">
                            <input type="hidden" name="oId" value="<%= o.getId() %>">
                            <input type="hidden" name="status" value="delivered">
                            <button type="submit" class="btn btn-warning"
                                    onclick="return confirm('Are you sure you want to Change status to delivered?')">
                                Delivered
                            </button>
                        </form>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        <%--    delivered orders tab--%>
        <div class="tab-pane fade" id="pills-delivered" role="tabpanel" aria-labelledby="pills-contact-tab">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">Order-ID</th>
                    <th scope="col">Address</th>
                    <th scope="col">Contact</th>
                    <th scope="col">Amount</th>
                    <th scope="col">Status</th>
                    <th scope="col">Delete</th>
                    <th scope="col">Change Status</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Order o : DLOrders) {
                %>
                <tr>
                    <td><%=o.getId()%>
                    </td>
                    <td><%=o.getAddress()%>
                    </td>
                    <td><%=o.getContact()%>
                    </td>
                    <td><%=o.getOrderTotal()%>
                    </td>
                    <td><%=o.getStatus()%>
                    </td>
                    <td>
                        <form action="/EStore_war_exploded/OrderOperationServlet" method="post">
                            <input type="hidden" name="oId" value="<%= o.getId() %>">
                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Are you sure you want to delete this order?')">Delete
                            </button>
                        </form>
                    </td>
                    <td>
                        <form action="/EStore_war_exploded/OrderOperationServlet" method="post">
                            <input type="hidden" name="oId" value="<%= o.getId() %>">
                            <input type="hidden" name="status" value="returned">
                            <button type="submit" class="btn btn-warning"
                                    onclick="return confirm('Are you sure you want to Change status to returned?')">
                                Returned
                            </button>
                        </form>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>

        <%--        show returned products--%>
        <div class="tab-pane fade" id="pills-returned" role="tabpanel" aria-labelledby="pills-return-tab">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">Order-ID</th>
                    <th scope="col">Address</th>
                    <th scope="col">Contact</th>
                    <th scope="col">Amount</th>
                    <th scope="col">Status</th>
                    <th scope="col">Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Order o : RTOrders) {
                %>
                <tr>
                    <td><%=o.getId()%>
                    </td>
                    <td><%=o.getAddress()%>
                    </td>
                    <td><%=o.getContact()%>
                    </td>
                    <td><%=o.getOrderTotal()%>
                    </td>
                    <td><%=o.getStatus()%>
                    </td>
                    <td>
                        <form action="/EStore_war_exploded/OrderOperationServlet" method="post">
                            <input type="hidden" name="oId" value="<%= o.getId() %>">
                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Are you sure you want to delete this order?')">Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
    </div>

    <%@include file="components/common_cart_modal.jsp" %>
</body>
</html>
