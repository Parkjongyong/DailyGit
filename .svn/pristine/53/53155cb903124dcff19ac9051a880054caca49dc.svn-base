package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgDeptCustomerMgmtDAO")
public class BdgDeptCustomerMgmtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDeptCustomerMgmtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.DeptCustomerMgmt.selectDeptCustomerMgmtList", paramMap);
	}
	
	public Map<String, Object> selectDeptCustomerData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.DeptCustomerMgmt.selectDeptCustomerData", paramMap);
    }	
	
	public Map<String, Object> selectCountData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.DeptCustomerMgmt.selectCountData", paramMap);
    }	
	
	public void insertDeptCustomerMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptCustomerMgmt.insertDeptCustomerMgmt", paramMap);
	}
	
	public void updateDeptCustomerMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptCustomerMgmt.updateDeptCustomerMgmt", paramMap);
	}	
	
	public void deleteDeptCustomerMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.DeptCustomerMgmt.deleteDeptCustomerMgmt", paramMap);
	}
	
}
