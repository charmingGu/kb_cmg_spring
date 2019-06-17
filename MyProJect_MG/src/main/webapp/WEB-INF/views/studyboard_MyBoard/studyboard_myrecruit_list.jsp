<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
// 			  alert(start_view);
// 			  alert(view_point);
			  var member_id = "${sessionScope.mb_db.id}";
			  if(start_view > 10){
				  $.ajax({
						type:"POST",
						url:"/studyboard_recruit/studyboard_myrecruit_pluslist",
						data : {start_view : start_view, member_id : member_id, view_point : view_point},
						dataType : "json",
						success: function(result_cnt){
							getMoreList(result_cnt);
						}
					});
			  }
			  else{
				  alert("마지막 페이지 입니다.");
			  }
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
						content += '<div class="request_list">';
						content += '<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#FB_idx$'+result_list.idx+'" aria-expanded="false" aria-controls="collapseUtilities">';
						content += '<span class="m-0 font-weight-bold text-primary">신청자 목록</span>&nbsp&nbsp<i class="fas fa-address-book"></i>';
						content += '</a>';
						content += '</div>';
						content += '<div id="FB_idx$'+result_list.idx+'" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar" style="margin:3px;">';
						content += '<div class="choice_list" style="margin:3px;">';
						var pre_request_list = result_list.request_list;
						if(pre_request_list){
							var request_list = pre_request_list.split(',');
							for(var item in request_list){
								if(item != 'null' && item != ''){
									content += '<span>'+item+'</span>';
									content += '<button class="badge badge-success" style="margin:3px;">수락</button><button class="badge badge-danger" style="margin:3px;">거절</button>';
									content += '<br>';
								}
								else{
									content += '<span>아직 신청자가 없습니다.ㅠㅠ</span>';
								}
							}
						}
						else{
							content += '<span>아직 신청자가 없습니다.ㅠㅠ</span>';
						}
						content += '</div>';
						content += '</div>';
						content += '</div>';
		   	 			content += '</div>';
		   	 			content += '</li>';
	   	    	}
	   	    	 $("#list_count li:last").after(content); 
		  }
		  
		  $(".badge.badge-success").click(function(){
			  var result = confirm('해당 유저를 멤버로 수락하시겠습니까?');
				if(result){
					var member_id = $(this).attr("member_id");
					var member_idx = $(this).attr("member_idx");
					alert(member_id);
					alert(member_idx);
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/studyboard_mycompleted_add",
						data : {idx : member_idx, member_id : member_id},
						success: function(result_cnt){
							if(result_cnt == "true"){
								alert("수락하였습니다.");
								location.reload();
							}
						}
					});
				}
			});
			
			$(".badge.badge-danger").click(function(){
				var result = confirm('정말 거절하시겠습니까?');
				var member_id = $(this).prev().attr("member_id");
				var member_idx = $(this).prev().attr("member_idx");
				if(result){
					alert(member_id);
					alert(member_idx);
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/studyboard_myrequest_cancel",
						data : {idx : member_idx, member_id : member_id},
						success: function(result_cnt){
							if(result_cnt == "true"){
								alert("거절하였습니다.");
								location.reload();
							}
						}
					});
				}
			});
			
			$(".complete_recruit").click(function(){
				var result = confirm('모집완료 하시겠습니까?');
				var idx = $(this).attr("complete_idx");
				if(result){
					alert(idx);
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/studyboard_mycompleted_added",
						data : {idx : idx},
						success: function(result_cnt){
							if(result_cnt == "true"){
								alert("모집 완료되었습니다.");
								location.reload();
							}
							else{
								alert("오류발생");
								location.reload();
							}
						}
					});
				}
			});
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
<%--           <c:if test="${not empty sessionScope.mb_db.id}"> --%>
<!-- 	          <a href="/studyboard_recruit/studyboard_recruit_form"> -->
<!-- 		          <button type="button" class="btn btn-primary">모집글 작성!</button> -->
<!-- 	          </a> -->
<%--           </c:if> --%>
			<div class="jumbotron">
			  <h1>내 모집 게시판 목록보기</h1> 
			  <p>내가 모집중인 스터디 게시판들을 보여줍니다.<br>모집이  완료되면 완료 게시판으로 이동됩니다.<br>신청자 보기를 누르시면 승인 대기중인 신청자들을 볼 수 있습니다.</p> 
			</div>
          
			<div class="row">
				<div class="col-sm-10">
				<ul class="list_count" id="list_count">
					<c:forEach items="${SBRCboardListView}" var="dto">
						<c:if test="${dto.recruit_complete eq null}">
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
							      <button class="complete_recruit btn btn-outline-primary" complete_idx="${dto.idx}">모집 완료하기</button>
							    </div>
							    <div class="request_list">
							    	<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#FB_idx${dto.idx}" aria-expanded="false" aria-controls="collapseUtilities">
				                    	<span class="m-0 font-weight-bold text-primary">신청자 목록</span>&nbsp&nbsp<i class="fas fa-address-book"></i>
					                </a>
							    </div>
							    <div id="FB_idx${dto.idx}" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar" style="margin:3px;">
							    	<div class="choice_list" style="margin:3px;">
							    	<c:set value="${dto.request_list}" var="request_list"></c:set>
							    	<c:set value="${dto.member_list}" var="pre_member_list"></c:set>
							    	<c:set value="${fn:split(pre_member_list, ',')}" var="member_list"></c:set>
								    	<c:forEach items="${fn:split(request_list, ',')}" var="item">
								    		<c:choose>
								    			<c:when test="${item ne 'null' and item ne '' and fn:contains(pre_member_list, item)}">
								    			<h6 style="margin:3px;">
								    			${item} 님이 멤버로 등록되었습니다.
								    			</h6>
								    			</c:when>
										    	<c:when test="${item ne 'null' and item ne ''}">
											    	<span>${item}</span>
											    	<button class="badge badge-success" style="margin:3px;" member_id="${item}" member_idx="${dto.idx}">수락</button><button class="badge badge-danger" style="margin:3px;">거절</button>
											    	<br>
										    	</c:when>
										    	<c:otherwise>
										    	</c:otherwise>
								    		</c:choose>
										</c:forEach>
								    </div>
							    </div>
							  </div>
							</li>
						</c:if>
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
					<button id="btn_more_list" type="button" class="btn btn-outline-primary btn-block">더보기 More</button>
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
