<%--
  Created by IntelliJ IDEA.
  User: KHJ
  Date: 2023-01-19
  Time: 오후 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>	<!-- 항상 최신버전 -->
    <%--<script src="${pageContext.request.contextPath}/resources/script/js/data.js"></script>--%>
    <script src="${pageContext.request.contextPath}/resources/script/js/publicData.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        th,td{
            text-align: center;
        }
    </style>
</head>
<body>

    <h4 style="text-align: center; padding: 50px 0;">JSON 데이터 리스트</h4>
    <table class="table table-striped" id="member_table">
        <thead>
            <th>No</th>
            <th>관할 경찰서</th>
            <th>다발지역 내 지점명</th>
            <th>경상자 수</th>
            <th>중상자 수</th>
            <th>사망자 수</th>
        </thead>
        <tbody>

        </tbody>
    </table>

</body>
</html>
