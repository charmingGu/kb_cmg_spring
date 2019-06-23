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
				  <label for="pw">비밀번호:</label>
				  <input type="password" class="form-control form-control-user" id="password" name="password" disabled value="${memberInfo.pw}">
				</div>
				<div class="form-group">
				  <label for="email">휴대폰:</label>
				  <input type="text" class="form-control form-control-user" id="phone" name="phone" disabled value="${memberInfo.phone}">
				</div>
				<div class="form-group">
				  <label for="birthday">생년월일:</label>
				  <input type="text" class="form-control form-control-user" id="birthday" name="birthday" disabled value="${memberInfo.birthday}">
				</div>
				<div class="form-group">
				  <label for="joindate">가입일:</label>
				  <input type="text" class="form-control form-control-user" id="joindate" name="joindate" disabled value="${memberInfo.joindate}">
				</div>
				<button id="submit" class="btn btn-primary">수정</button>
				<a class="cancel" href="/">
					<span class="btn btn-primary">취소</span>
				</a>
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
            <span>Copyright &copy; Your Website 2019</span>
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
