<%@ page import="com.estore.dao.UserDao" %>
<%@ page import="com.estore.helper.FactoryProvider" %>
<%@ page import="com.estore.entities.Product" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.estore.dao.OrderDao" %>
<%@ page import="com.estore.entities.Order" %>
<%@ page import="java.util.List" %>

<%
    User usr = (User) session.getAttribute("current-user");
    if (usr == null) {
        session.setAttribute("msg", "You have to login to access this page");
        response.sendRedirect("login.jsp");
        return;
    }
    List<Order> ordersByUserId = new OrderDao(FactoryProvider.getFactory()).getOrdersByUserId(usr.getUserId());
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%--validation function start--%>
<script >
    function validate(){
        const unm=document.form1.unm.value;
        const eml=document.form1.eml.value;
        const cnt=document.form1.cnt.value;
        const pass1=document.form1.pwd1.value;
        const pass2=document.form1.pwd2.value;
        const adds=document.form1.adds.value;
        if (unm==""){
            window.alert("username must not be empty");
            return false;
        }
        else if(eml==""){
            window.alert("email must not be empty");
            return false;
        }
        else if(pass1.length<7){
            window.alert("password length must be greater than 7");
            return false;
        }
        else if(pass1!==pass2){
            window.alert("passwords do not match");
            return false;
        }
        else if(cnt.length<10){
            window.alert("contact number must be greater than 10");
            return false;
        }
        else if(adds==""){
            window.alert("Enter Address");
            return false;
        }
        else{
            return true;
        }
    }
</script>
<%--validation function end--%>

<%--body start--%>
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
            <div class="card text-center">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/orders.png" alt="icon.png">
                    </div>
                    <h2><%=ordersByUserId.size()%></h2>
                    <h1>Orders</h1>
                </div>
            </div>
        </div>

        <%--        third column--%>
            <% Set<Product> favoritesByUId = new UserDao(FactoryProvider.getFactory()).getFavoritesByUId(usr.getUserId());%>
        <div class="col-md-4">
            <div class="card text-center" onclick="window.location.href='favorites.jsp'">
                <div class="card-body">
                    <div class="container img-fluid">
                        <img style="max-width: 100px" src="img/favorites.png" alt="icon.png">
                    </div>
                    <h2><%=favoritesByUId.size()%></h2>
                    <h1>Favorites</h1>
                </div>
            </div>
        </div>
    </div>
</div>

<%--model--%>
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
