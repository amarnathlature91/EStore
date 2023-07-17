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
    <title>Home</title>
    <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp" %>
<h2>Hi! <span style="color: firebrick"><%=usr.getUserName()%> </span> ,Welcome to EStore.</h2>


<%@include file="components/common_cart_modal.jsp" %>
</body>
</html>
