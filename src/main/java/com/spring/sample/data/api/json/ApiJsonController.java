package com.spring.sample.data.api.json;
//ctrl+shift+o : import 자동 등록
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ApiJsonController {
	
	@RequestMapping(value = "jsonApiList.do")
	public ModelAndView jsonMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("testa/api/aMain");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "jsonApi.do")
	public void jsonApiMethod(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//ex) 차가 부딪히더래도 완충제를 통해서 좀 더 사고 휴유증 등 덜하겠지?
		//버퍼 이용 : BuffereadReader --> 버퍼를 이용해서 읽고 쓰는 함수.(버퍼에 쌓아둔 후 한꺼번에 전달)
		//버퍼(Buffer) : 입출력 속도 향상을 위해서 '데이터를 일시적으로 메모리 영역의 한곳에 모아두는 것'.(효율적으로 입축력을 관리.)
		//				ㄴ입출력 관련해서 많이 나오는데, 키보드를 통해 입력과 동시에 바로 전달하는게 아니라 버퍼에 쌓아둔 후에 한꺼번에 전송함으로써 속도 향상.
		//버퍼 장점 : 버퍼를 이용하기 때문에 입출력 관려 처리 작업을 매우 빠르게 할 수 있다,
		BufferedReader br = null;
		HttpURLConnection urlConn = null;
		try {
			//공공 api 인증키 및 전체 풀 주소
			//변수에 여러 값을 넣어서 주소 체계를 만들어야 한다면 --> StringBuilder를 사용.
			//String : 불변(immutable)성을 가지므로 문자열을 더할 때 매번 새로운 객체를 생성해서 참조하는 방식
			//String Builder : 문자열을 더해 나갈 때 새로운 객체를 매법 생성하는 것이 아니라 기존 데이터 값에 추가해가는 방식이고, 속도가 빠르다.
			//				 : mutable(뮤더블) 속성이며, append(), insert(), delete()등을 사용해서 값을 변경.
			//보통 공공API 방식 --> StringBuilder 사용
			String serviceKey = "aLkN%2FdTlrfuWUrbG78Fh3okk7JF2%2FUKGVXuV%2FvpyonUV9668PMtQneH2EDZjQ67bExJ9wBiU%2FMGFU12bkonUfA%3D%3D";
			
			//오류나면 https -> http 로 변경해보길!
			String uslStr = "http://apis.data.go.kr/B552061/jaywalking/getRestJaywalking?serviceKey=aLkN%2FdTlrfuWUrbG78Fh3okk7JF2%2FUKGVXuV%2FvpyonUV9668PMtQneH2EDZjQ67bExJ9wBiU%2FMGFU12bkonUfA%3D%3D&searchYearCd=2015&siDo=11&guGun=320&type=json&numOfRows=10&pageNo=1";
			
			//요청주소 접속 및 접속 후 상태 보기
			//URL 클래스로 객체 생성 --> 2가지 방법 : 절대경로, 상대경로
			URL url = new URL(uslStr);
			
			//openConnection() 메서드를 이용한 연결
			//URL 주소의 원격 객체에 접속한 뒤 -> 통신할 수 있는 URL Connection 객체 리턴.
			urlConn = (HttpURLConnection)url.openConnection();
			
			//GET/POST 설정
			urlConn.setRequestMethod("GET");//대문자!!
			urlConn.setRequestProperty("Content-type", "application/json");
			
			//상태코드
			System.out.println("Response Code : "+urlConn.getResponseCode());//200
			log.info("Response Code : "+urlConn.getResponseCode());//INFO : com.spring.sample.data.api.ApiJson - Response Code : 200
			
			//결과
			//InputStreamReader 클래스로 읽기
			//BufferdReader는 InputStreamReader 객체를 입력값으로 사용한다!!(기본이다)
			br = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
			
//			String rst = "";
//			String line;
//			while((line = br.readLine())!= null) {
//				rst += line + "\n";
//			}
//			System.out.println(rst);
//			 response.getWriter().write(rst);
			
			StringBuilder sb = new StringBuilder();// append(), insert(), delete()등을 사용해서 값을 변경.
			String line;
			while((line=br.readLine())!= null) {
				sb.append(line);
			}
			System.out.println(sb.toString());
			response.getWriter().write(sb.toString());
			
		}catch (Exception e) {
			//e.printStackTrace();
			//e.toString();
			System.out.println(e.getMessage());
		}finally {
			//연결해제
			if(br != null) {
				br.close();
			}
			urlConn.disconnect();
		}
		
		//JSP 값 보내기


	}
	
}
