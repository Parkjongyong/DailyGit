package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgUsersDeptMgtDAO")
public class BdgUsersDeptMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectUsersMgtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.UsersDeptMgt.selectUsersMgtList", paramMap);
	}
	
	public List<Map<String, Object>> selectDeptMgtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.UsersDeptMgt.selectDeptMgtList", paramMap);
	}
	
	public void insertUsersMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.UsersDeptMgt.insertUsersMgt", paramMap);
	}
	
	public void deleteUsersMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.UsersDeptMgt.deleteUsersMgt", paramMap);
	}
	
	public void deleteDeptMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.UsersDeptMgt.deleteDeptMgt", paramMap);
	}
	
}
