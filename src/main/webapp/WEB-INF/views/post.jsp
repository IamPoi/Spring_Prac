<%@page import="com.example.demo.model.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지금 우리 동네는</title>
<link rel="shortcut icon" type="image/x-icon" href="https://upload.wikimedia.org/wikipedia/commons/4/40/Home_Icon_by_Lakas.svg">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
	
<% UserDTO dto = (UserDTO)session.getAttribute("user");%>

<script type="text/javascript">

// 테이블 클릭 이벤트 (수정,삭제로 인한 보류)
/* $(function() {
	$("#example-table-1 tbody").on("click","tr",function(){
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
		var no = td.eq(0).text();
		
		str +=	"No." + no;
		console.log(no)
		
		location.href = 'post_detail?no='+no;
		
	});
}); */



$(function(){
	$(".updateBtn").on("click",function(){
		
		var str = ""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		
		var no = td.eq(0).text();
		
		if(confirm("수정하시겠습니까??")){
		location.href ='post_update?no='+no;
		}
	});
});


$(function(){
	$(".deleteBtn").on("click",function(){
		
		var str = ""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		
		var no = td.eq(0).text();
		if(confirm("삭제하시겠습니까??")){
		location.href ='post_delete?no='+no;
		}
	});
});



</script>
</head>

<body>

<%@ include file = "/WEB-INF/views/menu.jsp" %>
<br>
<div class="row" style = "padding-left: 15%; width: 85%; display:inline-block" >
	<div class = "center" align="center"><h2>${sessionScope.user_location.dong} 게시판</h2></div>
	
		<form action="post_search" method="get">
		<div align="center">
			<input type="text" placeholder="검색 할 내용" name = "search" style ='width: 20rem;'>
			<button class = "btn btn-success" type="submit">Search</button>
		</div>
		</form>
	</div>
	
<c:if test="${fn:length(post_list) == 0}">
	<div class="row" style = "padding-left: 15%; width: 85%; overflow: auto; display:inline-block">
	<h1 align="center">${sessionScope.user_location.dong} 게시판에 <br>첫번째 게시글을 등록해주세요.</h1>
</c:if>

<c:if test="${fn:length(post_list) < 8}">
	<div class="row" style = "padding-left: 15%; width: 85%; overflow: auto; display:inline-block">
</c:if>
<c:if test="${fn:length(post_list) >= 8}">
	<div class="row" style = "padding-left: 15%; width: 85%; overflow: auto; height: 500px; display:inline-block">
</c:if>
	
	
	<a href="post_write" id = "post-write" class = "btn btn-info" style = "color: #DCFFDC; float:right;">글쓰기</a>

	<table id="example-table-1" style = "width : 100%;" class="table table-striped table-hover text-center">
	<thead>
		<tr>
			<th>No.</th>
			<th>Title</th>
			<th>Writer</th>
		</tr>
	</thead>
	
	<tbody>	
		<c:forEach items="${post_list}" var = "post">
			<tr>
				<td>${post.post_num}</td>
				<td><a  style = "color : black" href="post_detail?no=${post.post_num}">${post.title}</a></td>
				<c:set var = "id" value="<%=dto.getId()%>"></c:set>
						<td>${post.writer_id}</td>
				
			</tr>
		</c:forEach>
	</tbody>
	</table>

</div>	


</body>
</html>