package com.app.ildong.bat.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatInvoiceDAO")
public class BatInvoiceDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public Map<String, Object> selectCountInvoiceHeadInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchInvoice.selectCountInvoiceHeadInfo", paramMap);
	}	
	
	public int insertInvoiceHeadData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchInvoice.insertInvoiceHeadData", paramMap);
	}	
	
	public int updateInvoiceHeadData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchInvoice.updateInvoiceHeadData", paramMap);
	}
	
	public int mergeInvoiceHeadInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchInvoice.mergeInvoiceHeadInfo", paramMap);
	}	
	
	public Map<String, Object> selectCountInvoiceItemInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchInvoice.selectCountInvoiceItemInfo", paramMap);
	}	
	
	public int insertInvoiceItemData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchInvoice.insertInvoiceItemData", paramMap);
	}	
	
	public int updateInvoiceItemData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchInvoice.updateInvoiceItemData", paramMap);
	}
	
	public int mergeInvoiceItemInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchInvoice.mergeInvoiceItemInfo", paramMap);
	}	

}
