<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Register</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  
  <script>
	  $(document).ready(function(){
		  $("#join_button").click(function(){
			  var id = $("#id").val();
			  var pw = $("#pw").val();
			  var phone = $("#phone").val();
			  var email = $("#email").val();
			  var birthday = $("#birthday").val();
			  
			  if(id == "" || pw == "" || phone == "" || email == "" || birthday == ""){
				  alert("회원정보를 모두 입력해주세요.");
			  }
			  else{
				  $.ajax({
						type:"POST",
						url:"/member/joinProc",
						data : {id:id, pw:pw, phone:phone, email:email, birthday:birthday},
						success: function(response){
							if(response=="true"){
								window.location.href = "/";
							}
							else{
								alert("가입실패");
								window.location.href = "/member/join";
							}
						}
					});
			  }
		  });
	  });
  </script>
</head>

<body class="bg-gradient-primary">

  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
              </div>
<!--               <form action="/member/joinProc" method="post"> -->
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" class="form-control form-control-user" id="id" name="id" placeholder="아이디">
                  </div>
                  <div class="col-sm-6">
                    <input type="password" class="form-control form-control-user" id="pw" name="pw" placeholder="패스워드">
                  </div>
                </div>
                <div class="form-group">
                  <input type="email" class="form-control form-control-user" id="email" name="email" placeholder="이메일">
                </div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" class="form-control form-control-user" id="phone" name="phone" placeholder="휴대폰 번호 - 없이">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" class="form-control form-control-user" id="birthday" name="birthday" placeholder="주민번호 7자리 ex 900505-1">
                  </div>
                </div>
                <button class="btn btn-primary btn-user btn-block" id="join_button">
                  	회원 등록
                </button>
                <hr>
                <a href="/" class="btn btn-google btn-user btn-block">
                  	취소
                </a>
                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                  <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                </a>
<!--               </form> -->
              <hr>
              <div class="text-center">
                <a class="small" href="forgot-password.html">Forgot Password?</a>
              </div>
              <div class="text-center">
                <a class="small" href="login.html">Already have an account? Login!</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="<c:url value="/resources/vendor/jquery/jquery.min.js" />"></script>
  <script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js" />"></script>

  <!-- Core plugin JavaScript-->
  <script src="<c:url value="/resources/vendor/jquery-easing/jquery.easing.min.js" />"></script>

  <!-- Custom scripts for all pages-->
  <script src="<c:url value="/resources/js/sb-admin-2.min.js" />"></script>

</body>

</html>
