<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AjaxBoard Test</title>
<link rel="shortcut icon" href="resources/favicon/favicon.ico">
<link rel="stylesheet" type="text/css" href="resources/css/common/cmn.css" />
<!-- Popup CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/common/popup.css" />
<style type="text/css">
.search_area {
	width: 700px;
	text-align: right;
	margin: 0 auto;
}

.board_area {
	width: 700px;
	margin: 0 auto;
}

.board_detail_table tbody .pconr {
	height: 220px;
}

.board_detail_table tbody .pcon {
	overflow: auto;
	width: 600px;
    height: 220px;
}

.pass_check {
	width: 172px;
	height: 28px;
	padding: 0px 2px;
	text-indent: 5px;
	vertical-align: middle;
	border: 1px solid #d7d7d7;
	outline-color: #70adf9;
}
</style>
<!-- jQuery -->
<script type="text/javascript" 
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" 
		src="resources/script/common/common.js"></script>
<!-- Popup Script -->
<script type="text/javascript" 
		src="resources/script/common/popup.js"></script>
<script type="text/javascript"
		src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	readContents();
	
	/* 
		Write Event
	*/
	$("#writeBtn").on("click", function(){
		var html = "";
		
		html += "		<form id=\"boardForm\">                                                          		";
		html += "			<table class=\"board_detail_table\">                                                                    			";
		html += "				<colgroup>                                                             			";
		html += "					<col width=\"100\"/>                                                		";
		html += "					<col width=\"600\"/>                                               		";
		html += "				</colgroup>                                                            			";
		html += "				<tbody>                                                                   			";
		html += "				<tr>                                                                   			";
		html += "					<th>??????</th>                                                      			";
		html += "					<td><input type=\"text\" size=\"78\" name=\"title\" id=\"title\" /></td>    ";
		html += "				</tr>                                                                  			";
		html += "				<tr>                                                                   			";
		html += "					<th>?????????</th>                                                    			";
		html += "					<td><input type=\"text\" size=\"78\" name=\"writer\" id=\"writer\" /></td>  ";
		html += "				</tr>                                                                  			";
		html += "				<tr>                                                                   			";
		html += "					<th>????????????</th>                                                  			";
		html += "					<td><input type=\"password\" size=\"78\" name=\"pass\" id=\"pass\" /></td>  ";
		html += "				</tr>                                                                  			";
		html += "				<tr>                                                                   			";
		html += "					<th>??????</th>                                                  			";
		html += "					<td>                                                   		";
		html += "						<textarea rows=\"23\" name=\"contents\" id=\"contents\"></textarea>";
		html += "					</td>                                                              			";
		html += "				</tr>                                                                  			";
		html += "				</tbody>                                                                  			";
		html += "			</table>                                                                  		    ";
		html += "		</form>                                                                      			";
		
		makePopup({
			depth : 1,
			width : 720,
			height : 500,
			bg : true,
			bgClose : false,
			title : "?????????",
			contents : html,
			contentsEvent : function() {
				CKEDITOR.replace("contents", {
					height : 120,
					resize_enabled : false,
					language : "ko",
					enterMode : "2"
				});
				
				$("#title").focus();
			},
			draggable : false,
			buttons : [{
				name : "??????",
				func:function() {
					$("#contents").val(CKEDITOR.instances['contents'].getData());
					checkInput("I", function() {
						var params = $("#boardForm").serialize();
						console.log(params);
						$.ajax({
							type : "post",
							url : "ajaxBoardInsertResult",
							dataType : "json",
							data : params,
							success : function(result) {
								$("#page").val(1);
								
								$("#searchGbn").val(0);
								$("#searchText").val("");
								
								readContents();
								
								closePopup(1);
								
								makeAlert("??????", "????????? ??????????????????.");
								
							},
							error : function(result) {
								makeAlert("??????", "????????? ??????????????????.");
							}
						});
					});
				}
			}, {
				name : "??????"
			}]
		});
	});
	
	/* 
		Paging Event
	*/
	$(".paging_area").on("click", "span", function(){
		$("#page").val($(this).attr("name"));
		
		$("#searchGbn").val($("#lastSearchGbn").val());
		$("#searchText").val($("#lastSearchText").val());
		
		readContents();
	});
	
	/* 
		Search Event
	*/
	$("#searchBtn").on("click", function(){
		$("#page").val(1);
		$("#lastSearchGbn").val($("#searchGbn").val());
		$("#lastSearchText").val($("#searchText").val());
		
		readContents();
	});
	
	/* 
		Board Event
	*/
	$("#contentsArea").on("click", "tr", function(){
		$("input[name='boardNo']").val($(this).attr("no"));
		
		readDetail(0);
	});
});

