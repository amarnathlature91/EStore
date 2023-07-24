<%@ page import="com.estore.entities.User" %>
<%@ page import="com.estore.entities.Product" %>
<%@ page import="com.estore.dao.UserDao" %>
<%@ page import="com.estore.helper.FactoryProvider" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.estore.dao.ProductDao" %>
<%@ page import="com.estore.helper.Dfetcher" %>
<%
    User usr = (User) session.getAttribute("current-user");
    if (usr == null) {
        session.setAttribute("msg", "You have to login to access this page");
        response.sendRedirect("login.jsp");
        return;
    }
    Set<Product> ps = new UserDao(FactoryProvider.getFactory()).getFavoritesByUId(usr.getUserId());
    Dfetcher df = new Dfetcher();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Favorites</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>

<div class="col text-center" style="margin-top: 80px">
    <%@include file="components/message.jsp"%>
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card-columns">
                <%
                    for (Product p : ps) {

                %>
                <div class="card product-card">
                    <div class="container text-center">
                        <img class="card-img-top m-3" style="max-height:200px;width: auto;max-width: 100%;height: 20%"
                             src="img/product/<%=p.getpPhoto()%>" alt="<%=p.getpPhoto()%>">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><%=p.getpName()%>
                        </h5>
                        <p class="card-text"><%=df.getMini(p.getpDescription())%>
                        </p>
                    </div>
                    <div class="card-footer text-center">
                        <a href="#" class="btn btn-primary"
                           onclick="addToCart(<%=p.getpId()%>,'<%=p.getpName()%>',<%=p.getDiscountedPrice()%>)">Add to
                            cart</a>
                        <a href="#" class="btn btn-outline-success">&#8377; <%=p.getDiscountedPrice()%>/- <strike
                                class="text-secondary discount-label"> &#8377; <%=p.getpPrice()%>/- </strike><span
                                class="badge badge-warning"> (<%=p.getpDiscount()%>% off)</span></a>
                            <form action="/EStore_war_exploded/UserOperationServlet" method="post">
                                <input type="hidden" name="uId" value="<%=usr.getUserId()%>">
                                <input type="hidden" name="pId" value="<%=p.getpId()%>">
                                <input type="hidden" name="op" value="deleteFavorite">
                                <button type="submit" class="btn btn-danger"> Remove</button>
                            </form>
                    </div>
                </div>
                <%}
                    if (ps.size() == 0) {%>
                        <h3 style="margin-top: 100px;text-align: center">No items in Favorites</h3>
                    <%}%>
            </div>
        </div>
    </div>
</div>

<%@include file="components/common_cart_modal.jsp" %>
</body>
</html>
