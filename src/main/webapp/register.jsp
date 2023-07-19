<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>New User Registration</title>
  <%@include file="components/common_css_js.jsp" %>
</head>
<body>
<%@include file="components/navbar.jsp"%>

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
<div class="container-fluid" style="margin-top: 80px">
  <div class="row mt-5">
    <div class="col-md-3 offset-md-4">
      <div class="card">

        <%@include file="components/message.jsp"%>
        <div class="card-body bg-light ">

          <div class="text-center">
            <img src="img/signupicon.png" style="max-width: 70px" class="img-fluid"  alt="SignUp.png">
          </div>

          <h2 class="text-center my-3">Sign Up</h2>
          <form name="form1" action="RegisterServlet" method="post" enctype="multipart/form-data" onsubmit="return validate()">
            <div class="form-group">
              <label for="unm">User Name</label>
              <input type="text" name="unm" class="form-control" id="unm"  placeholder="Enter User Name">
            </div>
            <div class="form-group">
              <label for="eml">Email</label>
              <input type="email" name="eml" class="form-control" id="eml"  placeholder="Enter email">
            </div>
            <div class="form-group">
              <label for="psw1">Password</label>
              <input type="password" name="pwd1" class="form-control" id="psw1"  placeholder="Enter Password">
            </div>
            <div class="form-group">
              <label for="psw2">Re-Enter Password</label>
              <input type="password" name="pwd2" class="form-control" id="psw2"  placeholder="Re-Enter Password">
            </div>
            <div class="form-group">
              <label for="cnt">Contact</label>
              <input type="number" name="cnt" class="form-control" id="cnt"  placeholder="Enter Contact number">
            </div>
            <div class="form-group">
              <label for="adds">Address</label>
              <textarea class="form-control" name="adds" id="adds" placeholder="Enter Address"></textarea>
            </div>
            <div class="form-group">
              <label for="fl">Profile</label>
              <input type="file" name="fl" class="form-control" id="fl">
            </div>
            <div class="container text-center">
              <a href="login.jsp">Already registered?,Login here</a>
            </div>
            <div class="container text-center">
              <button type="submit" class="btn btn-info">Register</button>
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
