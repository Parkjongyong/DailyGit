package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batSendBugtDAO")
public class BatSendBugtDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String, Object>> selectSendBasicBugtList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchSendBugt.selectSendBasicBugtList", paramMap);
	}
	
	public List<Map<String, Object>> selectSendBugtBasicMgmtList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchSendBugt.selectSendBugtBasicMgmtList", paramMap);
	}	
	
	public List<Map<String, Object>> selectSendModifyBugtList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchSendBugt.selectSendModifyBugtList", paramMap);
	}
	
	public List<Map<String, Object>> selectSendBugtModifyBasicMgmtList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchSendBugt.selectSendBugtModifyBasicMgmtList", paramMap);
	}	
	
	public List<Map<String, Object>> selectSendExecBugtList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchSendBugt.selectSendExecBugtList", paramMap);
	}
	
	public List<Map<String, Object>> selectSendBugtExecBasicMgmtList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchSendBugt.selectSendBugtExecBasicMgmtList", paramMap);
	}	
	
	public List<Map<String, Object>> selectSendSupplementList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchSendBugt.selectSendSupplementList", paramMap);
	}
	
	public List<Map<String, Object>> selectSendSupplementMgmtList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("com.bat.BatchSendBugt.selectSendSupplementMgmtList", paramMap);
	}	
	
}
