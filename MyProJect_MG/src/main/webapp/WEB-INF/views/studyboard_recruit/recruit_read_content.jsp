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

  <title>recruit make form</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  
 <script>
	 $(document).ready(function(){
		 $("#delete_button").click(function(){
				var delete_idx = $(this).attr("idx");
				var result = confirm('정말 삭제하시겠습니까?');
				if(result){
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/studyboard_recruit_delete",
						data : {idx : delete_idx},
						success: function(result){
							alert("삭제가 완료되었습니다.");
							location.href="/studyboard_recruit/studyboard_recruit_list";
						}
					});
				}
			});
		 
		 $("#join_st_member").click(function(){
				var join_idx = "${read_rc_cont.idx}";
				var member_id = "${sessionScope.mb_db.id}";
				var result = confirm('해당 스터디로 신청하시겠습니까?');
				if(result){
					alert(join_idx);
					alert(member_id);
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/studyboard_recruit_join",
						data : {idx : join_idx, id : member_id},
						success: function(result){
							if(result == "true"){
								alert("신청이 완료되었습니다.");
								location.href="/studyboard_recruit/studyboard_recruit_list";
							}
							else{
								alert("이미 신청하셨습니다.");
							}
						}
					});
				}
			});
		 
		 $(".write_reply").click(function(){
				var select_tag = $(this);
				var primary_board_idx = $(this).attr("primary_board_idx");
				var id = "${sessionScope.mb_db.id}";
				var content = select_tag.prev().val();
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/reply_SBRCboardwrite",
						data : {id : id, primary_board_idx : primary_board_idx, content : content},
						success: function(result){
							location.reload();
						}
					});
			});
		 
		 $(".write_re_reply").click(function(){
				var select_tag = $(this);
				var primary_board_idx = $(this).attr("primary_board_idx");
				var id = "${sessionScope.mb_db.id}";
				var content = select_tag.prev().val();
				var reply_board_idx = $(this).attr("reply_board_idx");
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/re_reply_SBRCboardwrite",
						data : {id : id, primary_board_idx : primary_board_idx, content : content, reply_board_idx : reply_board_idx},
						success: function(result){
							location.reload();
						}
					});
			});
		 
		 $(".delete_reply_confirm").click(function(){
				var delete_idx = $(this).attr("idx");
				var result = confirm('정말 삭제하시겠습니까?');
				if(result){
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/reply_delete_SBRCboardwrite",
						data : {idx : delete_idx},
						success: function(result){
							alert("삭제가 완료되었습니다.");
							location.reload();
						}
					});
				}
			});
		 
		 $(".thumbs_up_re").click(function(){
				if('${sessionScope.mb_db.id}' != ""){
					var select_tag = $(this);
					var good_idx = $(this).attr("idx");
					var user_id = "${sessionScope.mb_db.id}";
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/SBRCboard_good_cnt_update",
						data : {idx : good_idx, id : user_id},
						success: function(result_cnt){
							select_tag.next().text(result_cnt);
						}
					});
				}
				else{
					alert("로그인이 필요합니다.");
				}
			});
			
			$(".thumbs_down_re").click(function(){
				if('${sessionScope.mb_db.id}' != ""){
					var select_tag = $(this);
					var bad_idx = $(this).attr("idx");
					var user_id = "${sessionScope.mb_db.id}";
					$.ajax({
						type:"POST",
						url:"/studyboard_recruit/SBRCboard_bad_cnt_update",
						data : {idx : bad_idx, id : user_id},
						success: function(result_cnt){
							select_tag.next().text(result_cnt);
						}
					});
				}
				else{
					alert("로그인이 필요합니다.");
				}
			});
		  
		 });
 
</script>

