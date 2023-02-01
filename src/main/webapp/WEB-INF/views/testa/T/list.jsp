<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트 list</title>

<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css"/>
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css"/>
<script type="text/javascript" src="resources/script/common/popup.js"></script>
<style type="text/css">
#searchTxt{
	width: 161px;
	height: 28px;
	padding: 0 2px;
	text-indent: 5px;
	vertical-align: middle;
	border: 1px solid #d7d7d7;
	outline-color: #70adf9;
}

.board_area{
	width: 800px;
	margin: 0 auto;
}

.search_area{
	width: 800px;
	text-align: right;
	margin: 0 auto;
}

.att{
	display: inline-block;
	vertical-align: top;
	width : 18px;
	height: 18px;
	background-image: url('resources/images/attFile.png');
	background-size: cover;
}

#cateNo{
      min-width: 100px;
      height: 30px;
      vertical-align: middle;
      border: 1px solid #d7d7d7;
      float: left;
}
</style>

<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js">
</script>

<script type="text/javascript">
$(document).ready(function() {
	
	if("${param.searchGbn}" != ""){
		$("#searchGbn").val("${param.searchGbn}");
	}else{
		$("#oldGbn").val("0");
	}
	
	
	//카테고리 설정
	if("${param.cateNo}" != ""){
		$("#cateNo").val("${param.cateNo}");
	}
	
	//카테고리가 변경됐을때 무언가를 하겠다.
	$("#cateNo").on("change", function() {
		
		//검색 및 페이징 초기화
		$("#page").val("1");
		$("#searchGbn").val("0");
		$("#searchTxt").val("");
		$("#oldGbn").val("0");
		$("#oldTxt").val("");
		
		//목록조회
		reloadList();
		
	});
	
	reloadList();
	
	//검색버튼
	$("#searchBtn").on("click", function() {
		$("page").val("1");
		
		//신규 상태 등록(검색구분, 검색어 유지하려고)
		$("#oldGbn").val($("#searchGbn").val());
		$("#oldTxt").val($("#searchTxt").val());
		
		//몰고을 다시 화면에 그렸으면 좋겠엉!
		reloadList();
	});
	
	//페이징버튼(동적으로 만든 화면이라서 paging_area를 통해서 접근해야한다.)
	$(".paging_area").on("click", "span", function name() {
		
		//기본 검색상태 유지(검색구분, 검색어 유지하려고)
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		
		//페이지 속성에 값을 서버에 보낸 <id=page>에 담아서 보내기
		$("#page").val($(this).attr("page"));
		
		reloadList();
	});
	
	//등록 버튼
	$("#insertBtn").on("click", function() {
		//기존 검색상태 유지
		$("#serachGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action", "ATDetail");
		$("#actionForm").submit();
	});
	
	//행을 누르면 상세보기 이동!
	$("tbody").on("click", "tr", function() {
		
		$("#no").val($(this).attr("no"));
		
		//기존 검색상태 유지
		$("#searchGbn").val($("#oldGbn").val());
		$("#searchTxt").val($("#oldTxt").val());
		
		$("#actionForm").attr("action","ATDetail");
		$("#actionForm").submit();
		
	});
});//document

function reloadList() {
	var params = $("#actionForm").serialize();
	
	$.ajax({
		url : "ATListAjax",
		type:"POST",
		dataType : "json",
		data : params,
		success:function(res){//res에 list와 pd가 넘어온다.
			drawList(res.list);
			drawPaging(res.pd);
		},
		error:function(request, status, error){
			console.log(request.responseText);
		}
		
	});
}

function drawList(list) {
	var html = "";
	
	for(var data of list){
		html += "<tr no=\""+data.NO+"\">";//속성에 값 넣을 때 "+값+"
		html +="<th>"+data.NO+"</th>";
	}
}

</script>
</head>
<body>

</body>
</html>