package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("purchaseRecApprDAO")
public class WrhPurchaseRecApprDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectPurchaseRecAppr(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.PurchaseRecAppr.selectPurchaseRecAppr", paramMap);
	}
	
	public void apprPurchaseReceived(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.PurchaseRecAppr.apprPurchaseReceived", paramMap);
	}
	
	public void returnReceived(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.PurchaseRecAppr.returnReceived", paramMap);
	}
	
	public Map<String, Object> checkPurchaseUser(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.wrh.PurchaseRecAppr.checkPurchaseUser", paramMap);
    }	
	
    
}
