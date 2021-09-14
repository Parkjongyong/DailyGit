package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("scheduledMgmtDAO")
public class WrhScheduledMgmtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectScheduledMgmt(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.ScheduledMgmt.selectScheduledMgmt", paramMap);
	}
	
	public void saveScheduledMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.ScheduledMgmt.saveScheduledMgmt", paramMap);
	}

}
