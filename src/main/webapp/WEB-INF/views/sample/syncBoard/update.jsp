<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sync Board Test</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<style type="text/css">
.wrap {
	width: 700px;
	margin: 0 auto;
}
</style>
<!-- jQuery Script -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
<script type="text/javascript"
		src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("contents", {
		resize_enabled : false,
		language : "ko",
		enterMode : "2"
	});
	
	//수정버튼
	$("#updateBtn").on("click", function(){
		$("#contents").val(CKEDITOR.instances['contents'].getData());
		
		if($.trim($("#title").val()) == "") {
			alert("제목을 입력하세요.");
			$("#title").focus();
		} else if($.trim($("#pass").val()) == "") {
			alert("비밀번호를 입력하세요.");
			$("#pass").focus();
		} else if($.trim($("#contents").val()) == "") {
			alert("내용을 입력하세요.");
			$("#contents").focus();
		} else {
			$("#actionForm").attr("action", "syncAction");
			$("#actionForm").submit();
		}
	});
	
	//뒤로가기버튼
	$("#backBtn").on("click", function(){
		$("#actionForm").attr("action", "syncDetail");
		$("#actionForm").submit();
	});
});
</script>
</head>
<body>
<div class="cmn_title">동기화 게시판 샘플<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">샘플목록</div></div>
<div class="wrap">
	<form action="#" id="actionForm" method="post">
		<input type="hidden" name="gbn" value="u" />
		<input type="hidden" name="page" value="${param.page}" />
		<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
		<input type="hidden" name="searchText" value="${param.searchText}" />
		<table class="board_detail_table">
			<colgroup>
				<col width="100"/>
				<col width="600"/>
			</colgroup>
			<tbody>
				<tr>
					<th>번호</th>
					<td class="board_cont_left">${data.BOARD_NO}<input type="hidden" name="boardNo" value="${data.BOARD_NO}" /></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title" value="${data.TITLE}"/></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td class="board_cont_left">${data.WRITER}</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="pass" id="pass"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="contents" id="contents"
									  rows="10" cols="20">${data.CONTENTS}</textarea></td>
				</tr>
			</tbody>
		</table>
	</form>
	<div>
		<div class="cmn_btn_ml float_right_btn" id="backBtn">뒤로가기</div>
		<div class="cmn_btn_ml float_right_btn" id="updateBtn">수정</div>
	</div>
</div>
</body>
</html>








