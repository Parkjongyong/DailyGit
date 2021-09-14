package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatUserDAO")
public class BatUserDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate2;	
	
	public List<Map<String, Object>> selectUserData(Map<String, Object> paramMap) {
		return sqlSessionTemplate2.selectList("interface.selectUserData", paramMap);
	}
	
	public Map<String, Object> selectCountUserInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchUser.selectCountUserInfo", paramMap);
	}	
	
	public int mergeUserIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchUser.mergeUserIfData", paramMap);
	}
	
	public int insertUserIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchUser.insertUserIfData", paramMap);
	}
	
	public void deleteUserIfData() {
		sqlSessionTemplate.delete("com.bat.BatchUser.deleteUserIfData");
	}	
	
	public int batchUserIfData( List<Map<String, Object>> list) {
		return sqlSessionTemplate.insert("com.bat.BatchUser.batchUserIfData", list);
	}	
	
	public int updateUserIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchUser.updateUserIfData", paramMap);
	}
	
	public void makeUserData() {
		sqlSessionTemplate.insert("com.bat.BatchUser.makeUserData");
	}		
}
