package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("invoiceInfoDAO")
public class WrhInvoiceInfoDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectInvoiceInfo(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.InvoiceInfo.selectInvoiceInfo", paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectInvoiceInfoDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.InvoiceInfo.selectInvoiceInfoDetail", paramMap);
	}
	
}
