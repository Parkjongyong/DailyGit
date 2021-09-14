package com.app.ildong.usr.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("UsrUserSearchDAO")
public class UsrUserSearchDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String,Object>> selectUsrUserSearchInList(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.usr.UsrUserSearchDAO.selectUsrUserSearchInList", paramMap);
	}
	
	public List<Map<String,Object>> selectUsrUserSearchOutList(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.usr.UsrUserSearchDAO.selectUsrUserSearchOutList", paramMap);
	}
	
	
	//비밀번호 바꾸기 위한 전체 사용자 ID 조회
	public List<Map<String,Object>> selectUserIdAll(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.usr.UsrUserSearchDAO.selectUserIdAll", paramMap);
	}
	
	// 사용자 비밀번호 수정
	public int updateUserPwdChg(Map<String,Object> paramMap) {
		return sqlSessionTemplate.update("com.usr.UsrUserSearchDAO.updateUserPwdChg", paramMap);
	}

	//내부 비밀번호 바꾸기 위한 전체 사용자 ID 조회
	public List<Map<String,Object>> selectInUserIdAll(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.usr.UsrUserSearchDAO.selectInUserIdAll", paramMap);
	}
	
	// 내부 사용자 비밀번호 수정
	public int updateInUserPwdChg(Map<String,Object> paramMap) {
		return sqlSessionTemplate.update("com.usr.UsrUserSearchDAO.updateInUserPwdChg", paramMap);
	}
}
