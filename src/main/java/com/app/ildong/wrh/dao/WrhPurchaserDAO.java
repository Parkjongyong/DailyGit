package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("purchaserDAO")
public class WrhPurchaserDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectPurchaserList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.Purchaser.selectPurchaserList", paramMap);
	}
	
	public void updatePurchaser(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.Purchaser.updatePurchaser", paramMap);
	}

	public void insertPurchaser(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.Purchaser.insertPurchaser", paramMap);
	}
	public void deletePurchaser(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.wrh.Purchaser.deletePurchaser", paramMap);
	}
	
    
}
