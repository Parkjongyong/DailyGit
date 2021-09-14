package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("FamilyEventDAO")
public class BdgFamilyEventDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectFamilyEvent(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.FamilyEvent.selectFamilyEvent", paramMap);
	}
	
	public List<Map<String, Object>> selectSendFamilyEvent(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.FamilyEvent.selectSendFamilyEvent", paramMap);
	}	
	
	public List<Map<String, Object>> selectOpAccountList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.FamilyEvent.selectFamilyEventAmt", paramMap);
	}
	
	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.FamilyEvent.selectOpDeptList", paramMap);
	}
	
	public Map<String, Object> selectCheckData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.FamilyEvent.selectCheckData", paramMap);
    }	
	
	public void insertFamilyEvent(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.FamilyEvent.insertFamilyEvent", paramMap);
	}
	
	public void updateFamilyEvent(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.FamilyEvent.updateFamilyEvent", paramMap);
	}
	
	public void applyFamilyEvent(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.FamilyEvent.applyFamilyEvent", paramMap);
	}
	
	public void confirmFamilyEvent(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.FamilyEvent.confirmFamilyEvent", paramMap);
	}
	
	public void delFamilyEvent(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.FamilyEvent.delFamilyEvent", paramMap);
	}
}
