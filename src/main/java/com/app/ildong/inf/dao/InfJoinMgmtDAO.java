package com.app.ildong.inf.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("InfJoinMgmtDAO")
public class InfJoinMgmtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//협력업체 정보 아이디 정보 생성
	public Map<String,Object> selectNewVendorInfoId(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.inf.InfJoinMgmt.selectNewVendorInfoId", paramMap);
	}
	
	//사업자번호 중복 조회
	public Map<String,Object> selectVndPrnDupChk(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.inf.InfJoinMgmt.selectVndPrnDupChk", paramMap);
	}
	//사업자번호 탈퇴여부 정보 조회
	public Map<String,Object> selectVndPrnDelChk(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.inf.InfJoinMgmt.selectVndPrnDelChk", paramMap);
	}
	
	//가입 정보 입력 - 협력업체 정보
	public int insertVndInfo(Map<String,Object> paramMap) {
		return sqlSessionTemplate.insert("com.inf.InfJoinMgmt.insertVndInfo", paramMap);
	}

	//가입 정보 입력 - 대표사용자 정보 입력
	public int insertRepUserInfo(Map<String,Object> paramMap) {
		return sqlSessionTemplate.insert("com.inf.InfJoinMgmt.insertRepUserInfo", paramMap);
	}

	//가입 정보 입력 - 공급업체 상세 정보 입력
	public int insertVndDetailInfo(Map<String,Object> paramMap) {
		return sqlSessionTemplate.insert("com.inf.InfJoinMgmt.insertVndDetailInfo", paramMap);
	}
	
	//사용자 권한 정보 입력
	public int insertRepUserRole(Map<String,Object> paramMap) {
		return sqlSessionTemplate.insert("com.inf.InfJoinMgmt.insertRepUserRole", paramMap);
	}
	
	
	//가입 정보 수정 - 협력업체 정보
	public int updateVndInfo(Map<String,Object> paramMap) {
		return sqlSessionTemplate.update("com.inf.InfJoinMgmt.updateVndInfo", paramMap);
	}
	
	//가입 정보 수정 - 공급업체 상세 정보 수정
	public int updateVndDetailInfo(Map<String,Object> paramMap) {
		return sqlSessionTemplate.update("com.inf.InfJoinMgmt.updateVndDetailInfo", paramMap);
	}

	
	// 회원 ID 찾기
	public Map<String,Object> selectFindUserId(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.inf.InfJoinMgmt.selectFindUserId", paramMap);
	}

	// 회원 PW 찾기 - 유저정보 찾기
	public Map<String,Object> selectFindUserPw(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.inf.InfJoinMgmt.selectFindUserPw", paramMap);
	}

	//회원 비밀번호 랜덤비밀번호로 교체 
	public int updateResetUserPassword(Map<String,Object> paramMap) {
		return sqlSessionTemplate.update("com.inf.InfJoinMgmt.updateResetUserPassword", paramMap);
	}
	
	
	//가입된 공급업체 정보 조회
	public Map<String,Object> selectJoinVndInfo(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.inf.InfJoinMgmt.selectJoinVndInfo", paramMap);
	}
	
}
