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
    <script>
        //function to assign cart data to hidden input field
        function fetchCartToServer() {
            const cart = JSON.parse(localStorage.getItem('cart'));

            // Convert the cart to JSON format
            const cartJson = JSON.stringify(cart);
            document.getElementById("cartId").value=cartJson;
        }

    </script>
    <title>Checkout</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>

<div class="container" style="margin-top: 80px">
    <div class="row mt-5">
        <div class="col-md-6">
            <%--            card --%>
            <div class="card">
                <div class="card-body">
                    <h2 class="text-center mb-4">Your selected items</h2>
                    <div class="cart-body"></div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <%--            details--%>
            <div class="card">
                <div class="card-body">
                    <h2 class="text-center mb-4">Your details for order</h2>
                    <form action="/EStore_war_exploded/PlaceOrderServlet" method="post" onsubmit="fetchCartToServer()">
                        <div class="form-group">
                            <label for="bilEmail">Email address</label>
                            <input value="<%=usr.getEmail()%>" name="bilEmail" type="email" class="form-control" id="bilEmail"
                                   aria-describedby="emailHelp" placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label for="bilName">Billing Name</label>
                            <input value="<%=usr.getUserName()%>" name="bilName" type="text" class="form-control" id="bilName"
                                   aria-describedby="emailHelp" placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label for="bilcn">Contact Number</label>
                            <input value="<%=usr.getContact()%>" name="bilcn" type="text" class="form-control" id="bilcn"
                                   aria-describedby="emailHelp" placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label for="bilAdd">Shipping/Billing Address</label>
                            <textarea class="form-control" name="bilAdd" id="bilAdd" rows="3"><%=usr.getAddress()%></textarea>
                        </div>
                        <div class="container text-center">
                            <input type="hidden" value="" name="cart" id="cartId">
                            <button type="submit" class="btn btn-success">Order Now</button>
                            <button class="btn btn-primary">Continue Shopping</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="components/common_cart_modal.jsp" %>
</body>
</html>
