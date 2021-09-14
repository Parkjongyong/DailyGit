package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wrhVendorInfoDAO")
public class WrhVendorInfoDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVendorPurchOrgList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.VendorInfo.selectVendorPurchOrgList", paramMap);
	}
	
	public Map<String, Object> selectVendorInfo(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.wrh.VendorInfo.selectVendorInfo", paramMap);
    }	
	
	public List<Map<String, Object>> selectVendorUserList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.VendorInfo.selectVendorUserList", paramMap);
	}
	
	public void insertVendorUser(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.VendorInfo.insertVendorUser", paramMap);
	}
	
	public void updateVendorUser(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.VendorInfo.updateVendorUser", paramMap);
	}
	
	public void deleteVendorUser(Map<String, Object> paramMap) {
		sqlSessionTemplate.delete("com.wrh.VendorInfo.deleteVendorUser", paramMap);
	}	
}
