<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!-- 	<script type="text/javascript" -->
<!-- 		src="resources/script/jquery/jquery-1.12.4.min.js"></script> -->
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>	<!-- �׻� �ֽŹ��� -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
			$.getJSON("resources/json/jsonData.json", function(data) {
				
				//���� ó��
				let member_data = "";
				$.each(data, function(key, value){//�Ķ����
					//key�� index
					//value�� key:value
					member_data += "<tr>";
					member_data += "<td>"+value.id+"</td>";
					member_data += "<td>"+value.name+"</td>"; 
					member_data += "<td>"+value.age+"</td>"; 
					member_data += "<td>"+value.address+"</td>"; 
					member_data += "<td>"+value.gender+"</td>"; 
					member_data += "<td>"+value.job+"</td>"; 
					member_data += "<td>"+value.hobby+"</td>"; 
					member_data += "</tr>";
				});
				
				$("#member_table").append(member_data); //tbody������ �˾Ƽ� �ٴ´�.
				
			});			
		});
		
	</script>
</head>
<body>
	<div class="container">
		<h4>JSON data to WebPage table with getJSON method</h4>
		<br/>
		
		<table class="table table-bordered" id="member_table">
			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Age</th>
					<th>Address</th>
					<th>Gender</th>
					<th>Job</th>
					<th>Hobby</th>
				</tr>
			</thead>
			
			<tbody>
			</tbody>
		</table>
	</div>
</body>
</html>