<style>
	.card{
		margin : 0 auto;
	}
	.read_button{
		margin : 0 auto;
	}
	#RCcontent:disabled {
	  background : #ffffff;
	}
	#RCcontent{
		border:0;
		overflow-y:hidden;
		background:clear;
	}
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
          <div class="row">
          	<div class="col-sm-10">
				<div class="col-sm-8 card">
				<br>
		          <h1 class="h3 mb-4 text-gray-800" style="text-align:center">자세한 내용</h1>
		          <hr>
		          <c:if test="${read_rc_cont.image_location eq null}">
		          	<img class="img-fluid" alt="image" style="width:100%; height:auto;" align="middle" src="${pageContext.request.contextPath}/resources/img/undraw_posting_photo.svg">
		          </c:if>
		          <c:if test="${read_rc_cont.image_location ne null}">
		          	<img class="img-fluid" alt="image" style="width:100%; height:auto;" align="middle" src="<spring:url value="/img/STRC/${read_rc_cont.id}/${read_rc_cont.image_location}"/>">
		          </c:if>
		          <hr>
				  <h6 name="id" id="id">모집자 : ${read_rc_cont.id}</h6>
				  <hr>
				  <p>제목 : ${read_rc_cont.title}</p>
				  <hr>
				  <p>지역 : ${read_rc_cont.location}</p>
				  <hr>
				  <p>연령 제한 : ${read_rc_cont.age_limit}대</p>
				  <hr>
				  <p>인원 제한 : ${read_rc_cont.member_num_limit}명</p>
				  <hr>
				  <p>희망 스터디 장소 : ${read_rc_cont.study_location}</p>
				  <hr>
				  <p>스터디 분야 : ${read_rc_cont.study_field}</p>
				  <hr>
				  <p>기타 사항</p>
				  <textarea name="content" class="form-control col-sm-10" rows="12" id="RCcontent" disabled>${read_rc_cont.content}</textarea>
				</div>
				<br>
				<div class="col-sm-8 read_button">
				<c:if test="${not empty sessionScope.mb_db.id and read_rc_cont.id eq sessionScope.mb_db.id}">
					<a  href="/studyboard_recruit/studyboard_recruit_change_cont/${read_rc_cont.idx}" class="submit">
						<button class="btn btn-primary">수정</button>
					</a>
					<button id="delete_button" class="btn btn-danger" idx="${read_rc_cont.idx}">삭제</button>
				</c:if>
				<c:if test="${not empty sessionScope.mb_db.id and read_rc_cont.id ne sessionScope.mb_db.id}">
					<button class="btn btn-primary" id="join_st_member">신청</button>
				</c:if>
				<div class="card-body">
		              	<h6>댓글쓰기</h6>
		              	<textarea name="content" class="form-control col-sm-12" rows="8" placeholder="댓글작성은 로그인 후 이용해주세요."></textarea>
		              	<a class="write_reply" onclick="return false" primary_board_idx = "${read_rc_cont.idx}">
			              	<c:if test="${not empty sessionScope.mb_db.id}">
		                			<button class="btn btn-primary" style="margin:10px 0;">작성</button>
			              	</c:if>
		              	</a>
                </div>
				</div>
				<!-- Collapsable Card Example -->
	              <div class="card shadow mb-4">
	                <!-- Card Header - Accordion -->
	                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="border:solid 1px #FFF">
	                  	<thead>
		                    <tr>
		                      <th>댓글목록</th>
		                      <!-- 메인 댓글 시작 -->
		                    </tr>
		                 </thead>
	                  	<c:forEach items="${STRC_Reply_Cont}" var="Re_dto" varStatus="status">
		                <c:if test="${Re_dto.idx ne read_rc_cont.idx and Re_dto.reply_board_idx eq '' }">
		                 <tbody>
		                 	<tr>
								<td><a style="color:black">${Re_dto.id}</a></td>
							</tr>
		                    <tr>
			                   	<td>
					                <h6 style="color:black">${Re_dto.content}</h6>
					                <br>
					                <a href="#" onclick="return false" class="thumbs_up_re" idx="${Re_dto.idx}">
					                	<i class="fas fa-thumbs-up fa-fw"></i>
					                </a>&nbsp
					                <span class="thumbs_up_value">${Re_dto.good_cnt}</span>
					                &nbsp&nbsp
					                <a href="#" onclick="return false" class="thumbs_down_re" idx="${Re_dto.idx}"><i class="fas fa-thumbs-down fa-fw"></i></a>&nbsp<span class="thumbs_down_value">${Re_dto.bad_cnt}</span>
					                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span>작성일   ${Re_dto.write_date}</span>
					                <c:if test="${not empty sessionScope.mb_db.id and sessionScope.mb_db.id eq Re_dto.id}">
						                <a href="#" onclick="return false" class="delete_reply_confirm" idx="${Re_dto.idx}">
							                <button class="btn btn-outline-primary btn-sm" style="margin:10px 0;">삭제</button>
						                </a>
					                </c:if>
					                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#SBRC_idx${Re_dto.idx}" aria-expanded="true" aria-controls="collapseUtilities">
			                    	<span class="m-0 font-weight-bold text-primary">댓글창 열기</span>&nbsp&nbsp<i class="fas fa-comments fa-fw"></i>&nbsp</h6>
					                </a>
					                <!--대댓글 시작  -->
					                <hr>
						            <div id="SBRC_idx${Re_dto.idx}" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
						                <c:forEach items="${STRC_Reply_Cont}" var="Re_Re_dto" varStatus="re_re_status">
						                <c:if test="${Re_Re_dto.reply_board_idx ne '' and Re_dto.idx eq Re_Re_dto.reply_board_idx}">
									      	<div class="bg-white py-2 collapse-inner rounded">
									            <h6 style="color:black" class="collapse-header" id="re_reply_cont" name="re_reply_cont"><span>&nbsp&nbsp&nbsp</span>${Re_Re_dto.id}</h6><hr>
									            <h6 style="color:black"><span>&nbsp&nbsp&nbsp</span>${Re_Re_dto.content}</h6>
									            &nbsp&nbsp&nbsp&nbsp
									            <a href="#" onclick="return false" class="thumbs_up_re" idx="${Re_Re_dto.idx }">
									            	<i class="fas fa-thumbs-up fa-fw"></i></a>&nbsp
									            <span class="thumbs_up_value">${Re_Re_dto.good_cnt}</span>&nbsp&nbsp
								                &nbsp&nbsp&nbsp&nbsp
								                <a href="#" onclick="return false" class="thumbs_down_re" idx="${Re_Re_dto.idx }">
								                	<i class="fas fa-thumbs-down fa-fw"></i>
								                </a>&nbsp<span class="thumbs_down_value">${Re_Re_dto.bad_cnt}</span>
								                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span>작성일   ${Re_Re_dto.write_date}</span>
								                <c:if test="${not empty sessionScope.mb_db.id and sessionScope.mb_db.id eq Re_Re_dto.id}">
									                <a href="#" onclick="return false" class="delete_reply_confirm" idx="${Re_Re_dto.idx }">
										                <button class="btn btn-outline-primary btn-sm" style="margin:10px 0;">삭제</button>
									                </a>
								                </c:if>
									      	</div>
									      	<hr>
						                </c:if>
						                </c:forEach>
						            	<div class="card-body">
								              	<h6>댓글쓰기</h6>
								              	<textarea name="content" class="form-control col-sm-8" rows="5" placeholder="댓글작성은 로그인 후 이용해주세요."></textarea>
								              	<a class="write_re_reply" primary_board_idx="${read_rc_cont.idx}" reply_board_idx="${Re_dto.idx}">
									              	<c:if test="${not empty sessionScope.mb_db.id}">
								                		<button class="btn btn-primary" style="margin:10px 0;">작성</button>
								                	</c:if>
								              	</a>
					                	</div>
							        </div>
				                </td>
		                    </tr>
		                 </tbody>
		              </c:if>
		              </c:forEach>
	                  </table>
	              </div>
          	</div>
          	<div class="col-sm-2" style="height:750px;">
          		<img class="img-fluid" alt="ad" src="https://source.unsplash.com/random/280x750">
          		<embed height="300" width="100%" src="http://www.gagalive.kr/livechat2.swf?chatroom=${read_rc_cont.title}&user=${sessionScope.mb_db.id}"></embed>
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
