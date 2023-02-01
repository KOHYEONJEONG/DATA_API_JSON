package com.spring.sample.web.test.objectMapperTest;

import java.util.HashMap;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@NoArgsConstructor
public class Job {
	private String working;
	private HashMap<String, Object> workplace = new HashMap<String, Object> ();
}
