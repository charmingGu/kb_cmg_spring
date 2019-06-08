<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
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
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	 <script>
	  $(document).ready(function(){
		  $("#btn_more_list").click(function(){
			  var start_view = $(".list_count li").length+1;
			  var view_point = start_view+9;
			  $.ajax({
					type:"POST",
					url:"/studyboard_recruit/studyboard_recruit_pluslist",
					data : {start_view : start_view, view_point : view_point},
					dataType : "json",
					success: function(result_cnt){
						getMoreList(result_cnt);
					}
				});
			});
		  
		  function getMoreList(list){
	   	    	var content = "";
	   	    	var length = list.length;
	   	    	if(length == 0){
	   	    		alert("마지막입니다.");
	   	    	}
	   	    	for(i=0; i<list.length; i++){
	   	    		var result_list = list[i];
		   	    		content += '<li class="study_recu_list">';
		   	   	    	content += '<div class="card" style="width:400px">';
		   	   	    	if(result_list.image_location != null){
		   	   	  			content += '<img class="img-fluid" alt="Card image" style="width:100%; height:auto;" src="<spring:url value="/img/STRC/'+result_list.id+'/'+result_list.image_location+'"/>" align="middle" style="margin:1px 0;">';
		   	   	    	}
		   	   	    	if(result_list.image_location == null){
				   	 		content += '<img class="img-fluid" alt="Card image" style="width:100%; height:auto;" src="${pageContext.request.contextPath}/resources/img/undraw_posting_photo.svg" align="middle" style="margin:1px 0;">';
		   	   	    	}
		   	 	    	content += '<div class="card-body">';
		   	 	    	content += '<h4 class="card-title">'+result_list.id+'</h4>';
		   	 	    	content += '<p class="card-text">'+result_list.title+'</p>';
		   	 			content += '<a href="/studyboard_recruit/studyboard_recruit_readcont/'+result_list.idx+'"'+'class="btn btn-primary">자세히 보기</a>';
		   	 			content += '</div>';
		   	 			content += '</div>';
		   	 			content += '</li>';
	   	    	}
	   	    	 $("#list_count li:last").after(content); 
		  }
	  });
	  </script>
	 
	 <style>
		.study_recu_list
		{
			display: inline-block;
		       padding: 10px;
		}
/* 		.thumbnail-wrappper  */
/* 		{ width: 25%; height: 200px; overflow: hidden; } */
	 </style>
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
          <c:if test="${not empty sessionScope.mb_db.id}">
	          <a href="/studyboard_recruit/studyboard_recruit_form">
		          <button type="button" class="btn btn-primary">모집글 작성!</button>
	          </a>
          </c:if>
          
			<div class="row">
				<div class="col-sm-10">
				<ul class="list_count" id="list_count">
					<c:forEach items="${SBRCboardListView}" var="dto">
						<li class="study_recu_list">
				          <div class="card" style="width:400px; overflow: hidden;">
				          	<c:if test="${dto.image_location ne null}">
						    	<img class="img-fluid" alt="Card image" style="width:100%; height:auto;" src="<spring:url value="/img/STRC/${dto.id}/${dto.image_location}"/>" align="middle" style="margin:1px 0;">
				          	</c:if>
				          	<c:if test="${dto.image_location eq null}">
						    	<img class="img-fluid" alt="Card image" style="width:100%; height:auto;" src="${pageContext.request.contextPath}/resources/img/undraw_posting_photo.svg" align="middle" style="margin:1px 0;">
				          	</c:if>
						    <div class="card-body">
						      <h4 class="card-title">${dto.id}</h4>
						      <p class="card-text">${dto.title}</p>
						      <a href="/studyboard_recruit/studyboard_recruit_readcont/${dto.idx}" class="btn btn-primary">자세히 보기</a>
						    </div>
						  </div>
						</li>
					</c:forEach>
				</ul>
				</div>
				<div class="col-sm-2 ad" style="height:750px;">
					<h1 class="adMark" style="text-align: center">광고영역</h1>
					<img class="img-fluid" alt="ad" src="https://source.unsplash.com/random/280x750">
				</div>
			</div>
	        <div class="row">
		        <div class="col-sm-10">
					<button  id="btn_more_list" type="button" class="btn btn-outline-primary btn-block">더보기 More</button>
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
