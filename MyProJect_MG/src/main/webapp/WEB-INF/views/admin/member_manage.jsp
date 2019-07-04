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

  <title>SB Admin 2 - Blank</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  
  <!-- Custom styles for this page -->
  <link href="${pageContext.request.contextPath}/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script>
	  $(document).ready(function() {
		  $('#dataTable').DataTable({
			  "order": []
		  });
		  
		  $(".admin_delete").click(function(){
			  var id = $(this).attr("member_id");
			  var result = confirm('정말 회원을 삭제하시겠습니까?');
			  var mb_check = 'ad';
			  if(result){
				  $.ajax({
						type:"POST",
						url:"/member/admin_delete",
						data : {id:id, mb_check:mb_check},
						success: function(response){
							if(response=="true"){
								alert("삭제 성공");
								window.location.reload();
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
          <h1 class="h3 mb-4 text-gray-800">회원 관리 모드</h1>
          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">회원관리
              </h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                <c:if test="${sessionScope.mb_db.id eq 'admin'}">
                  <thead>
                    <tr>
                      <th>순번</th>
                      <th>회원아이디</th>
                      <th>가입일자</th>
                      <th>기타</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>순번</th>
                      <th>회원아이디</th>
                      <th>가입일자</th>
                      <th>기타</th>
                    </tr>
                  </tfoot>
                  <tbody>
	                  <c:forEach items="${member_table}" var="dto">
						<tr>
							<td><a href="/member/myProfile/${dto.id}">${dto.idx}</a></td>
							<td><a href="/member/myProfile/${dto.id}">${dto.id}</a></td>
							<td>${dto.joindate}</td>
							<td><button class="btn btn-danger admin_delete" member_id="${dto.id}">회원 삭제</button></td>
						</tr>
					</c:forEach>
                  </tbody>
                </c:if>
                </table>
              </div>
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
  
  <!-- Page level plugins -->
  <script src="<c:url value="/resources/vendor/datatables/jquery.dataTables.min.js" />"></script>
  <script src="<c:url value="/resources/vendor/datatables/dataTables.bootstrap4.min.js" />"></script>

  <!-- Page level custom scripts -->
  <script src="<c:url value="/resources/js/demo/datatables-demo.js" />"></script>

</body>

</html>
