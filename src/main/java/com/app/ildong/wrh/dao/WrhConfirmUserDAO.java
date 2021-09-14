package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("confirmUserDAO")
public class WrhConfirmUserDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectConfirmUserList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.ConfirmUser.selectConfirmUserList", paramMap);
	}
	
	public void updateConfirmUser(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.ConfirmUser.updateConfirmUser", paramMap);
	}

	public void insertConfirmUser(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.ConfirmUser.insertConfirmUser", paramMap);
	}
	public void deleteConfirmUser(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.wrh.ConfirmUser.deleteConfirmUser", paramMap);
	}
}
