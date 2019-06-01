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

  <title>recruit make form</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  
 <script>
	 $(document).ready(function(){
	  $("#submit").click(function(){
		  var id = $("#id").text();
		  var idx = $("#idx").text();
		  var location = $("#location").val();
		  var age_limit = $("#age_limit").val();
		  var member_num_limit = $("#member_num_limit").val();
		  var study_location = $("#study_location").val();
		  var study_field = $("#study_field").val();
		  var study_content = $("#study_content").val();
		  var image_location = $("#file_up").val();
		  var recruit_title = $("#recruit_title").val();
// 		  alert(id);
// 		  alert(location);
// 		  alert(age_limit);
// 		  alert(member_num_limit);
// 		  alert(study_location);
// 		  alert(study_field);
// 		  alert(content);
// 		  alert(image_location);
		  $.ajax({
				type:"POST",
				url:"/studyboard_recruit/studyboard_recruit_update",
				data : {idx:idx, id:id, location:location, age_limit:age_limit, member_num_limit:member_num_limit, study_location:study_location, study_field:study_field, study_content:study_content, image_location:image_location, recruit_title:recruit_title},
				success: function(response){
					if(response=="true"){
						window.location.href = "/studyboard_recruit/studyboard_recruit_readcont/"+idx;
					}
					else{
						alert("수정실패");
					}
				}
			});
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
          <h1 class="h3 mb-4 text-gray-800">모집글 작성 페이지</h1>
          <div class="row">
          	<div class="col-sm-10">
				<div class="form-group">
				  <label for="host" style="color:black">모집자:${change_rc_cont.id} </label>
				  <h6 style="display:none" name="id" id="id">${change_rc_cont.id}</h6>
				  <h6 style="display:none" name="idx" id="idx">${change_rc_cont.idx}</h6>
				</div>
				<div class="form-group">
				  <label for="location">지역:</label>
				  <input type="text" class="form-control" id="location" value="${change_rc_cont.location}">
				</div>
				<div class="form-group">
				  <label for="recruit_title">제목:</label>
				  <input type="text" class="form-control" id="recruit_title" value="${change_rc_cont.title}">
				</div>
				<div class="form-group">
				  <label for="age_limit">연령 제한 설정: 10 단위로 선택해주세요. ex 20대면 20</label>
				  <select class="form-control" id="age_limit">
				  <c:set var="limit" value="${change_rc_cont.age_limit}"></c:set>
				    <option value="10" <c:if test="${limit eq 10}">selected="selected"</c:if>>10대</option>
				    <option value="20" <c:if test="${limit eq 20}">selected="selected"</c:if>>20대</option>
				    <option value="30" <c:if test="${limit eq 30}">selected="selected"</c:if>>30대</option>
				    <option value="40" <c:if test="${limit eq 40}">selected="selected"</c:if>>40대</option>
				    <option value="50" <c:if test="${limit eq 50}">selected="selected"</c:if>>50대</option>
				    <option value="60" <c:if test="${limit eq 60}">selected="selected"</c:if>>60대</option>
				    <option value="70" <c:if test="${limit eq 70}">selected="selected"</c:if>>70대</option>
				  </select>
				</div>
				<div class="form-group">
				  <label for="member_num_limit">멤버 수 설정: 10명 이상은 10을 선택해주세요.</label>
				  <select class="form-control" id="member_num_limit">
				  <c:set var="limit" value="${change_rc_cont.member_num_limit}"></c:set>
				    <option value="1" <c:if test="${limit eq 1}">selected="selected"</c:if>>1명</option>
				    <option value="2" <c:if test="${limit eq 2}">selected="selected"</c:if>>2명</option>
				    <option value="3" <c:if test="${limit eq 3}">selected="selected"</c:if>>3명</option>
				    <option value="4" <c:if test="${limit eq 4}">selected="selected"</c:if>>4명</option>
				    <option value="5" <c:if test="${limit eq 5}">selected="selected"</c:if>>5명</option>
				    <option value="6" <c:if test="${limit eq 6}">selected="selected"</c:if>>6명</option>
				    <option value="7" <c:if test="${limit eq 7}">selected="selected"</c:if>>7명</option>
				    <option value="8" <c:if test="${limit eq 8}">selected="selected"</c:if>>8명</option>
				    <option value="9" <c:if test="${limit eq 9}">selected="selected"</c:if>>9명</option>
				    <option value="10" <c:if test="${limit eq 10}">selected="selected"</c:if>>10명 이상</option>
				  </select>
				</div>
				<div class="form-group">
				  <label for="study_location">스터디 희망장소:</label>
				  <input type="text" class="form-control" id="study_location" value="${change_rc_cont.study_location}">
				</div>
				<div class="form-group">
				  <label for="study_field">스터디 분야:</label>
				  <input type="text" class="form-control" id="study_field" value="${change_rc_cont.study_field}">
				</div>
				
				<div class="form-group">
				  <label for="content">그 외 설명란 : </label>
				  <textarea class="form-control" rows="5" id="study_content">${change_rc_cont.content}</textarea>
				</div>
				
				<div class="form-group">
				<h6>썸네일로 쓸 이미지를 올려주세요.</h6>
				<input type="file" class="form-control-file border" id="file_up" value="">
				</div>
					<button id="submit" class="btn btn-primary">수정</button>
				<a class="cancel" href="/studyboard_recruit/studyboard_recruit_readcont/${change_rc_cont.idx}">
					<span class="btn btn-primary">취소</span>
				</a>
          	</div>
          	<div class="col-sm-2" style="height:750px;"><img class="img-fluid" alt="ad" src="https://source.unsplash.com/random/280x750"></div>
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
