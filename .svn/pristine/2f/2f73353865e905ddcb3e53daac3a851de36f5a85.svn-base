package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatBugtDAO")
public class BatBugtDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate2;	
	
	public List<Map<String, Object>> selectBugtData(Map<String, Object> paramMap) {
		return sqlSessionTemplate2.selectList("interface.selectBugtData", paramMap);
	}
	
	public Map<String, Object> selectCountBugtInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchBugt.selectCountBugtInfo", paramMap);
	}	
	
	public int mergeBugtIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchBugt.mergeBugtIfData", paramMap);
	}
	
	public int insertBugtIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchBugt.insertBugtIfData", paramMap);
	}
	
	public void deleteBugtIfData() {
		sqlSessionTemplate.delete("com.bat.BatchBugt.deleteBugtIfData");
	}	
	
	public int batchBugtIfData( List<Map<String, Object>> list) {
		return sqlSessionTemplate.insert("com.bat.BatchBugt.batchBugtIfData", list);
	}	
	
	public int updateBugtIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchBugt.updateBugtIfData", paramMap);
	}
	
	public void makeBugtData() {
		sqlSessionTemplate.insert("com.bat.BatchBugt.makeBugtData");
	}		
}
