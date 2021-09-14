package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wrhStockDueDateRegistDAO")
public class WrhStockDueDateRegistDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectWhrStockDueDateRegistList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StockDueDateRegist.selectWhrStockDueDateRegistList", paramMap);
	}
	
	public Map<String, Object> selectWhrStockDueDateRegistheaderInfo(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.wrh.StockDueDateRegist.selectWhrStockDueDateRegistheaderInfo", paramMap);
    }
	
	public Map<String, Object> selectStatusDueDateRegist(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.wrh.StockDueDateRegist.selectStatusDueDateRegist", paramMap);
    }
	
	public Map<String, Object> checkStorageSpace(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.wrh.StockDueDateRegist.checkStorageSpace", paramMap);
    }
	
	public Map<String, Object> selectPltQty(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.wrh.StockDueDateRegist.selectPltQty", paramMap);
    }	
	
		
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectWhrStockDueDateRegistDetailList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StockDueDateRegist.selectWhrStockDueDateRegistDetailList", paramMap);
	}
	
	public void insertDeliveryHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateRegist.insertDeliveryHead", paramMap);
	}
	
	public void insertDeliveryItem(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateRegist.insertDeliveryItem", paramMap);
	}
	
	public void mergeStorageSpace(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateRegist.mergeStorageSpace", paramMap);
	}	
	
	
	
	public void updateDeliveryHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateRegist.updateDeliveryHead", paramMap);
	}
	
	public void updateDeliveryHeadStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateRegist.updateDeliveryHeadStatus", paramMap);
	}	
	
	
	public void deleteAllDeliveryItem(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateRegist.deleteAllDeliveryItem", paramMap);
	}
	
	public void deleteDeliveryItem(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.StockDueDateRegist.deleteDeliveryItem", paramMap);
	}		
	
	public List<Map<String, Object>> selectWhrStockDueDateReceiverList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StockDueDateRegist.selectWhrStockDueDateReceiverList", paramMap);
	}
	
	public List<Map<String, Object>> selectWhrStockDueDateReceiverSmsList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.StockDueDateRegist.selectWhrStockDueDateReceiverSmsList", paramMap);
	}
	
	public int insertSmsData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.wrh.StockDueDateRegist.insertSmsData", paramMap);
	}

	
}
