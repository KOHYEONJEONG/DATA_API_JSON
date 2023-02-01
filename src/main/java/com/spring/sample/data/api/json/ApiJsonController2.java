package com.spring.sample.data.api.json;
//ctrl+shift+o : import 자동 등록

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@Slf4j
@Controller
public class ApiJsonController2 {
	
	@RequestMapping(value = "jsonApiList2.do")
	public ModelAndView jsonMain2(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("testa/api/aMain2");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "jsonApi2.do")
	public void jsonApiMethod2(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String serviceKey = "aLkN%2FdTlrfuWUrbG78Fh3okk7JF2%2FUKGVXuV%2FvpyonUV9668PMtQneH2EDZjQ67bExJ9wBiU%2FMGFU12bkonUfA%3D%3D";
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552061/jaywalking/getRestJaywalking"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode(serviceKey, "UTF-8")); /*xml 또는 json*/
		urlBuilder.append("&" + URLEncoder.encode("searchYearCd","UTF-8") + "=" + URLEncoder.encode("2017", "UTF-8")); /*한 페이지 결과 수(조회 날짜로 검색 시 사용 안함)*/
		urlBuilder.append("&" + URLEncoder.encode("siDo","UTF-8") + "=" + URLEncoder.encode("11", "UTF-8")); /*페이지번호(조회 날짜로 검색 시 사용 안함)*/
		urlBuilder.append("&" + URLEncoder.encode("guGun","UTF-8") + "=" + URLEncoder.encode("680", "UTF-8")); /*페이지번호(조회 날짜로 검색 시 사용 안함)*/
		urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*페이지번호(조회 날짜로 검색 시 사용 안함)*/
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*페이지번호(조회 날짜로 검색 시 사용 안함)*/
		urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호(조회 날짜로 검색 시 사용 안함)*/

		//접속
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");//대문자!
		conn.setRequestProperty("Content-type", "application/json");
		
		//상태코드
		System.out.println("Response code: " + conn.getResponseCode());

		//결과
		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		//결과 String으로 담기
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);//StringBuilder는 객체를 일일히 생성할 필요가 없다. 효율적
		}
		rd.close();
		conn.disconnect();
		System.out.println(sb.toString());
		response.getWriter().write(sb.toString());
	}
	
}
