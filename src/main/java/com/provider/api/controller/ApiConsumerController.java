package com.provider.api.controller;

import java.text.ParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.provider.api.model.ApiVO;
import com.provider.api.service.ApiProviderService;

@RestController
public class ApiConsumerController {
	@Resource
	private ApiProviderService apiService;

	ApiVO user;
	
	@SuppressWarnings("deprecation")
	private static HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + "695c206ec549d13455fd2e0b582ea69a");
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON_UTF8));
		return headers;
	}

	@GetMapping("/front")
	public ModelAndView front() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("front");

		return mav;
	}

	// 회원 정보및 예약정보 조회
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@GetMapping(value = "/search")
	public ResponseEntity<?> getUserinfoById(@RequestParam String id){
		System.out.println("provider | getUserinfoById | request: get | id " + id);
		RestTemplate template = new RestTemplate();

		//RestAPI 준비및 요청 https://devtalk.kakao.com/t/400-bad-request/47373/8
        Map<String, Object> readyReq = new HashMap<String, Object>();
        //body
        readyReq.put("cid", "TC0ONETIME");
        readyReq.put("partner_order_id", "1001");
        readyReq.put("partner_user_id", "test@koitt.com");
        readyReq.put("item_name", "갤럭시S9");
        readyReq.put("quantity", "1");
        readyReq.put("total_amount", "1155000");
        readyReq.put("tax_free_amount", "0");
        readyReq.put("approval_url", "http://localhost:8082/approval.do");
        readyReq.put("cancel_url", "http://localhost:8082/cancel.do");
        readyReq.put("fail_url", "http://localhost:8082/fail.do");
            
        HttpEntity<Object> request = new HttpEntity<Object>(readyReq, getHeaders());
        ResponseEntity<Map> response = template.exchange("http://localhost:8080/search", HttpMethod.GET, request, Map.class);
        
        Map readyResp = response.getBody();
        System.out.println("readyResp | " + readyResp);
        
        //오류방지
        user = apiService.getUserinfoById(id);
		System.out.println("user " + user);
		if (user == null) {
			user = apiService.getOnlyUserinfoById(id);
		}

		return new ResponseEntity(user, HttpStatus.OK);
	}

	// 예약하기
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@PostMapping(value = "/insert")
	public ResponseEntity<?> reservation(@RequestBody ApiVO messageBody)
			throws ParseException, JsonProcessingException {
		System.out.println("reservation | request: post");
		System.out.println("messageBody |" + messageBody);
		apiService.reservation(messageBody);

		user = apiService.getUserinfoById(messageBody.getId());

		// 1.set header
		/*HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(new MediaType[] { MediaType.APPLICATION_JSON }));
		headers.set("헤더이름", "값");

		// 2. set body
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("키", "값");

		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(user);

		body.add("user", jsonString);

		HashMap<String, Object> result = new HashMap<>();

		result.put("header", headers);
		result.put("body", body);*/

		return new ResponseEntity(user, HttpStatus.OK);
	}

	// 예약정보수정하기
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@PostMapping(value = "/modify")
	public ResponseEntity modify(@RequestHeader Map<String, String> header, @RequestBody ApiVO messageBody)
			throws JsonProcessingException {
		System.out.println("modify | request: post");
		System.out.println("messageBody |" + messageBody);
		System.out.println("getuserid |" + messageBody.getId());
		apiService.modify(messageBody);
		/*ApiVO resinfo = apiService.getReservationInfo(messageBody.getInsp_rsvt_no());

		// 1.set header
		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(new MediaType[] { MediaType.APPLICATION_JSON }));
		headers.set("헤더이름", "값");

		// 2. set body
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("키", "값");

		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(resinfo);

		body.add("user", jsonString);

		HashMap<String, Object> result = new HashMap<>();

		result.put("header", headers);
		result.put("body", body);*/

		return new ResponseEntity(user, HttpStatus.OK);
	}

	// 예약정보삭제하기
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@PostMapping(value = "/delete")
	public ResponseEntity delete(@RequestHeader Map<String, String> header, @RequestBody ApiVO messageBody) throws JsonProcessingException {
		System.out.println("delete | request: post");
		System.out.println("messageBody |" + messageBody);
		apiService.delete(messageBody);
		/*user = apiService.getUserinfoById(messageBody.getId());

		// 1.set header
		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(new MediaType[] { MediaType.APPLICATION_JSON }));
		headers.set("헤더이름", "값");

		// 2. set body
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("키", "값");

		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(user);

		body.add("user", jsonString);

		HashMap<String, Object> result = new HashMap<>();

		result.put("header", headers);
		result.put("body", body);*/

		return new ResponseEntity(user, HttpStatus.OK);
	}

}
