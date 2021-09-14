package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("receivedApprDAO")
public class WrhReceivedApprDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectReceivedAppr(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.ReceivedAppr.selectReceivedAppr", paramMap);
	}
	
	public void apprReceived(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.ReceivedAppr.apprReceived", paramMap);
	}
	
	public Map<String, Object> checkConfirmUser(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.wrh.ReceivedAppr.checkConfirmUser", paramMap);
    }	
	
	public void returnReceived(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.ReceivedAppr.returnReceived", paramMap);
	}
	
	public void returnReceivedPo(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.ReceivedAppr.returnReceivedPo", paramMap);
	}
	
	public int selectDeliveryHeaderInfo(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectOne("com.wrh.ReceivedAppr.selectDeliveryHeaderInfo", paramMap);
	}
    
	public List<Map<String, Object>> selectSendList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.ReceivedAppr.selectSendList", paramMap);
	}
	
}
