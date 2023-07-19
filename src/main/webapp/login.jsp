
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Login</title>
    <%@include file="components/common_css_js.jsp"%>
</head>
<body>
<%@include file="components/navbar.jsp"%>
<script>

    function validate(){
        const eml=document.form2.eml.value;
        const pwd=document.form2.pwd.value;
        if (eml==""){
            window.alert("Enter email");
            return false;
        }
        else if (pwd==""){
            window.alert("Enter password");
            return false;
        }
    }

</script>

<div class="container-fluid">
    <div class="row" style="margin-top: 80px">
        <div class="col-md-3 offset-md-4">
            <div class="card">
                <%@include file="components/message.jsp"%>
                <div class="card-body bg-light ">

                    <div class="text-center">
                        <img src="img/loginicon.png" style="max-width: 80px" class="img-fluid"  alt="SignUp.png">
                    </div>

                    <h2 class="text-center my-3">Login</h2>
                    <form name="form2" action="LoginServlet" method="post" onsubmit="return validate()">
                        <div class="form-group">
                            <label for="eml">Email</label>
                            <input type="email" name="eml" class="form-control" id="eml"  placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label for="psw">Password</label>
                            <input type="password" name="pwd" class="form-control" id="psw"  placeholder="Enter password">
                        </div>
                        <a href="register.jsp" class="text-center d-block mb-2">New here?, click here to register</a>
                        <div class="container text-center">
                            <button type="submit" class="btn btn-info">Login</button>
                            <button type="reset" class="btn btn-danger">Reset</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
<%@include file="components/common_cart_modal.jsp" %>
</body>
</html>
