package com.provider.api.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Random;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.provider.api.mapper.ApiMapper;
import com.provider.api.model.ApiVO;


@Service
public class ApiProviderService {
	@Autowired
	private ApiMapper apiMapper;
	

	public ApiVO test(){
		return apiMapper.test();		
	}
	
	//랜덤문자생성
	public String randomVal(int length) {
		int leftLimit = 97; // letter 'a'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = length;
		
		Random random = new Random();
		StringBuilder buffer = new StringBuilder(targetStringLength);
		
		for (int i = 0; i < targetStringLength; i++) {
		    int randomLimitedInt = leftLimit + (int)
		            (random.nextFloat() * (rightLimit - leftLimit + 1));
		    buffer.append((char) randomLimitedInt);
		}
		String generatedString = buffer.toString();
		System.out.println(generatedString);
		
	    return generatedString;
	}
	
	//회원정보&병역검사예약정보
	public ApiVO getUserinfoById(String id) {
		return apiMapper.getUserinfoById(id);
	}
	
	//only회원정보
	public ApiVO getOnlyUserinfoById(String id) {		
		return apiMapper.getOnlyUserinfoById(id);
	}
	
	//검사예약
	public void reservation(ApiVO apiVO) throws ParseException {
		apiVO.setInsp_rsvt_no(randomVal(6));
		System.err.println("insp_dt |"+apiVO.getInsp_dt());
		System.err.println("insp_addr|"+apiVO.getInsp_addr());
		
		//string을 date로 2023121110:30 -> ?	
		 // 문자열       
		//String dateStr = "20210619210507";  
		String dateStr = apiVO.getInsp_dt();   
		// 포맷터        
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");         
		// 문자열 -> Date        
		Date date = formatter.parse(dateStr);         
		System.out.println(date); 
		

	    //2.사용자테이블에 검사예약번호 업데이트
		apiMapper.updateExamNo(apiVO);
	    //3.예약테이블에 예약내역 넣기
		apiMapper.insertReservation(apiVO);
		
	}
	
	//예약수정하기
	public void modify(ApiVO apiVO) {
		apiMapper.updateReservation(apiVO);		
	}
	
	//예약삭제하기
	public void delete(ApiVO apiVO) {
		//1.사용자테이블에 검사예약번호 null값으로
		apiMapper.updateExamNo(apiVO);
		//2.예약내역삭제
		apiMapper.deleteReservation(apiVO);		
	}


	

	
}
