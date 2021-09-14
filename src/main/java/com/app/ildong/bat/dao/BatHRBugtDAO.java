package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("batHRBugtDAO")
public class BatHRBugtDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate2;	
	
	public List<Map<String, Object>> selectHRBugtIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate2.selectList("interface.selectHRBugtIfData", paramMap);
	}
	
	public int mergeHRBugtIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchHRBugt.mergeHRBugtIfData", paramMap);
	}
	
	public void deleteHRBugtIfData(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.bat.BatchHRBugt.deleteHRBugtIfData", paramMap);
	}
	
	public void deleteHRBugtBasicData(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.bat.BatchHRBugt.deleteHRBugtBasicData", paramMap);
	}
	
	public void deleteHRBugtModifyData(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.bat.BatchHRBugt.deleteHRBugtModifyData", paramMap);
	}	
	
	public int batchHRBugtIfData(List<Map<String, Object>> list) {
		return sqlSessionTemplate.insert("com.bat.BatchHRBugt.batchHRBugtIfData", list);
	}	
	
	public List<Map<String, Object>> selectHRBugtData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("interface.selectHRBugtData", paramMap);
	}
	
	public void mergeHRBugtData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.BatchHRBugt.mergeHRBugtData", paramMap);
	}
	
	public void mergeHRBugtData2(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.BatchHRBugt.mergeHRBugtData2", paramMap);
	}	
}
