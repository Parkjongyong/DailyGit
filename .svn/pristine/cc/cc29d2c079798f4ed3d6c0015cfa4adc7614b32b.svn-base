package com.app.ildong.bat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("BatVendorDAO")
public class BatVendorDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public Map<String, Object> selectCountVendorInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchVendor.selectCountVendorInfo", paramMap);
	}
	
	public Map<String, Object> selectCountSysUserInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchVendor.selectCountSysUserInfo", paramMap);
	}	
	
	public int insertVendorIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchVendor.insertVendorIfData", paramMap);
	}
	
	public List<Map<String, Object>> selectVendorUserCreateList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bat.BatchVendor.selectVendorUserCreateList", paramMap);
	}	
	
	public int insertSysUserData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchVendor.insertSysUserData", paramMap);
	}
	
	public int insertSysUserRoleData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchVendor.insertSysUserRoleData", paramMap);
	}	
	
	public int updateVendorIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchVendor.updateVendorIfData", paramMap);
	}
	
	public int updateSysUserData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchVendor.updateSysUserData", paramMap);
	}	
	
	public void makeVendorData() {
		sqlSessionTemplate.insert("com.bat.BatchVendor.makeVendorData");
	}
	
	public void updateVendorFlag() {
		sqlSessionTemplate.insert("com.bat.BatchVendor.updateVendorFlag");
	}		
	
	
	public Map<String, Object> selectCountVendPurchorgInfo(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bat.BatchVendor.selectCountVendPurchorgInfo", paramMap);
	}	
	
	public int insertVendPurchorgIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchVendor.insertVendPurchorgIfData", paramMap);
	}	
	
	public int updateVendPurchorgIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchVendor.updateVendPurchorgIfData", paramMap);
	}
	
	public void makeVendPurchorgData() {
		sqlSessionTemplate.insert("com.bat.BatchVendor.makeVendPurchorgData");
	}
	
	public void updateVendPurchorgFlag() {
		sqlSessionTemplate.insert("com.bat.BatchVendor.updateVendPurchorgFlag");
	}
	
	public void makeVendUserData() {
		sqlSessionTemplate.insert("com.bat.BatchVendor.makeVendUserData");
	}	
	
	public int mergeVendorIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchVendor.mergeVendorIfData", paramMap);
	}
	
	public int mergeVendPurchorgIfData(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("com.bat.BatchVendor.mergeVendPurchorgIfData", paramMap);
	}	
}
