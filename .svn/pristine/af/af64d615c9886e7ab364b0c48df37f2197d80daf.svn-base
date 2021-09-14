package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wrhSerialRegisterDAO")
public class WrhSerialRegisterDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectWrhSerialRegisterList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.SerialRegister.selectWrhSerialRegisterList", paramMap);
	}
	
	public void insertSerialRegister(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.SerialRegister.insertSerialRegister", paramMap);
	}
	
	public void deleteSerialRegisterH(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.SerialRegister.deleteSerialRegisterH", paramMap);
	}		
	
	public void deleteSerialRegister(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.SerialRegister.deleteSerialRegister", paramMap);
	}		
	
	public List<Map<String, Object>> selectDateTime(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.SerialRegister.selectDateTime", paramMap);
	}
	
}
