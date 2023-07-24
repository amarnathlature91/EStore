<%@ page import="com.estore.entities.User" %>
<%@ page import="com.estore.entities.Category" %>
<%@ page import="com.estore.dao.CategoryDao" %>
<%@ page import="com.estore.helper.FactoryProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="com.estore.dao.UserDao" %>
<%@ page import="com.estore.dao.ProductDao" %>
<%@ page import="com.estore.dao.OrderDao" %>
<%@ page import="com.estore.entities.Order" %>
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
            <div class="card text-center" data-toggle="modal" data-target="#accountPrefModal">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/settings.png" alt="icon.png">
                    </div>
                    <h1>Account Preferences</h1>
                </div>
            </div>
        </div>

        <%--        second column--%>
        <div class="col-md-4">
            <div class="card text-center" onclick="window.location.href='orders.jsp'">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/orders.png" alt="icon.png">
                    </div>
                    <h2><%=allOrders.size()%></h2>
                    <h1>Orders</h1>
                </div>
            </div>
        </div>

        <%--        third column--%>
        <div class="col-md-4">
            <div class="card text-center" onclick="window.location.href='searchOrder.jsp'">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/favorites.png" alt="icon.png">
                    </div>
                    <h1>Search Order By OrderId</h1>
                </div>
            </div>
        </div>
    </div>
<%--second row--%>
<div class="row mt-4">
        <%--        first column--%>
        <div class="col-md-4">
            <div class="card text-center" onclick="window.location.href='allUsers.jsp'">
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
            <div class="card text-center" onclick="window.location.href='allCategories.jsp'">
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
            <div class="card text-center" onclick="window.location.href='allProducts.jsp'">
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
    <%--    third row--%>
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
<%--    third row--%>
    <div class="row mt-4">
        <div class="col-md-12">
            <div class="card text-center" onclick="window.location.href='favorites.jsp'">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img src="img/favorites.png" height="150px" width="150px">
                        <h1>Favorites</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<%--model--%>
<!-- Modal addCategory  start-->
<div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel1" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel1">Add Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-control">
                    <form action="/EStore_war_exploded/CategoryOperationServlet" method="post">
                        <input type="hidden" name="op" value="addCategory">
                        <div class="form-group">
                            <label for="cat">Title</label>
                            <input type="text" id="cat" name="cat" class="form-control" placeholder="Enter Category title">
                            <label for="des">Description</label>
                            <div class="form-group">
                                <textarea class="form-control"style="height: 150px" id="des" name="des"></textarea>
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

<!-- model Account Preferences  start-->
<div class="modal fade" id="accountPrefModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Account Preferences</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-control">
                    <form action="AccountPref" enctype="multipart/form-data" method="post">
                        <input type="hidden" name="userid" value="<%=usr.getUserId()%>">
                        <div class="form-group">
                            <label for="unm">User Name</label>
                            <input type="text" value="<%=usr.getUserName()%>" name="unm" class="form-control" id="unm"  placeholder="Enter User Name">
                        </div>
                        <div class="form-group">
                            <label for="eml">Email</label>
                            <input type="email" value="<%=usr.getEmail()%>" name="eml" class="form-control" id="eml"  placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label for="psw1">Password</label>
                            <input type="password" value="<%=usr.getPassword()%>" name="pwd1" class="form-control" id="psw1"  placeholder="Enter Password">
                        </div>
                        <div class="form-group">
                            <label for="psw2">Re-Enter Password</label>
                            <input type="password" value="<%=usr.getPassword()%>" name="pwd2" class="form-control" id="psw2"  placeholder="Re-Enter Password">
                        </div>
                        <div class="form-group">
                            <label for="cnt">Contact</label>
                            <input type="number" value="<%=usr.getContact()%>" name="cnt" class="form-control" id="cnt"  placeholder="Enter Contact number">
                        </div>
                        <div class="form-group">
                            <label for="adds">Address</label>
                            <textarea class="form-control" name="adds" id="adds" placeholder="Enter Address"><%=usr.getAddress()%></textarea>
                        </div>
                        <div class="form-group">
                            <label for="fl">Profile</label>
                            <input type="file" name="fl" class="form-control" id="fl">
                        </div>
                        <div class="form-group">
                            <label for="dl">Delete Existing Profile</label>
                            <input type="hidden" name="dl" value="yes" id="dl">
                            <input type="submit" value="Delete" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete existing profile?')" />
                        </div>
                        <div class="container text-center">
                            <button type="submit" class="btn btn-info">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%--model Account Preferences end--%>


<%@include file="components/common_cart_modal.jsp" %>
</body>
</html>