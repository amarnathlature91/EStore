<%@ page import="com.estore.dao.UserDao" %>
<%@ page import="com.estore.helper.FactoryProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="com.estore.entities.User" %>
<%
    List<User> ulist = new UserDao(FactoryProvider.getFactory()).getAllUsers();
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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Users</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>
<div class="container text-center" style="margin-top: 80px;max-width: 2000px">
    <h2>Users List</h2>
    <table class="table table-bordered" style="text-align: center">
        <thead class="thead-dark">
        <tr>
            <th style="width: 8%">User Name</th>
            <th style="width: 8%">Email</th>
            <th style="width: 8%">contact</th>
            <th style="width: 500px">address</th>
            <th style="width: 7%">Role</th>
            <th style="width: 7%">Edit-Role</th>
            <th style="width: 5%">Delete</th>
        </tr>
        </thead>
        <%for (User u : ulist) {%>
        <tbody>
        <tr>
            <td><%=u.getUserName()%>
            </td>
            <td><%=u.getEmail()%>
            </td>
            <td><%=u.getContact()%>
            </td>
            <td><%=u.getAddress()%>
            </td>
            <td><%=u.getRole()%></td>
            <td>
                <form action="/EStore_war_exploded/UserOperationServlet" method="post">
                    <input type="hidden" name="uId" value="<%= u.getUserId() %>">
                    <input type="hidden" name="role" value="<%=u.getRole()%>">
                    <input type="hidden" name="op" value="changeRole">
                    <button type="submit" class="btn btn-warning"
                            onclick="return confirm('Are you sure you want to Change role?')">
                        Change Role
                    </button>
                </form>
            </td>
            <td>
                <form action="/EStore_war_exploded/UserOperationServlet" method="post">
                    <input type="hidden" name="uId" value="<%= u.getUserId() %>">
                    <input type="hidden" name="op" value="deleteUser">
                    <button type="submit" class="btn btn-danger"
                            onclick="return confirm('Are you sure you want to delete this user?')">Delete
                    </button>
                </form>
            </td>
        </tr>
        </tbody>
        <%}%>
    </table>
</div>
<%@include file="components/common_cart_modal.jsp"%>

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

</body>
</html>
