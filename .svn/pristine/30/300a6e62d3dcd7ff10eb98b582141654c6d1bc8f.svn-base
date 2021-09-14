package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgAccountMgmtDAO")
public class BdgAccountMgmtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectAccountMgmtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.AccountMgmt.selectAccountMgmtList", paramMap);
	}
	
	public Map<String, Object> selectCountData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.AccountMgmt.selectCountData", paramMap);
    }	
	
	public Map<String, Object> selectDistribYn(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bdg.AccountMgmt.selectDistribYn", paramMap);
	}	
	
	public List<Map<String, Object>> selectProjList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.AccountMgmt.selectProjList", paramMap);
	}
	
	
	public void insertAccountMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.AccountMgmt.insertAccountMgmt", paramMap);
	}
	
	public void updateAccountMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.AccountMgmt.updateAccountMgmt", paramMap);
	}	
	
	public void deleteAccountMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.AccountMgmt.deleteAccountMgmt", paramMap);
	}
	
}
