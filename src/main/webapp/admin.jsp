<%@ page import="com.estore.entities.User" %>
<%@ page import="com.estore.entities.Category" %>
<%@ page import="com.estore.dao.CategoryDao" %>
<%@ page import="com.estore.helper.FactoryProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="com.estore.dao.UserDao" %>
<%@ page import="com.estore.dao.ProductDao" %>
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

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Home</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>
<h2>Hi! <span style="color: firebrick"><%=usr.getUserName()%> </span> ,Welcome to EStore.</h2>

<div class="container admin">
    <div class="container-fluid mt-3">
        <%@include file="components/message.jsp" %>
    </div>
    <%--    first row--%>
    <div class="row mt-5">
        <%--        first column--%>
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/usersicon.png" alt="icon.png">
                    </div>
                    <h2><%=userDao.getAllUsers().size()%></h2>
                    <h1>Users</h1>
                </div>
            </div>
        </div>

        <%--        second column--%>
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/categoriesicon.png" alt="icon.png">
                    </div>
                    <h2><%=categoryDao.getCategories().size()%></h2>
                    <h1>Categories</h1>
                </div>
            </div>
        </div>

        <%--        third column--%>
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/producticon.png" alt="icon.png">
                    </div>
                    <h2><%=productDao.getAll().size()%></h2>
                    <h1>Products</h1>
                </div>
            </div>
        </div>
    </div>
    <%--    second row--%>
    <div class="row mt-4">

        <%--        first column--%>
        <div class="col-md-6">
            <div class="card text-center" data-toggle="modal" data-target="#addCategoryModal">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/addcategoryicon.png" alt="icon.png">
                    </div>
                    <h1>Add Category</h1>
                </div>
            </div>
        </div>
        <%--        second column--%>
        <div class="col-md-6">
            <div class="card text-center" data-toggle="modal" data-target="#addProductModal">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/addproducticon.png" alt="icon.png">
                    </div>
                    <h1>Add Product</h1>
                </div>
            </div>
        </div>

    </div>
</div>

<%--model--%>
<!-- Modal addCategory  start-->
<div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-control">
                    <form action="ProductOperationServlet" method="post">
                        <input type="hidden" name="op" value="addCategory">
                        <div class="form-group">
                            <label for="cat">Title</label>
                            <input type="text" id="cat" name="cat" class="form-control" placeholder="Enter Category title">
                            <label for="des">Description</label>
                            <div class="form-group">
                                <textarea style="height: 150px" id="des" name="des" class="form-control mb-3" placeholder="Enter Category description"></textarea>
                            </div>
                            <button type="submit" class="btn btn-success">Add</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%--model addCategory end--%>

<!-- Modal addProduct  start-->
<div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                        <input type="hidden" name="op" value="addProduct">
                        <div class="form-group">
                            <label for="nm">Name</label>
                            <input type="text" id="nm" name="nm" class="form-control" placeholder="Enter Name">

                            <label for="pdes">Description</label>
                            <textarea id="pdes" name="pdes" class="form-control"></textarea>

                            <label for="prc">Price</label>
                            <input type="number" id="prc" name="prc" class="form-control" placeholder="Enter Price">

                            <label for="dis">Discount</label>
                            <input type="number" id="dis" name="dis" class="form-control" placeholder="Enter discount in %">

                            <label for="qua">Quantity</label>
                            <input type="number" id="qua" name="qua" class="form-control" placeholder="Enter quantity">

                            <%
                                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                                List<Category> clist = cdao.getCategories();
                            %>
                            <div class="form-group">
                                <label for="ct">Select Category</label>
                                <select name="catId" class="form-control" id="ct">
                                    <option>Select Category</option>
                                    <%for (Category c:clist){%>
                                    <option value="<%=c.getCatId()%>"><%=c.getTitle()%></option>
                                    <%}%>
                                </select>
                            </div>

                            <label for="pht">Photo</label>
                            <input type="file" id="pht" name="pht" class="form-control mb-2" placeholder="select Photo" required>

                            <button type="submit" class="btn btn-success">Add</button>
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