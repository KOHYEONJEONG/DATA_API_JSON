package com.spring.sample.web.test.objectMapperTest;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PersonDto {
	//private PersonVO personVO; //이름으로 따라가기 때문에 이렇게 만들면 못읽음.
	private String name;
	private Integer age;
	private String address;
	private Contact contact;
	private Job job;
}
