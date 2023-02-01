package com.spring.sample.web.test.objectMapperTest;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ObjectMapperController {
	
	@Autowired
	ObjectMapperService obs;
	
	@ResponseBody
	@GetMapping(value = "/test/omd")
	public PersonVO omdGet(HttpServletRequest request, HttpServletResponse response) {
		//ModelAndView는 사용하면 안돼 <-- 사용하면 페이지를 찾을 수 없다는 에러가 나와(404)
		//만약 사용한다면 jsonView를 등록하고 사용해야해 
		return obs.obDeserialized();
	}
	
	@ResponseBody
	@GetMapping(value = "/test/oms")
	public String omsGet(HttpServletRequest request, HttpServletResponse response) {
		//ModelAndView는 사용하면 안돼 <-- 사용하면 페이지를 찾을 수 없다는 에러가 나와(404)
		//만약 사용한다면 jsonView를 등록하고 사용해야해 
		return obs.obSerialization();
	}
	
	@ResponseBody
	@GetMapping(value = "/test/omtest")
	public PersonDto omtestGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//ModelAndView는 사용하면 안돼 <-- 사용하면 페이지를 찾을 수 없다는 에러가 나와(404)
		//만약 사용한다면 jsonView를 등록하고 사용해야해 
		return obs.obTest();
		
		/*
		 * 
		 {
		    "name": "zooneon",
		    "age": 25,
		    "address": "seoul",
		    "contact": {
		        "phone_number": "0102222",
		        "email": "foo@google.com"
		    },
		    "job": {
		        "working": "true",
		        "workplace": {
		            "name": "Sejong Univ.",
		            "position": "student"
		        }
		    }
		}
		 * */
	}
	
	
}
