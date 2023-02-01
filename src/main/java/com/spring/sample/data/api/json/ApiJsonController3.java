package com.spring.sample.data.api.json;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class ApiJsonController3 {

    @RequestMapping("jsonApi3.do")
    public ModelAndView jsonApi3(HttpServletRequest request, HttpServletResponse response) throws Exception{
        ModelAndView mv = new ModelAndView();

        //인코딩 타입 설정
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String command = request.getParameter("command");

        String view="/testa/api/dataIndex";
        if(command != null || "list".equals(command)){
            //list가 넘어오면 처리해서 넘겨주면 돼.
            view = "/testa/api/dataList";
        }
        mv.setViewName(view);
        return mv;
    }
}
