package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("meetingMgmtDAO")
public class BdgMeetingMgmtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMeetingMgmt(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.MeetingMgmt.selectMeetingMgmt", paramMap);
	}
	
	public List<Map<String, Object>> selectMeetingMgmt2(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.MeetingMgmt.selectMeetingMgmt2", paramMap);
	}
	
	public void insertMeetingMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.MeetingMgmt.insertMeetingMgmt", paramMap);
	}
	
	public void deleteMeetingMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.MeetingMgmt.deleteMeetingMgmt", paramMap);
	}	

}
