package com.app.ildong.mai.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("MainRoleViewDAO")
public class MainRoleViewDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String,Object>> selectPopupMgmtListMain(Map<String,Object> paramMap) {
		return sqlSessionTemplate.selectList("com.mai.MainRoleViewDAO.selectPopupMgmtListMain", paramMap);
	}
	
	public Map<String, Object> selectPopupMgmtMain(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.mai.MainRoleViewDAO.selectPopupMgmtMain", paramMap);
	}

}
