<%@ page import="com.estore.entities.User" %>
<%
    User usr1 = (User) session.getAttribute("current-user");
%>
<nav class="navbar navbar-expand-lg navbar-dark col-md-12" style="background:#546E7A; position: fixed;z-index: 1; top: 0">
    <a class="navbar-brand" style="color: white">EStore</a>

    <div class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">

            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">Home</a>
            </li>

            <%
                if (usr1 == null) {
            %>

            <li class="nav-item active ml-3">
                <div class="navbar-profile-picture">
                    <img src="img/user/alt_profile.png" style="width:40px; height: 40px" alt="Profile Picture" class="rounded-circle">
                </div>
            </li>

            <li class="nav-item active">
                <a class="nav-link" href="login.jsp">Account</a>
            </li>

            <%} else {%>
            <li class="nav-item active ml-3">
                <div class="navbar-profile-picture mt-0">
                    <img src="img/user/<%=usr1.getProfilePic()%>" style="width:40px; height: 40px"  class="rounded-circle">
                </div>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="<%=usr1.getRole().equals("admin")?"admin.jsp":"user.jsp"%>"><%=usr1.getUserName()%>
                </a>
            </li>
<%--            <li class="nav-item dropdown">--%>
<%--                <a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
<%--                    <%=usr1.getUserName()%>--%>
<%--                </a>--%>
<%--                <div class="dropdown-menu" aria-labelledby="navbarDropdown">--%>
<%--                    <a class="dropdown-item" href="#">Account Prefrences</a>--%>
<%--                </div>--%>
<%--            </li>--%>
            <%}%>
        </ul>
        <%--        left contents--%>
        <ul class="navbar-nav ml-auto">

            <%if (usr1 == null) { %>
            <li class="nav-item active">
                <a class="nav-link" data-toggle="modal" data-target="#cartModal">
                    <i class="fa fa-shopping-cart" style="font-size:24px"></i>
                    <span style="font-size: 15px" class="badge badge-danger cart-items">0</span>
                </a>
            </li>
            <li class="nav-item active">
                <a class="btn btn-outline-info mr-2" href="register.jsp">Register</a>
            </li>
            <li class="nav-item active">
                <a class="btn btn-outline-success mr-2" href="login.jsp">Login</a>
            </li>
            <%} else {%>
            <li class="nav-item active">
                <a class="nav-link" href="#" data-toggle="modal" data-target="#cartModal">
                    <i class="fa fa-shopping-cart" style="font-size:24px"></i>
                    <span style="font-size: 15px" class="badge badge-danger cart-items">0</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="btn btn-outline-success mr-2" href="LogoutServlet">Logout <span
                        style="color: azure"><%=usr1.getUserName()%></span></a>
            </li>
            <%}%>
        </ul>
    </div>
</nav>