<%@page import="com.example.demo.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지금 우리 동네는</title>
<link rel="shortcut icon" type="image/x-icon" href="https://upload.wikimedia.org/wikipedia/commons/4/40/Home_Icon_by_Lakas.svg">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

<%
UserDTO dto = (UserDTO) session.getAttribute("user");
%>
<c:set var="id" value="<%=dto.getId()%>"></c:set>

<script type="text/javascript">


$(function(){
	$(".postUpdate").on("click",function(){
		
		var str = ""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		
		var no = '${post_detail.post_num}';
		
		if(confirm("수정하시겠습니까??")){
		location.href ='post_update?no='+no;
		}
	});
});


$(function(){
	$(".postDelete").on("click",function(){
		
		var str = ""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		
		var no = '${post_detail.post_num}';
		if(confirm("삭제하시겠습니까??")){
		location.href ='post_delete?no='+no;
		}
	});
});


$(document).ready(function() {
	$("#commentBtn").click(function() {
	const url = new URL(window.location.href);
	const no = url.searchParams;
	if(confirm("등록하시겠습니까??")){
		$("#commentForm").attr("action", "${root}/comment_write?no="+no.get('no')).submit();
	}
	})
});


$(function(){
	$(".input-c").focusout(function(){
		
		$('.div-c').css("display","block");
		$('.input-c').css("display","none");
		
	});	
});

$(function(){
	$("#deleteBtn").on("click",function(){
		
		var str = ""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		
		var comment_num = td.eq(0).text();
		
		const url = new URL(window.location.href);
		const urlPa = url.searchParams;
		var no =urlPa.get('no')
		if(confirm("삭제하시겠습니까??")){
		location.href = 'comment_delete?no='+no+'&comment_num='+comment_num;
		}
	});
});



$(function(){
	$("#updateBtn").on("click",function(){
		
		var str = ""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		
		var comment_num = td.eq(0).text();
		
		const url = new URL(window.location.href);
		const urlPa = url.searchParams;
		var no =urlPa.get('no');
		
		
		var content = $("."+comment_num+"_input").val();
		
		//console.log(comment_num)
		//console.log(content);
		
		if(confirm("수정하시겠습니까??")){
		location.href = 'comment_update?no='+no+'&comment_num='+comment_num+'&content='+content;
		}
	});
});

$(function() {
	$("#example-table-1>tbody").on("dblclick","tr",function(){
		
		<%dto = (UserDTO) session.getAttribute("user");%>
	
		$('.div-c').css("display","block");
		$('.input-c').css("display","none");
		
		var str = ""
		var tdArr = new Array();	// 배열 선언
		// 현재 클릭된 Row(<tr>)
		var tr = $(this);
		var td = tr.children();
		
		// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
		td.each(function(i){
			tdArr.push(td.eq(i).text());
		});
		
		// td.eq(index)를 통해 값을 가져올 수도 있다.
		var comment_num = td.eq(0).text();
		var writer = td.eq(2).text().split(",",1)[0];
		writer = writer.trim()
		
		console.log("1 : ",comment_num);
		console.log("2 : ",writer);
		
		var id = '<%=String.valueOf(dto.getId())%>';
		
		console.log("3 : ",id)
		
			if (writer == id) {

				console.log("????")
				var div = $("." + comment_num + "_div");

				var input = $("." + comment_num + "_input");

				div.css("display", "none");
				input.css("display", "block");

				input.focus();
			}

		});
	});

	$(function() {
		$("#decl-button").on('click', function() {

			const url = new URL(window.location.href);
			const urlPa = url.searchParams;
			var no = urlPa.get('no');

			if (confirm("신고하시겠습니까??")) {
				location.href = "declaration?no=" + no;
			}

		})
	})
</script>

</head>
<body>


	<%@ include file="/WEB-INF/views/menu.jsp"%>

	<div style="width: 85%; padding-left: 15%;">
	<br>

		<h1 align="center">제목 : ${post_detail.title}</h1>
		<div align="right"><span style="display: none;">번호 : ${post_detail.post_num}</span> 작성자 : ${post_detail.writer_id}</div>
		<br>
		<div align="center">
			<img align="middle" alt="" src="../img/${post_detail.img}">
		</div>
		<br> <br>
		<div align="center">
			<strong>${post_detail.content}</strong>
		</div>
		<br> <br> <br> <br>
		<div align="right">
		<c:set var="id" value="<%=dto.getId()%>"></c:set>
		<c:choose>
			<c:when test="${post_detail.writer_id == id}">
				<button class="postUpdate btn btn-success">수정</button>
				<button class="postDelete btn btn-success">삭제</button>
			</c:when>
			<c:otherwise>
				<button style="visibility: hidden;">수정</button>
				<button style="visibility: hidden;">수정</button>
			</c:otherwise>

		</c:choose>
		</div>
		<section class="table-section">
			<table class="table table-striped text-center" id="example-table-1" style="width: 100%; position: relative;">
				<thead>
					<tr>
						<td>댓글 번호</td>
						<td>댓글 내용</td>
						<td>댓글 작성자</td>
					</tr>
				</thead>
				<tbody class="tbody-c">
					<c:forEach items="${comment_list}" var="comment">
						<tr>
							<td>${comment.comment_num}</td>
							<td>
								<div class="${comment.comment_num}_div div-c">${comment.content}</div>
								<div align="center" style = ""> 
								<input id="replyModify" style="display: none;width : 10rem;" class="${comment.comment_num}_input input-c" type="text" name="${comment.comment_num}" value="${comment.content}">
								</div>
							</td>
							<c:choose>
								<c:when test="${comment.comment_writer == id}">
									<td><span>${comment.comment_writer}</span>
										<p style="display: none">,</p>
										<button type = "button" id ="updateBtn" class="btn btn-success">수정</button>
										<button type = "button" id ="deleteBtn"class="btn btn-success">삭제</button>
									</td>
								</c:when>
								<c:otherwise>
									<td>${comment.comment_writer}<button style="visibility: hidden;" class="delteBtn">삭제</button>
										<button style="visibility: hidden;" class="delteBtn">삭제</button>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</section>

		<div>
			<form action="comment_write" method="post" id="commentForm">
				<textarea rows="" cols="" name="content" class="form-control"></textarea>
				<div align="right">
				<br>
					<button id="commentBtn" class="btn btn-primary" type="button">등록</button>
					<c:set var="session" value="${sessionScope.user}"></c:set>
					<c:set var="reporter" value="${reporter}"></c:set>

					<c:forEach items="${reporter}" var="rep">
						<c:if test="${rep == session.id}">
							<c:set var="result" value="false"></c:set>
						</c:if>
					</c:forEach>

					<c:if test="${result != false}">
						<button type="button" id="decl-button" class="btn btn-danger">신고</button>
					</c:if>

					<c:if test="${result == false}">
						<button type="button" id="decl-button" disabled="disabled" class="btn btn-danger">신고완료</button>
					</c:if>
				</div>
			</form>
			<br><br>

		</div>
	</div>

</body>
</html>