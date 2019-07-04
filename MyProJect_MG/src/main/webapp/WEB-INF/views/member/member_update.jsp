<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html>

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>member modify page</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script>
  $(document).ready(function(){
	  $("#submit").click(function(){
		  var result = confirm('회원 정보를 수정하시겠습니까?');
		  if(result){
			  var id = $("#id").val();
			  var email = $("#email").val();
			  var password = $("#password").val();
			  var birthday = $("#birthday").val();
			  var phone = $("#phone").val();
	// 		  alert(id);
	// 		  alert(email);
	// 		  alert(password);
	// 		  alert(birthday);
	// 		  alert(phone);
			  $.ajax({
					type:"POST",
					url:"/member/updateProc",
					data : {id:id, email:email, password:password, birthday:birthday, phone:phone},
					success: function(response){
						if(response=="true"){
							alert("수정성공");
							window.location.href="/";
						}
						else{
							alert("수정실패");
							window.location.href="/";
						}
					}
				});
		  }
		});
	  
	  $("#bye_bye").click(function(){
		  var id = $(this).attr("member_id");
		  var result = confirm('정말 탈퇴하시겠습니까?');
		  var mb_check = 'mb';
		  if(result){
			  $.ajax({
					type:"POST",
					url:"/member/admin_delete",
					data : {id:id, mb_check:mb_check},
					success: function(response){
						if(response=="true"){
							alert("삭제 성공");
							window.location.href="/";
						}
						else{
							alert("삭제 실패");
							window.location.reload();
						}
					}
				});
		  }
		});
  });
  </script>

</head>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <jsp:include page="../sidebarmenu.jsp"/>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <jsp:include page="../topbarmenu.jsp"/>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <h1 class="h3 mb-4 text-gray-800">회원 정보 수정</h1>
          <div class="row">
          	<div class="col-sm-10">
				<div class="form-group">
					<label for="member_id" style="color:black">아이디: </label>
					<input type="text" class="form-control form-control-user" id="id" name="id" disabled value="${memberInfo.id}">
				</div>
				<div class="form-group">
				  <label for="email">이메일:</label>
				  <input type="email" class="form-control form-control-user" id="email" name="email" disabled value="${memberInfo.email}">
				</div>
				<div class="form-group">
				  <label for="password">비밀번호:</label>
				  <input type="password" class="form-control form-control-user" id="password" name="password" value="${memberInfo.password}">
				</div>
				<div class="form-group">
				  <label for="email">휴대폰:</label>
				  <input type="text" class="form-control form-control-user" id="phone" name="phone" value="${memberInfo.phone}">
				</div>
				<div class="form-group">
				  <label for="birthday">생년월일:</label>
				  <input type="text" class="form-control form-control-user" id="birthday" name="birthday" value="${memberInfo.birthday}">
				</div>
				<div class="form-group">
				  <label for="joindate">가입일:</label>
				  <input type="text" class="form-control form-control-user" id="joindate" name="joindate" disabled value="${memberInfo.joindate}">
				</div>
				<button id="submit" class="btn btn-primary">수정</button>
				<a class="cancel" href="/">
					<span class="btn btn-primary">취소</span>
				</a>
				<button id="bye_bye" class="btn btn-danger" member_id="${memberInfo.id}">회원탈퇴</button>
          	</div>
          </div>
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; CharMingGu 2019</span>
          </div>
        </div>
      </footer>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Bootstrap core JavaScript-->
  <script src="<c:url value="/resources/vendor/jquery/jquery.min.js" />"></script>
  <script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js" />"></script>

  <!-- Core plugin JavaScript-->
  <script src="<c:url value="/resources/vendor/jquery-easing/jquery.easing.min.js" />"></script>

  <!-- Custom scripts for all pages-->
  <script src="<c:url value="/resources/js/sb-admin-2.min.js" />"></script>

</body>

</html>
