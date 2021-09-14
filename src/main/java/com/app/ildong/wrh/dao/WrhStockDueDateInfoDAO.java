package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wrhStockDueDateInfoDAO")
public class WrhStockDueDateInfoDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectStockDueDateInfoList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StockDueDateInfo.selectStockDueDateInfoList", paramMap);
	}
	
	public List<Map<String, Object>> selectDueDateInfo(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StockDueDateInfo.selectDueDateInfo", paramMap);
	}	
	
	
	
	public void updateDeliveryHeadStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateInfo.updateDeliveryHeadStatus", paramMap);
	}
	
	public void delDeliveryHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateInfo.delDeliveryHead", paramMap);
	}	
	
	public void delDeliveryItem(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateInfo.delDeliveryItem", paramMap);
	}		

	public List<Map<String, Object>> selectAccountInfoList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StockDueDateInfo.selectAccountInfoList", paramMap);
	}

}
