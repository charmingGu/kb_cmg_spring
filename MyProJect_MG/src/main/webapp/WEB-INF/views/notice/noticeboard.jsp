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

  <title>SB Admin 2 - Tables</title>

  <!-- Custom fonts for this template -->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

  <!-- Custom styles for this page -->
  <link href="${pageContext.request.contextPath}/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script>
	  $(document).ready(function() {
		  $('#dataTable').DataTable({
			  "order": []
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
          <h1 class="h3 mb-2 text-gray-800">공지사항</h1>
          <p class="mb-4">공지에 문의가 있으시면 아래 문의사항을 클릭하여 의견을 보내주세요.<br><a target="_blank" href="https://namu.wiki/w/%EB%84%88%EA%B5%B4%EB%A7%A8">문의사항</a></p>

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">공지사항 입니다.
              <c:if test="${sessionScope.mb_db.id == 'admin' }">
	              <a href="/notice/noticeboardwritecont">
	                <span class="btn btn-primary">글쓰기</span>
	              </a>
              </c:if>
              </h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>순번</th>
                      <th>작성자</th>
                      <th>제목</th>
                      <th>작성일자</th>
                      <th>수정일자</th>
                      <th>조회수</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>순번</th>
                      <th>작성자</th>
                      <th>제목</th>
                      <th>작성일자</th>
                      <th>수정일자</th>
                      <th>조회수</th>
                    </tr>
                  </tfoot>
                  <tbody>
                      <c:forEach items="${NBboardListView}" var="dto">
						<tr>
							<td><a href="/notice/noticeboardreadcont/${dto.idx}">${dto.idx}</a></td>
							<td>${dto.id}</td>
							<td><a href="/notice/noticeboardreadcont/${dto.idx}">${dto.title}</a></td>
							<td>${dto.write_date}</td>
							<td>${dto.rewrite_time}</td>
							<td>${dto.read_cnt}</td>
						</tr>
					</c:forEach>
                  </tbody>
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

  <!-- Page level plugins -->
  <script src="<c:url value="/resources/vendor/datatables/jquery.dataTables.min.js" />"></script>
  <script src="<c:url value="/resources/vendor/datatables/dataTables.bootstrap4.min.js" />"></script>

  <!-- Page level custom scripts -->
  <script src="<c:url value="/resources/js/demo/datatables-demo.js" />"></script>

</body>

</html>
