package com.provider.api.service;

import java.util.Random;

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
	public String randomVal() {
		int leftLimit = 97; // letter 'a'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 8;
		
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
	
	//회원정보
	public ApiVO getUserinfoById(String id) {
		System.out.println("***getUserinfoById service***");
		return apiMapper.getUserinfoById(id);
	}
	
	//검사예약
	public void reservation(ApiVO apiVO) {
		//1.검사예약번호 생성
		
				
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
