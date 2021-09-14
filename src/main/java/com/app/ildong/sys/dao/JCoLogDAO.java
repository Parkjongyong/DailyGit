package com.app.ildong.sys.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("JCoLogDAO")
public class JCoLogDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void insertJCoLog(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.sys.JCoLog.insertJCoLog", paramMap);
	}
	
	public void updateJCoLog(Map<String, Object> paramMap) {
		sqlSessionTemplate.update("com.sys.JCoLog.updateJCoLog", paramMap);
	}
	
	public int insertJcoRetunLog(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.sys.JCoLog.insertJcoRetunLog", paramMap);
	}
	
	public List<Map<String,Object>> selectJcoReturnLogList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.sys.JCoLog.selectJcoReturnLogList", paramMap);
	}

}