/* 
	List Reload Event
*/
function readContents() {
	var params = $("#readForm").serialize();

	$.ajax({
		type : "post",
		url : "ajaxBoardReadList",
		dataType : "json",
		data : params,
		success : function(result) {
			
			if(result.message == "SUCCESS") {
				redrawList(result.list);
				redrawPaging(result.pd);
			} else {
				makeAlert("??????", "????????? ????????? ??????????????????.<br/>??????????????? ???????????????.");
			}
		},
		error : function(result) {
			makeAlert("??????", "????????? ????????? ??????????????????.<br/>??????????????? ???????????????.");
		}
	});
}

/* 
	List Redraw Event
*/
function redrawList(list) {
	var html = "";
	
	if(list.length == 0 && $("#page").val() == 1) {
		html += "<tr>";
		html += "<td colspan=\"5\">????????? ???????????? ????????????.</td>";
		html += "</tr>";
	} else if(list.length == 0 && $("#page").val() != 1) {
		$("#page").val($("#page").val() - 1);
		
		readContents();
	} else {
		for(var i = 0 ; i < list.length ; i++) {
			html += "<tr no=\"" + list[i].BOARD_NO + "\">";
			html += "<td>" + list[i].BOARD_NO + "</td>";
			html += "<td class=\"board_table_hover board_cont_left\">" + list[i].TITLE + "</td>";
			html += "<td>" + list[i].WRITER + "</td>";
			html += "<td>" + list[i].WRITE_DATE + "</td>";
			html += "<td>" + list[i].HIT_CNT + "</td>";
			html += "</tr>";
		}
		
	}
	
	$("#contentsArea").html(html);
}

/* 
	Paging Redraw Event
*/
function redrawPaging(pd) {
	var html = "";
	
	html += "<span class=\"page_btn page_first\" name=\"1\">??????</span>";
	
	if(1 >= $("#page").val()) {
		html += "<span class=\"page_btn page_prev\" name=\"1\">??????</span>";
	} else {
		html += "<span class=\"page_btn page_prev\" name=\"" + ($("#page").val() - 1) + "\">??????</span>";
	}
	
	for(var i = pd.startP ; i <= pd.endP ; i++) {
		if(i == $("#page").val()) {
			html += "<span class=\"page_btn_on\" name=\"" + i + "\">" + i + "</span>";
		} else {
			html += "<span class=\"page_btn\" name=\"" + i + "\">" + i + "</span>";
		}
	}
	
	if(pd.maxP <= $("#page").val()) {
		html += "<span class=\"page_btn page_next\" name=\"" + pd.maxP + "\">??????</span>";
	} else {
		html += "<span class=\"page_btn page_next\" name=\"" + ($("#page").val() + 1) + "\">??????</span>";
	}
	
	html += "<span class=\"page_btn page_last\" name=\"" + pd.maxP + "\">??????</span>";
	
	$(".paging_area").html(html);
}

