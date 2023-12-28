package com.provider.api.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.provider.api.model.ApiVO;
import com.provider.api.service.ApiProviderService;

//github token | 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
//@Controller // @Controller + @ResponseBody
@RestController
public class ApiResponderController {
	
	@Resource
	private ApiProviderService apiService;
	ApiVO user;
	
	// 회원 정보및 예약정보 조회
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@PostMapping(value = "/responderSearch", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> rgetUserinfoById(@RequestHeader Map<String, String> header,@RequestBody ApiVO ApiVO) {
   //public ResponseEntity<?> rgetUserinfoById(@RequestHeader Map<String, String> header, MultiValueMap<String, String> map) {
		System.out.println("responder | rgetUserinfoById | request: post | result " +ApiVO.toString());
		
		//String decryptedid = apiService.decrypt("sldkslkfj");
		
		user = apiService.getUserinfoById(ApiVO.getId());
		
		System.out.println("user | " + user);
		if (user == null) {
			user = apiService.getOnlyUserinfoById(ApiVO.getId());
		}

		return new ResponseEntity(user, HttpStatus.OK);

	}

	

}
