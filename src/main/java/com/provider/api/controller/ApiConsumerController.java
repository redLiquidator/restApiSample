package com.provider.api.controller;

import java.text.ParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.provider.api.model.ApiVO;
import com.provider.api.service.ApiProviderService;



@RestController
public class ApiConsumerController {
	@Resource
	private ApiProviderService apiService;

	ApiVO user;
	
	private static HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		//headers.add("Authorization", "KakaoAK " + "695c206ec549d13455fd2e0b582ea69a");
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		
		//headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);

		return headers;
	}
	
	// 회원 정보및 예약정보 조회 요청
	@SuppressWarnings("rawtypes")
	@GetMapping(value = "/consumerSearch")
	public ResponseEntity<?> cgetUserinfoById(@RequestParam String id){
		System.out.println("consumer | cgetUserinfoById | request: get | id " + id);
	
		//apiService.checksum(id);
		//apiService.encrypt(id);
		
		//ClientHttpRequestFactory requestFactory = new     
		//	      HttpComponentsClientHttpRequestFactory(HttpClients.createDefault());
		
		RestTemplate template = new RestTemplate();

		//RestAPI 준비및 요청 https://devtalk.kakao.com/t/400-bad-request/47373/8
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("id", id);
            
        HttpEntity<Object> request = new HttpEntity<Object>(body, getHeaders());
        ResponseEntity<Map> response;
        System.out.println(request.getBody());
        
         response = template.exchange("http://localhost:8080/responderSearch", HttpMethod.POST, request, Map.class);
     
        //System.out.println("readyResp | " + response);
              
        //HashMap<String, Object> result = new HashMap<>();
        //result.put("status", response.getStatusCode());
        //result.put("header", response.getHeaders());
        //result.put("body", response.getBody());
        //return result;
        return new ResponseEntity<>(response,HttpStatus.OK);
	}

	// 예약하기
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@PostMapping(value = "/cinsert")
	public ResponseEntity<?> reservation(@RequestBody ApiVO messageBody)
			throws ParseException, JsonProcessingException {
		System.out.println("reservation | request: post");
		System.out.println("messageBody |" + messageBody);
		apiService.reservation(messageBody);

		user = apiService.getUserinfoById(messageBody.getId());

		return new ResponseEntity(user, HttpStatus.OK);
	}

	// 예약정보수정하기
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@PostMapping(value = "/cmodify")
	public ResponseEntity modify(@RequestHeader Map<String, String> header, @RequestBody ApiVO messageBody)
			throws JsonProcessingException {
		System.out.println("modify | request: post");
		System.out.println("messageBody |" + messageBody);
		System.out.println("getuserid |" + messageBody.getId());
		apiService.modify(messageBody);

		return new ResponseEntity(user, HttpStatus.OK);
	}

	// 예약정보삭제하기
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@PostMapping(value = "/cdelete")
	public ResponseEntity delete(@RequestHeader Map<String, String> header, @RequestBody ApiVO messageBody) throws JsonProcessingException {
		System.out.println("delete | request: post");
		System.out.println("messageBody |" + messageBody);
		apiService.delete(messageBody);

		return new ResponseEntity(user, HttpStatus.OK);
	}
	
}
