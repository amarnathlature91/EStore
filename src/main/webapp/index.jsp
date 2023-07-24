<%@ page import="com.estore.dao.CategoryDao" %>
<%@ page import="com.estore.helper.FactoryProvider" %>
<%@ page import="com.estore.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.estore.dao.ProductDao" %>
<%@ page import="com.estore.entities.Product" %>
<%@ page import="com.estore.helper.Dfetcher" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>
<div style="margin-top: 80px" tabindex="-1">
    <%@include file="components/message.jsp"%>
</div>
<div class="row mt-1 mx-2">
    <%
        CategoryDao cd = new CategoryDao(FactoryProvider.getFactory());
        List<Category> cs = cd.getCategories();

        ProductDao pd = new ProductDao(FactoryProvider.getFactory());
        List<Product> ps = null;

        Dfetcher df=new Dfetcher();
        String cId = request.getParameter("cId");
        if (cId==null||cId.trim().equals("all")){
            ps=pd.getAll();
        }
        else {
            int id = Integer.parseInt(cId.trim());
            System.out.println(id);
            ps=pd.getByCategoryId(id);
        }

    %>
<%--    show categories--%>
    <div class="col-md-2 " style="position: fixed;margin-top: 30px">

        <div class="list-group mt-4">
            <a href="#" class="list-group-item list-group-item-action active">Categories</a>
            <a href="index.jsp?cId=all" class="list-group-item list-group-item-action">All Products</a>
            <%for (Category c : cs) {
            %>
            <a href="index.jsp?cId=<%=c.getCatId()%>" class="list-group-item list-group-item-action"><%=c.getTitle()%></a>
            <%
                }
            %>
        </div>
    </div>

<%--    Show products--%>
    <div class="col-md-10 ml-auto" style="margin-top: 30px">
        <div class="row mt-4" >
            <div class="col-md-12">
                <div class="card-columns">
                    <%
                        for (Product p:ps){

                    %>
                    <div class="card product-card">
                        <div class="container text-center">
                            <img class="card-img-top m-3"  style="max-height:200px;width: auto;max-width: 100%;height: 20%" src="img/product/<%=p.getpPhoto()%>" alt="<%=p.getpPhoto()%>">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><%=p.getpName()%></h5>
                            <p class="card-text"><%=df.getMini(p.getpDescription())%></p>
                        </div>
                        <div class="card-footer text-center">
                            <a href="#" class="btn btn-primary" onclick="addToCart(<%=p.getpId()%>,'<%=p.getpName()%>',<%=p.getDiscountedPrice()%>)">Add to cart</a>
                            <a href="#" class="btn btn-outline-success">&#8377; <%=p.getDiscountedPrice()%>/- <strike class="text-secondary discount-label"> &#8377; <%=p.getpPrice()%>/- </strike><span class="badge badge-warning"> (<%=p.getpDiscount()%>% off)</span></a>
                            <% User u = (User) session.getAttribute("current-user");
                            if (u== null){} else {%>
                            <form action="/EStore_war_exploded/UserOperationServlet" method="post">
                                <input type="hidden" name="uId" value="<%=u.getUserId()%>">
                                <input type="hidden" name="pId" value="<%=p.getpId()%>">
                                <input type="hidden" name="op" value="addFavorite">
                                <button type="submit" class="btn btn-secondary"> Add To Favorites</button>
                            </form>
                            <%}%>
                        </div>
                    </div>
                    <%
                        }
                        if (ps.size()==0){
                            out.println("<h3>No items in this category</h3>");
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="components/common_cart_modal.jsp" %>
</body>
</html>
