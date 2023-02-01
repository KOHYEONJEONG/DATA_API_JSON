package com.spring.sample.web.test.objectMapperTest;

import java.io.IOException;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ObjectMapperService {
	ObjectMapper objectMapper = new ObjectMapper();
	//ObjectMapper objectMapper = new ObjectMapper().configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,false);

	//역직렬화
	public PersonVO obDeserialized() {
		
		PersonVO deserializedPerson = null;
		
		
		String json = "{\"name\":\"zooneon\",\"age\":25,\"address\":\"seoul\"}";
		
		//JSON 파일을 java객체로 역직렬화하기 위해서 ObjectMapper의 readValue()메서드를 이용
		//JSON -> Java Obejct
		try {
			//역직렬화
			deserializedPerson = objectMapper.readValue(json, PersonVO.class); 
			System.out.println(deserializedPerson);
			
		}catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		
		return deserializedPerson;
	}
	
	//직렬화
	public String obSerialization() {
		//자바 객체를 JSON으로 serialization 하기 위해서는 ObjectMapper의 writeValue()메서드를 이용
		//Java Object  -> JSON
		PersonVO person = new PersonVO("zooneon", 25,"seoul");
		String result = "";
		try{
			result = objectMapper.writeValueAsString(person);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public PersonDto obTest() throws IOException {
		String json = "{\"name\": \"zooneon\", "+
						 "\"age\": 25," + 
						  "\"address\": \"seoul\","+
				  "\"contact\": {"+
					    "\"phone_number\": \"0102222\"," +
					  "\"email\": \"foo@google.com\"},"+
				  "\"job\": {"+
					    "\"working\": true,"+
					    "\"workplace\": {" +
					     "\"name\": \"Sejong Univ.\","+
					      "\"position\": \"student\" } }}";
		
		// JSON String -> Map
		PersonDto personDto = objectMapper.readValue(json, PersonDto.class);
		log.info("personDto={}",personDto);
		return personDto;
	}
}