/* 
	Detail Popup Event
*/
function readDetail(num) {
	var params = $("#boardNo").serialize();
	var url = "ajaxBoardReadDetail";
	
	if(num == 1) {
		url = "ajaxBoardReadNoHitDetail";
	}
	
	$.ajax({
		type : "post",
		url : url,
		dataType : "json",
		data : params,
		success : function(result) {
			var html = "";
			
			html += "		<form id=\"boardForm\">                                                          		";
			html += "			<input type=\"hidden\" name=\"boardNo\" value=\"" + result.params.BOARD_NO + "\" />	              		";
			html += "			<table class=\"board_detail_table\">                                                                    			";
			html += "				<colgroup>                                                             			";
			html += "					<col width=\"100\"/>                                                		";
			html += "					<col width=\"600\"/>                                               		";
			html += "				</colgroup>                                                            			";
			html += "				<tr>                                                                   			";
			html += "					<th>??????</th>                                                      			";
			html += "					<td class=\"board_cont_left\">" + result.params.TITLE + "</td>";
			html += "				</tr>                                                                  			";
			html += "				<tr>                                                                   			";
			html += "					<th>?????????</th>                                                    			";
			html += "					<td class=\"board_cont_left\">" + result.params.WRITER + "</td>           				  	";
			html += "				</tr>                                                                  			";
			html += "				<tr>                                                                   			";
			html += "					<th>?????????</th>                                                  			";
			html += "					<td class=\"board_cont_left\">" + result.params.WRITE_DATE + "</td>     							      	";
			html += "				</tr>                                                                  			";
			html += "				<tr>                                                                   			";
			html += "					<th>?????????</th>                                                  			";
			html += "					<td class=\"board_cont_left\">" + result.params.HIT_CNT + "</td>           								";
			html += "				</tr>                                                                  			";
			html += "				<tr class=\"pconr\">                                                                   			";
			html += "					<th>??????</th>                                                  			";
			html += "					<td class=\"board_cont_left\">    						                           		";
			html += "					<div class=\"pcon\">    						                           		";
			html += result.params.CONTENTS;
			html += "					</div>                                                              			";
			html += "					</td>                                                              			";
			html += "				</tr>                                                                  			";
			html += "			</table>                                                                  		    ";
			html += "		</form>         	                                                         		    ";
			
			makePopup({
				depth : 2,
				width : 720,
				height : 500,
				bg : true,
				bgClose : false,
				title : "????????????",
				contents : html,
				draggable : false,
				buttons : [{
					name : "??????",
					func:function() {
						checkPass(function(result) {
							if(result == "TRUE") {
								closePopup(2);
								updatePopup();
							} else {
								makeAlert("??????", "??????????????? ???????????????.");
							}
						});
					}
				}, {
					name : "??????",
					func:function() {
						checkPass(function(result) {
							if(result == "TRUE") {
								var params = $("#boardForm").serialize();
								
								$.ajax({
									type : "post",
									url : "ajaxBoardDeleteResult",
									dataType : "json",
									data : params,
									success : function(result) {
										closePopup(2);
										readContents();
										makeAlert("??????", "?????????????????????.");
									},
									error : function(result) {
										makeAlert("??????", "????????? ??????????????????.");
									}
								});
							} else {
								makeAlert("??????", "??????????????? ???????????????.");
							}
						});
					}
				}, {
					name : "??????"
				}]
			});
		},
		error : function(result) {
			makeAlert("??????", "????????? ??????????????????.");
		}
	});
}

/* 
	Update Popup
*/
function updatePopup() {
var params = $("#boardNo").serialize();
	
	$.ajax({
		type : "post",
		url : "ajaxBoardReadNoHitDetail",
		dataType : "json",
		data : params,
		success : function(result) {
			var html = "";
			
			html += "		<form id=\"boardForm\">                                                          		";
			html += "			<input type=\"hidden\" name=\"boardNo\" value=\"" + result.params.BOARD_NO + "\" />	              		";
			html += "			<table class=\"board_detail_table\">                                                                    			";
			html += "				<colgroup>                                                             			";
			html += "					<col width=\"100\"/>                                                		";
			html += "					<col width=\"600\"/>                                               		";
			html += "				</colgroup>                                                            			";
			html += "				<tr>                                                                   			";
			html += "					<th>??????</th>                                                      			";
			html += "					<td>								         			     	";
			html += "					<input type=\"text\" name=\"title\" id=\"title\" value=\"" + result.params.TITLE + "\" />	              		";
			html += "					</td>     											    			     	";
			html += "				</tr>                                                                  			";
			html += "				<tr>                                                                   			";
			html += "					<th>?????????</th>                                                    			";
			html += "					<td class=\"board_cont_left\">" + result.params.WRITER + "</td>           				  	";
			html += "				</tr>                                                                  			";
			html += "				<tr>                                                                   			";
			html += "					<th>?????????</th>                                                  			";
			html += "					<td class=\"board_cont_left\">" + result.params.WRITE_DATE + "</td>     							      	";
			html += "				</tr>                                                                  			";
			html += "				<tr>                                                                   			";
			html += "					<th>?????????</th>                                                  			";
			html += "					<td class=\"board_cont_left\">" + result.params.HIT_CNT + "</td>           								";
			html += "				</tr>                                                                  			";
			html += "				<tr class=\"pconr\">                                                                   			";
			html += "					<th>??????</th>                                                  			";
			html += "					<td>    						                           		";
			html += "					<textarea name=\"contents\" id=\"contents\">" + result.params.CONTENTS + "</textarea>";
			html += "					</td>                                                              			";
			html += "				</tr>                                                                  			";
			html += "			</table>                                                                  		    ";
			html += "		</form>";
			
			makePopup({
				depth : 3,
				width : 720,
				height : 500,
				bg : true,
				bgClose : false,
				title : "?????????",
				contents : html,
				contentsEvent : function() {
					CKEDITOR.replace("contents", {
						height : 80,
						resize_enabled : false,
						language : "ko",
						enterMode : "2"
					});

					$("#title").focus();
				},
				draggable : false,
				buttons : [{
					name : "??????",
					func:function() {
						$("#contents").val(CKEDITOR.instances['contents'].getData());
						
						checkInput("U", function() {
							var params = $("#boardForm").serialize();
							
							$.ajax({
								type : "post",
								url : "ajaxBoardUpdateResult",
								dataType : "json",
								data : params,
								success : function(result) {
									closePopup(3);
									readDetail(1);
									readContents();
									
									makeAlert("??????", "?????????????????????.");
								},
								error : function(result) {
									makeAlert("??????", "????????? ??????????????????.");
								}
							});
						});
					}
				}, {
					name : "??????",
					func:function() {
						closePopup(3);
						readDetail(1);
					}
				}]
			});
		},
		error : function(result) {
			makeAlert("??????", "????????? ??????????????????.");
		}
	});
}

