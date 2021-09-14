package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatPurchOrderDAO")
public class BatPurchOrderDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public Map<String, Object> selectCountPOHederInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchPurchOrder.selectCountPOHederInfo", paramMap);
	}
	
	public int mergePOHederIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.mergePOHederIfData", paramMap);
	}
	
	public int mergePOHederRemkIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.mergePOHederRemkIfData", paramMap);
	}
	
	public int mergePOItemIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.mergePOItemIfData", paramMap);
	}
	
	public int mergePOItemRemkIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.mergePOItemRemkIfData", paramMap);
	}	
	
	public int insertPOHederIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.insertPOHederIfData", paramMap);
	}	
	
	public int updatePOHederIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.updatePOHederIfData", paramMap);
	}
	
	public void makePOHederData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.BatchPurchOrder.makePOHederData", paramMap);
	}
	
	
	public Map<String, Object> selectCountPOHederRemkInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchPurchOrder.selectCountPOHederRemkInfo", paramMap);
	}	
	
	public int insertPOHederRemkIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.insertPOHederRemkIfData", paramMap);
	}	
	
	public int updatePOHederRemkIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.updatePOHederRemkIfData", paramMap);
	}
	
	public void makePOHederRemkData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.BatchPurchOrder.makePOHederRemkData", paramMap);
	}
	
	
	public Map<String, Object> selectCountPOItemInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchPurchOrder.selectCountPOItemInfo", paramMap);
	}	
	
	public int insertPOItemIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.insertPOItemIfData", paramMap);
	}	
	
	public int updatePOItemIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.updatePOItemIfData", paramMap);
	}
	
	public void makePOItemData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.BatchPurchOrder.makePOItemData", paramMap);
	}	
	
	
	public Map<String, Object> selectCountPOItemRemkInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchPurchOrder.selectCountPOItemRemkInfo", paramMap);
	}	
	
	public int insertPOItemRemkIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.insertPOItemRemkIfData", paramMap);
	}	
	
	public int updatePOItemRemkIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchPurchOrder.updatePOItemRemkIfData", paramMap);
	}
	
	public void makePOItemRemkData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bat.BatchPurchOrder.makePOItemRemkData", paramMap);
	}
	
	public void updatePOHederFlag() {
		sqlSessionTemplate.insert("com.bat.BatchPurchOrder.updatePOHederFlag");
	}	
	
	public void updatePOHederRemkFlag() {
		sqlSessionTemplate.insert("com.bat.BatchPurchOrder.updatePOHederRemkFlag");
	}	
	
	public void updatePOItemFlag() {
		sqlSessionTemplate.insert("com.bat.BatchPurchOrder.updatePOItemFlag");
	}	
	
	public void updatePOItemRemkFlag() {
		sqlSessionTemplate.insert("com.bat.BatchPurchOrder.updatePOItemRemkFlag");
	}		

}
