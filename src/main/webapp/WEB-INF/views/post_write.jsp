<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>

<script src="https://cdn.ckeditor.com/ckeditor5/31.0.0/classic/ckeditor.js">
</script>

<script type="text/javascript">


</script>

<style type="text/css">

.ck-content{
	height: 300px;
} 




</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> 
<br>
<div align="center"  style="width: 70%; padding-left: 15%;">
	<form action="${root}/post_enrollment" method="post">
		제목 <input type="text" name="title" style=""><br><br>

		<textarea style = "height:500px" name="content" id="content_textarea"></textarea>
		<button id = "testButton">dd</button>
		<input type="submit" value="글 등록" id="submit-btn">
	</form>
</div>
	<script type="text/javascript">
	ClassicEditor
    .create(document.querySelector('#content_textarea'))
    .catch(error=>{
      console.error(error);
    });
	</script>
</body>
</html>