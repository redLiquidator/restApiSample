package com.provider.api.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.provider.api.model.ApiVO;
import com.provider.api.service.ApiProviderService;
//github token | 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
//@Controller // @Controller + @ResponseBody
@RestController
public class ApiProviderController {
	@Resource
	private ApiProviderService apiService;
	
	@RequestMapping(value="/front")
	public ModelAndView front() throws Exception{
		ModelAndView mav = new ModelAndView();
		mav.setViewName("front");
		
		return mav;		
	}
	
	// 회원 정보및 예약정보 조회
		@SuppressWarnings({ "rawtypes", "unchecked" })
		@GetMapping(value = "/search")
		public ResponseEntity<?> getUserinfoById(@RequestParam String id) {
			System.out.println("getUserinfoById | request: get | id "+ id);
			ApiVO user = apiService.getUserinfoById(id);
			//System.out.println("user | " + user.toString());
			//System.out.println("user | " + user.getInsp_addr()+user.getInsp_rsvt_no()+user.getInsp_dt());
			
	
			return new ResponseEntity(user, HttpStatus.OK);
			
		}

		// 예약하기
		@PostMapping(value = "/reservation")
		public HashMap<String, Object> reservation(@RequestHeader Map<String, String> header, @RequestBody ApiVO messageBody) {
			System.out.println("messageBody |" + messageBody);
			apiService.reservation(messageBody);

			// 1.set header
				// 1-1. HttpHeaders 객체 생성
				HttpHeaders headers = new HttpHeaders();
				 
				// 1-2. 헤더 설정 : ContentType, Accept 설정
				//headers.setContentType(new MediaType("application","json",Charset.forName("UTF-8")));
				headers.setAccept(Arrays.asList(new MediaType[] { MediaType.APPLICATION_JSON }));		 
				 
				// 1-3. 헤더 설정 : Key, Value 쌍으로 설정
				headers.set("헤더이름", "값");

			// 2. set body
				// 2-1. MultiValueMap 객체 생성
				MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
				 
				// 2-2. body : 요청 파라미터 설정
				body.add("키", "값");
				 
				// 2-3. 만들어진 header와 body를 가진 HttpEntity 객체 생성
				HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
				
			// 3.RestTemplate 객체 생성
			HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();

			RestTemplate restTemplate = new RestTemplate(factory);
			// 4.RestTemplate 에 위에서 생성한 body와 header를 담는다.
			ResponseEntity<String> response = restTemplate.exchange("요청 URL", HttpMethod.POST, entity, String.class);
			// 5.위의 결과물을 Hashmap에 담는다.
			HashMap<String, Object> result = new HashMap<>();
			
			result.put("status", response.getStatusCode());
		    result.put("header", response.getHeaders());
		    result.put("body", response.getBody());
		 
		    return result;
		}

		// 예약정보수정하기
		@PostMapping(value = "/modify")
		public  HashMap<String, Object> modify(@RequestHeader Map<String, String> header, @RequestBody ApiVO messageBody) {
			System.out.println("messageBody |" + messageBody);
			apiService.modify(messageBody);
			
			HashMap<String, Object> result = new HashMap<>();

		    return result;
		}

		// 예약정보삭제하기
		@PostMapping(value = "/delete")
		public  HashMap<String, Object> delete(@RequestHeader Map<String, String> header, @RequestBody ApiVO messageBody) {
			System.out.println("messageBody |" + messageBody);
			apiService.delete(messageBody);
			
			HashMap<String, Object> result = new HashMap<>();

		    return result;
		}
	
	
}
