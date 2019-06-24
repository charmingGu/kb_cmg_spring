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

  <title>SB Admin 2 - Cards</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
  <script>
	  $(document).ready(function(){
		  $("#update_password_check").click(function(){
				    $.ajax({
					type:"POST",
					url:"/freeboard/freeboardpscheck",
					data : {idx:"${FBboardReadCont.idx}", password : $.trim($("#update_password").val())},
					success: function(response){
						if(response=="true"){
							location.href = "/freeboard/freeboardchangecont/${FBboardReadCont.idx}";
						}
						else{
							$("#update_password").val("");
							$("#modal_content").text("비밀번호가 올바르지 않습니다.");
						}
					}
				});
			});
		  
			$("#delete_password_check").click(function(){
				    $.ajax({
					type:"POST",
					url:"/freeboard/freeboardpscheck",
					data : {idx:"${FBboardReadCont.idx}", password : $.trim($("#delete_password").val())},
					success: function(response){
						if(response=="true"){
							location.href = "/freeboard/freeboard_delete/${FBboardReadCont.idx}";
						}
						else{
							$("#delete_password").val("");
							$("#modal_content").text("비밀번호가 올바르지 않습니다.");
						}
					}
				});
			});
			
			$(".thumbs_up_re").click(function(){
				if('${sessionScope.mb_db.id}' != ""){
					var select_tag = $(this);
					var good_idx = $(this).attr("idx");
					var user_id = "${sessionScope.mb_db.id}";
					$.ajax({
						type:"POST",
						url:"/freeboard/freeboard_good_cnt_update",
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
						url:"/freeboard/freeboard_bad_cnt_update",
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
			
			$(".delete_reply_confirm").click(function(){
				var delete_idx = $(this).attr("idx");
				var result = confirm('정말 삭제하시겠습니까?');
				if(result){
					$.ajax({
						type:"POST",
						url:"/freeboard/freeboard_delete_reply",
						data : {idx : delete_idx},
						success: function(result){
							alert("삭제가 완료되었습니다.");
							location.reload();
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
						url:"/freeboard/reply_freeboardwrite",
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
						url:"/freeboard/re_reply_freeboardwrite",
						data : {id : id, primary_board_idx : primary_board_idx, content : content, reply_board_idx : reply_board_idx},
						success: function(result){
							location.reload();
						}
					});
			});
		});
  </script>
  <style>
	#FBcontent:disabled {
	  background : #ffffff;
	}
	#FBcontent{
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
        <jsp:include page="../topbarmenu.jsp"></jsp:include>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">

          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Cards</h1>
          </div>

          <div class="row">

            <div class="col-lg-12">
              <!-- Basic Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">작성자 : ${FBboardReadCont.id} </h6>
                </div>
                <div class="card-body">
                	<h6 name="title">${FBboardReadCont.title}</h6>
                	<hr>
                	<br>
	                <textarea name="content" class="form-control col-sm-10" rows="24" id="FBcontent" disabled>${FBboardReadCont.content}</textarea>
	                <br>
	              	<!-- 문제 발생. 회원인지 아닌지 단순히 게시판 id만 보고 비교하는건 무의미. 테이블에 회원/비회원 작성인지 구분할 수 있는 속성 추가하고 그걸로 and 비교해야함. -->
	              	<c:choose>
						<c:when test="${sessionScope.mb_db.id eq FBboardReadCont.id && FBboardReadCont.mb_check eq 'mb'}">
							<a href="/freeboard/freeboardchangecont/${FBboardReadCont.idx}">
	                			<span class="btn btn-primary">수정</span>
	              			</a>
			              	<a href="/freeboard/freeboard_delete/${FBboardReadCont.idx}">
		                     	<span class="btn btn-primary">삭제</span>
		                   	</a>
						</c:when>
						<c:when test="${empty sessionScope.mb_db.id && FBboardReadCont.mb_check eq 'mb'}">
						</c:when>
						<c:when test="${not empty sessionScope.mb_db.id && sessionScope.mb_db.id ne FBboardReadCont.id && FBboardReadCont.mb_check eq 'mb'}">
						</c:when>
						<c:otherwise>
							<a href="#" data-toggle="modal" data-target="#change_data">
		                  		<span class="btn btn-primary">수정</span>
		                	</a>
		              		<a href="#" data-toggle="modal" data-target="#delete_data">
		                  		<span class="btn btn-primary">삭제</span>
		                	</a>
						</c:otherwise>
					</c:choose>
					<a href="/freeboard/freeboardindex">
	                	<span class="btn btn-primary">목록</span>
	              	</a>
	              	<br>
                </div>
                <div class="card-body">
		              	<h6>댓글쓰기</h6>
		              	<textarea name="content" class="form-control col-sm-8" rows="8" placeholder="댓글작성은 로그인 후 이용해주세요."></textarea>
		              	<a class="write_reply" onclick="return false" primary_board_idx = "${FBboardReadCont.idx}">
			              	<c:if test="${not empty sessionScope.mb_db.id}">
		                			<button class="btn btn-primary" style="margin:10px 0;">작성</button>
			              	</c:if>
		              	</a>
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
	                  	<c:forEach items="${FBboard_Reply_Cont}" var="Re_dto" varStatus="status">
		                <c:if test="${Re_dto.idx ne FBboardReadCont.idx and Re_dto.reply_board_idx eq '' }">
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
					                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#FB_idx${Re_dto.idx}" aria-expanded="true" aria-controls="collapseUtilities">
			                    	<span class="m-0 font-weight-bold text-primary">댓글창 열기</span>&nbsp&nbsp<i class="fas fa-comments fa-fw"></i>&nbsp<span>${Re_dto.reply_cnt}</span>
					                </a>
					                <!--대댓글 시작  -->
					                <hr>
						            <div id="FB_idx${Re_dto.idx}" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
						                <c:forEach items="${FBboard_Reply_Cont}" var="Re_Re_dto" varStatus="re_re_status">
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
								              	<a class="write_re_reply" primary_board_idx="${FBboardReadCont.idx}" reply_board_idx="${Re_dto.idx}">
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
            </div>
        </div>
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

  <!-- change Modal-->
  <div class="modal fade" id="change_data" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">게시글 수정</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body"><h6 id="modal_content">게시글 수정을 위해 비밀번호를 입력해주세요.</h6><br>
        <input type="password" id="update_password" class="form-control col-sm-6" placeholder="비밀번호 입력"></input>
        </div>
        <div class="modal-footer">
	       <button class="btn btn-secondary" type="button" data-dismiss="modal" aria-label="Close">
	       		취소
	       </button>
          <button class="btn btn-secondary" id="update_password_check" type="button">확인</button>
        </div>
      </div>
    </div>
  </div>
  
  <!-- delete Modal-->
  <div class="modal fade" id="delete_data" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">게시글 삭제</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body"><h6 id="modal_content">게시글 삭제를 위해 비밀번호를 입력해주세요.</h6><br>
        <input type="password" id="delete_password" class="form-control col-sm-6" placeholder="비밀번호 입력"></input>
        </div>
        <div class="modal-footer">
	       <button class="btn btn-secondary" type="button" data-dismiss="modal" aria-label="Close">
	       		취소
	       </button>
          <button class="btn btn-secondary" id="delete_password_check" type="button">확인</button>
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
