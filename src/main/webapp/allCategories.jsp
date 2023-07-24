<%@ page import="java.util.List" %>
<%@ page import="com.estore.entities.Category" %>
<%@ page import="com.estore.dao.CategoryDao" %>
<%@ page import="com.estore.helper.FactoryProvider" %>
<%@ page import="com.estore.entities.User" %>
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
    List<Category> clist = new CategoryDao(FactoryProvider.getFactory()).getCategories();
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All Categories</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<script>
    $(document).ready(function () {
        $(".edit-button").click(function () {
            var cId = $(this).data("category-id");
            console.log(cId)
            var categoryRow = $(this).closest("tr");
            var title = categoryRow.find("td:nth-child(2)").text();
            var description = categoryRow.find("td:nth-child(3)").text();

            $("#cId").val(cId);
            $("#title").val(title);
            $("#description").val(description);

            $("#editCategoryModal").show();
        })
    });

        // Close the modal when the close button is clicked
        $(".close-button").click(function () {
            $("#editCategoryModal").hide();
        });
</script>
<%@include file="components/navbar.jsp" %>
<%@include file="components/message.jsp"%>
<div class="container text-center" style="margin-top: 80px;max-width: 2000px">
    <h2>All Categories</h2>
    <table class="table table-hover" style="text-align: center">
        <thead class="thead-dark">
        <tr>
            <th style="width: 7%">Category ID</th>
            <th style="width: 15%">Category Title</th>
            <th style="width: 80%">Category Description</th>
            <th style="width: 5%">Edit</th>
            <th style="width: 5%">Delete</th>
        </tr>
        </thead>
        <%for (Category c : clist) {%>
        <tbody>
        <tr>
            <td><%=c.getCatId()%>
            </td>
            <td><%=c.getTitle()%>
            </td>
            <td><%=c.getDescription()%>
            </td>
            <td>
                <button type="submit" data-category-id="<%=c.getCatId()%>" data-toggle="modal" data-target="#editCategoryModal"
                        class="edit-button btn btn-primary">
                    Edit
                </button>
            </td>
            <td>
                <form action="/EStore_war_exploded/CategoryOperationServlet" method="post">
                    <input type="hidden" name="op" value="deleteCategory">
                    <input type="hidden" name="cId" value="<%= c.getCatId() %>">
                    <button type="submit" class="btn btn-danger"
                            onclick="return confirm('Are you sure you want to delete this category?')">Delete
                    </button>
                </form>
            </td>
        </tr>
        </tbody>
        <%}%>
    </table>
</div>

<!-- Modal for editing category details -->
<div id="editCategoryModal" class="modal fade" style="margin-top: 100px" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLabel1" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel1">Edit Category</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/EStore_war_exploded/CategoryOperationServlet" method="post">
                    <input type="hidden" name="op" value="updateCategory">
                    <div class="form-group">
                        <input type="hidden" name="cId" value="" id="cId">
                        <label for="title">Title:</label><br>
                        <input type="text" name="title" id="title" class="form-control"
                               placeholder="Enter Category title"><br>
                        <label for="description">Description:</label><br>
                        <div class="form-group">
                            <textarea class="form-control" style="height: 150px" name="description"
                                      id="description"></textarea><br>
                        </div>
                        <input type="submit" class="btn btn-secondary" value="Save">
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>


<%@include file="components/common_cart_modal.jsp" %>
</body>
</html>
