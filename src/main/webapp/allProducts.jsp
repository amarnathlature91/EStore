<%@ page import="com.estore.entities.Product" %>
<%@ page import="com.estore.dao.ProductDao" %>
<%@ page import="com.estore.helper.FactoryProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="com.estore.entities.Category" %>
<%@ page import="com.estore.dao.CategoryDao" %>
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

    UserDao userDao=new UserDao(FactoryProvider.getFactory());
    CategoryDao categoryDao=new CategoryDao(FactoryProvider.getFactory());
    ProductDao productDao=new ProductDao(FactoryProvider.getFactory());
    List<Order> allOrders = new OrderDao(FactoryProvider.getFactory()).getAllOrders();

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All Products</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>
<script>
        $(document).ready(function () {
        $(".edit-button").click(function () {
            var pId = $(this).data("product-id");
            var productRow = $(this).closest("tr");
            var name = productRow.find("td:nth-child(2)").text();
            var price = productRow.find("td:nth-child(3)").text();
            var discount = productRow.find("td:nth-child(4)").text();
            var quantity = productRow.find("td:nth-child(5)").text();

            console.log(price)
            console.log(discount)
            console.log(quantity)
            console.log(name)

            $("#pId").val(pId);
            $("#name").val(name);
            $("#price").val(price);
            $("#discount").val(discount);
            $("#quantity").val(quantity);

            $("#editProductModal").show();
        })
    });
</script>
<div class="container text-center" style="margin-top: 80px">
    <h1>Product List</h1>
    <form action="allProducts.jsp" method="get">
        <%
            CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
            List<Category> clist = cdao.getCategories();
        %>
        <div class="form-group">
            <label for="ct">Select Category</label>
            <select name="cId" class="form-control" id="ct">
                <%for (Category c : clist) {%>
                <option value="<%=c.getCatId()%>"><%=c.getTitle()%>
                </option>
                <%}%>
            </select>
        </div>
        <button type="submit">Search</button>
    </form>
</div>
<div class="container-fluid text-center">
    <%-- Java code to handle the search and display products --%>
    <%
        String categoryIdStr = request.getParameter("cId");
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            int categoryId = Integer.parseInt(categoryIdStr);
            List<Product> products = new ProductDao(FactoryProvider.getFactory()).getByCategoryId(categoryId);

            if (!products.isEmpty()) {
    %>
    <h2>Products in Category:</h2>
        <div class="container text-center" style="margin-top: 80px;max-width: 2000px">
            <table class="table table-hover" style="text-align: center">
                <thead class="thead-dark">
                <tr>
                    <th style="width: 7%">Product ID</th>
                    <th style="width: 80%">Product Name</th>
                    <th style="width: 10%">Price</th>
                    <th style="width: 5%">Discount</th>
                    <th style="width: 5%">Quantity</th>
                    <th style="width: 5%">Edit</th>
                    <th style="width: 5%">Delete</th>
                </tr>
                </thead>
                <% for (Product p : products) { %>
                <tbody>
                <tr>
                    <td><%=p.getpId()%>
                    </td>
                    <td><%=p.getpName()%>
                    </td>
                    <td><%=p.getpPrice()%>
                    </td>
                    <td><%=p.getpDiscount()%>
                    </td>
                    <td><%=p.getpQuantity()%>
                    </td>
                    <td>
                        <button type="submit" data-product-id="<%=p.getpId()%>" data-toggle="modal" data-target="#editProductModal"
                                class="edit-button btn btn-primary">
                            Edit
                        </button>
                    </td>
                    <td>
                        <form action="/EStore_war_exploded/ProductOperationServlet" method="post">
                            <input type="hidden" name="op" value="deleteProduct">
                            <input type="hidden" name="pId" value="<%=p.getpId()%>">
                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Are you sure you want to delete this product?')">Delete
                            </button>
                        </form>
                    </td>
                </tr>
                </tbody>
                <%}%>
            </table>
        </div><% }else {
                %>
        <p>No products found in Category.</p>
        <%
    }}%>
</div>

<!-- Modal addProduct  start-->
<div class="modal fade" id="editProductModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" >Add Product</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-control">
                    <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="op" value="updateProduct">
                        <input type="hidden" id="pId" name="pId" value="">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" id="name" name="name" class="form-control" placeholder="Enter Name">

                            <label for="price">Price</label>
                            <input type="text" id="price"  name="price" class="form-control" placeholder="Enter Price">

                            <label for="discount">Discount</label>
                            <input type="text" id="discount" name="discount" class="form-control" placeholder="Enter discount in %">

                            <label for="quantity">Quantity</label>
                            <input type="text" id="quantity" name="quantity" class="form-control" placeholder="Enter quantity">

                            <label for="pht">Photo</label>
                            <input type="file" id="pht" name="photo" class="form-control mb-2" placeholder="select Photo">

                            <button type="submit" class="btn btn-success">Save</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%--model addProduct end--%>

<%@include file="components/common_cart_modal.jsp" %>
</body>
</html>