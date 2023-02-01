$(document).ready(function (){
    var json = "https://apis.data.go.kr/B552061/jaywalking/getRestJaywalking?" +
        "serviceKey=aLkN%2FdTlrfuWUrbG78Fh3okk7JF2%2FUKGVXuV%2FvpyonUV9668PMtQneH2EDZjQ67bExJ9wBiU%2FMGFU12bkonUfA%3D%3D" +
        "&searchYearCd=2017" +
        "&siDo=11" +
        "&guGun=680" +
        "&type=json" +
        "&numOfRows=10" +
        "&pageNo=1";
     //guGun = 680은 강남구를 뜻함.

    $.ajax({
        //ajax 옵션 설정
        url : json,
        type : "GET",
        data : "json",
        success:function(data){//콜백, 성공 시

            //console.log(data.items.item);//Array(5)
            //console.log(typeof data);//object(알아서 변환되나봄)

            // data = JSON.stringify(data);
            // console.log(typeof data);//string

            let api_data = "";
            $.each(data.items.item, function (key,value){ //순회할 데이터, 콜백함수
                api_data += "<tr>";
                api_data += "<td>"+key+"</td>";
                api_data += "<td>"+value.sido_sgg_nm+"</td>";
                api_data += "<td>"+value.sl_dnv_cnt+"</td>";
                api_data += "<td>"+value.spot_nm+"</td>";
                api_data += "<td>"+value.se_dnv_cnt+"</td>";
                api_data += "<td>"+value.dth_dnv_cnt+"</td>";
                api_data += "</tr>";
            });

            $("#member_table").append(api_data);
        }
    })
});