/* 
	Input Data Check
*/
function checkInput(type, event) {
	var result = true;
	if($.trim($("#title").val()) == "") {
		makeAlert("??????", "????????? ????????? ?????????");
		
		$("#title").focus();
		
		result = false;
	}
	if(type == "I" && $.trim($("#writer").val()) == "") {
		makeAlert("??????", "???????????? ????????? ?????????");
		
		$("#writer").focus();
		
		result = false;
	}
	if(type == "I" && $.trim($("#pass").val()) == "") {
		makePopup("??????", "??????????????? ????????? ?????????");
		
		$("#pass").focus();
		
		result = false;
	}
	if($.trim($("#contents").val()) == "") {
		makeAlert("??????", "????????? ????????? ?????????");
		
		$("#contents").focus();
		
		result = false;
	}
	
	if(result) {
		event();
	}
}

/* 
	Contents Password Check
*/
function checkPass(event) {
	var html = "";
	
	html += "		<form action=\"#\" id=\"passCheckForm\" method=\"post\">  						          ";
	html += "			<input type=\"password\" class=\"pass_check\" name=\"pass\" id=\"pass\" placeholder=\"??????????????? ??????????????????.\" />                                  ";
	html += "			<input type=\"hidden\" name=\"boardNo\" id=\"checkBoardNo\" />  	                 ";
	html += "		</form>                                                                                    ";
	
	makePopup({
		depth : 4,
		width : 200,
		height : 130,
		bg : true,
		bgClose : false,
		title : "???????????? ??????",
		contents : html,
		contentsEvent : function() {
			$("#passCheckForm #pass").focus();
		},
		draggable : false,
		buttons : [{
			name : "??????",
			func:function() {
				$("#checkBoardNo").val($("#boardNo").val());
				
				var params = $("#passCheckForm").serialize();
				
				$.ajax({
					type : "post",
					url : "ajaxBoardPassCheckResult",
					dataType : "json",
					data : params,
					success : function(result) {
						event(result.result);
						closePopup(4);
					},
					error : function(result) {
						makeAlert("??????", "????????? ??????????????????.");
						closePopup(4);
					}
				});
			}
		}, {
			name : "??????"
		}]
	});
}
</script>
</head>
<body>
<div class="cmn_title">???????????? ????????? ??????<div class="cmn_btn_mr float_right_btn" id="sampleListBtn">????????????</div></div>
<input type="hidden" name="boardNo" id="boardNo" />
<div class="search_area">
	<form action="#" id="readForm" method="post">
	<input type="hidden" id="lastSearchGbn" value="0"/>
	<input type="hidden" id="lastSearchText" />
	<input type="hidden" id="page" name="page" value="1"/>
	<select id="searchGbn" name="searchGbn">
		<option value="0" selected="selected">??????</option>
		<option value="1">?????????</option>
		<option value="2">??????</option>
	</select>
	<input type="text" id="searchText" name="searchText" />
	<div class="cmn_btn_ml" id="searchBtn">??????</div>
	<div class="cmn_btn_ml" id="writeBtn">?????????</div>
	</form>
</div>
<div class="board_area">
	<table class="board_table">
		<colgroup>
			<col width="100"/>
			<col width="400"/>
			<col width="150"/>
			<col width="150"/>
			<col width="100"/>
		</colgroup>
		<thead>
			<tr>
				<th>??????</th>
				<th>??????</th>
				<th>?????????</th>
				<th>?????????</th>
				<th>?????????</th>
			</tr>
		</thead>
		<tbody id="contentsArea">
			<tr>
				<td colspan="5">????????? ???????????? ????????????.</td>
			</tr>
		</tbody>
	</table>
	<div class="paging_area"></div>
</div>
</body>
</html>