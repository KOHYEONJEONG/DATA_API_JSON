<%--
  Created by IntelliJ IDEA.
  User: KHJ
  Date: 2023-01-22
  Time: 오후 7:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>부트스트랩 테이블 꾸미기</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>	<!-- 항상 최신버전 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
    <!--
1. 컨테이너 없이 테이블만 작성하면 너비가 100% 꽉 참.
2. 테이블 외각에 div 쓰고 class=table 적용하면 양쪽에 적절한 마진 생성.
3. table-bordered : 경계선
4. table-striped
5. table-dark, table-light(기본)
6. thead 에만 다크 적용도 가능(thead-light)
7. text-center, text-left
8. colspan (열), rowspan(행) 합치기
9. table-hover : 마우스를 올렸을 때 반전을 줌.
10. table-sm : small로써 컴팩트하고 피트하게 맞춰줌. 폰트 사이즈는 변경해줘야 해~
11. tr,td 색상변경 : class="bg-info", "bg-danger"(빨강), "bg-warning"(노랑), "bg-success"(녹색)
12. caption : table안쪽에다 사용. 사용자에게 보충 설명
13. text-center : 글자 가운데 정렬
      -->
</head>
<body>
    <div class="container">
        <h3 style="text-align: center;padding-top: 50px">Bootstrap Table Example
            <small class="text-muted">with faded secondary text</small> <!--muted : 채도,명도가 밝지 않게-->
        </h3>
        <br/>
    </div>
    <div class="container"><!--좌우 여백주려고-->
        <!--
            table-responsive-sm < 576px
            table-responsive-md < 768px
            table-responsive-lg < 992px
            table-responsive-xl < 1200px
        -->
        <div class="table-responsive-sm"><!--1200px 아래로 줄어들면 하단 스크롤 바 생성(※table-sm과 같이 사용x)-->
            <table class="table table-bordered table-striped table-dark table-hover">
                <caption>Free Member list of members</caption>
                <thead class="thead-light text-center"><!--thead만 밝게 적용-->
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

                <tbody class="text-center">
                    <tr>
                        <td>1</td>
                        <td>홍길동</td>
                        <td>22</td>
                        <td class="text-left">서울시 서초구 양재동 OO물산</td>
                        <td>Male</td>
                        <td>Programmer</td>
                        <td>영화보기</td>
                    </tr>

                    <tr>
                        <td>2</td>
                        <td>이순신</td>
                        <td>30</td>
                        <td class="text-left">서울시 서초구 양재동 OO물산</td>
                        <td>Female</td><!--페이메일-->
                        <td>Programmer</td>
                        <td>독서</td>
                    </tr>

                    <tr>
                        <td>3</td>
                        <td>강감찬</td>
                        <td>40</td>
                        <td class="text-left">서울시 서초구 양재동 OO물산</td>
                        <td>Male</td>
                        <td>Programmer</td>
                        <td>축구</td>
                    </tr>

                    <tr class="bg-warning"> <!--노란색-->
                        <td colspan="6">최종합계</td>
                        <td>100</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


</body>
</html>
