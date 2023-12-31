package com.provider.api.service;

import java.text.ParseException;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.provider.api.mapper.ApiMapper;
import com.provider.api.model.ApiVO;

@Service
public class ApiProviderService {
	@Autowired
	private ApiMapper apiMapper;

	/*
	 * public String checksum(String message) { System.out.println("message " +
	 * message); Chec	ksumModule checksumModule = new ChecksumModule(); String
	 * checksumResult = checksumModule.checksum(message);
	 * System.out.println("checksumResult " + checksumResult);
	 * 
	 * return checksumResult; }
	 * 
	 * public String encrypt(String data) { String strKey =
	 * "b7Rz1cawP9ws1RJQARK5wbiqHOQnTLxErPQVQMKeBnY="; // String data =
	 * "Temporary Message for Encrypt";
	 * 
	 * CryptoModule cryptoModule = new CryptoModule(); String encryptResult =
	 * cryptoModule.encrypt(strKey, data); System.out.println("encryptResult " +
	 * encryptResult);
	 * 
	 * return encryptResult; }
	 * 
	 * public String decrypt(String encryptResult) { String strKey =
	 * "b7Rz1cawP9ws1RJQARK5wbiqHOQnTLxErPQVQMKeBnY=";
	 * 
	 * CryptoModule cryptoModule = new CryptoModule();
	 * 
	 * String decryptResult = cryptoModule.decrypt(strKey, encryptResult);
	 * System.out.println("decryptResult " + decryptResult);
	 * 
	 * return decryptResult; }
	 */

	// 랜덤문자생성
	public String randomVal(int length) {
		int leftLimit = 97; // letter 'a'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = length;

		Random random = new Random();
		StringBuilder buffer = new StringBuilder(targetStringLength);

		for (int i = 0; i < targetStringLength; i++) {
			int randomLimitedInt = leftLimit + (int) (random.nextFloat() * (rightLimit - leftLimit + 1));
			buffer.append((char) randomLimitedInt);
		}
		String generatedString = buffer.toString();
		System.out.println(generatedString);

		return generatedString;
	}

	// 회원정보&병역검사예약정보
	public ApiVO getUserinfoById(String id) {
		return apiMapper.getUserinfoById(id);
	}

	// only회원정보
	public ApiVO getOnlyUserinfoById(String id) {
		System.out.println("service");
		return apiMapper.getOnlyUserinfoById(id);
	}

	// 검사예약
	public void reservation(ApiVO apiVO) throws ParseException {
		apiVO.setInsp_rsvt_no(randomVal(6));
		System.out.println("insp_dt |" + apiVO.getInsp_dt());
		System.out.println("insp_addr|" + apiVO.getInsp_addr());

		// 1.사용자테이블에 검사예약번호 업데이트
		apiMapper.updateExamNo(apiVO);
		// 2.예약테이블에 예약내역 넣기
		apiMapper.insertReservation(apiVO);
	}

	// 예약수정하기
	public void modify(ApiVO apiVO) {
		apiMapper.updateReservation(apiVO);
	}

	// 예약삭제하기
	public void delete(ApiVO apiVO) {
		// 1.예약내역삭제
		apiMapper.deleteReservation(apiVO);
		// 2.사용자테이블에 검사예약번호 null값으로
		apiVO.setInsp_rsvt_no(null);
		apiMapper.updateExamNo(apiVO);
	}

	public ApiVO getReservationInfo(String insp_rsvt_no) {
		return apiMapper.getReservationInfo(insp_rsvt_no);
	}
}
