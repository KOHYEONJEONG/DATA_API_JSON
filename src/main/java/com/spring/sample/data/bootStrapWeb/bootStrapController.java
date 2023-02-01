package com.spring.sample.data.bootStrapWeb;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class bootStrapController {

    //부트스트랩을 사용한 테이블 꾸미기
    @RequestMapping("/bootStrapList")
    public String bootList(HttpServletRequest request, HttpServletResponse response){
        return "/testa/boot/bootstrapMain";
    }
}
