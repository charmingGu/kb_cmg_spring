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
				url:"/studyboard_recruit/studyboard_recruit_submit",
				data : {id:id, location:location, age_limit:age_limit, member_num_limit:member_num_limit, study_location:study_location, study_field:study_field, study_content:study_content, image_location:image_location, recruit_title:recruit_title},
				success: function(response){
					if(response=="true"){
						window.location.href = "/studyboard_recruit/studyboard_recruit_list";
					}
					else{
						alert("실패");
						location.reload();
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
				  <label for="host" style="color:black">모집자: ${sessionScope.mb_db.id}</label>
				  <h6 style="display:none" name="id" id="id">${sessionScope.mb_db.id}</h6>
				</div>
				<div class="form-group">
				  <label for="location">지역:</label>
				  <input type="text" class="form-control" id="location" placeholder="시 단위로 입력해주세요. ex : 대구광역시">
				</div>
				<div class="form-group">
				  <label for="recruit_title">제목:</label>
				  <input type="text" class="form-control" id="recruit_title" placeholder="제목을 입력해주세요.">
				</div>
				<div class="form-group">
				  <label for="age_limit">연령 제한 설정: 10 단위로 선택해주세요. ex 20대면 20</label>
				  <select class="form-control" id="age_limit">
				    <option>10</option>
				    <option>20</option>
				    <option>30</option>
				    <option>40</option>
				    <option>50</option>
				    <option>60</option>
				    <option>70</option>
				  </select>
				</div>
				<div class="form-group">
				  <label for="member_num_limit">멤버 수 설정: 10명 이상은 10을 선택해주세요.</label>
				  <select class="form-control" id="member_num_limit">
				    <option>1</option>
				    <option>2</option>
				    <option>3</option>
				    <option>4</option>
				    <option>5</option>
				    <option>6</option>
				    <option>7</option>
				    <option>8</option>
				    <option>9</option>
				    <option>10</option>
				  </select>
				</div>
				<div class="form-group">
				  <label for="study_location">스터디 희망장소:</label>
				  <input type="text" class="form-control" id="study_location" placeholder="대학교 도서관, 카페 등 추후 멤버들과 상의 후 결정하셔도 됩니다.">
				</div>
				<div class="form-group">
				  <label for="study_field">스터디 분야:</label>
				  <input type="text" class="form-control" id="study_field" placeholder="토익, 토플, 중국어, 일본어, 고시, 공무원, 내신 등">
				</div>
				
				<div class="form-group">
				  <label for="content">그 외 설명란 : </label>
				  <textarea class="form-control" rows="5" id="study_content" placeholder="목표 점수, 선호하는 장소 등."></textarea>
				</div>
				
				<div class="form-group">
				<h6>썸네일로 쓸 이미지를 올려주세요.</h6>
				<input type="file" class="form-control-file border" id="file_up">
				</div>
				<button id="submit" type="button" class="btn btn-primary">작성</button>
				<a class="cancel" href="/studyboard_recruit/studyboard_recruit_list">
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
