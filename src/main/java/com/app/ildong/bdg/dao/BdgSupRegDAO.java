package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("SupRegDAO")
public class BdgSupRegDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectSupReg(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.SupReg.selectSupReg", paramMap);
	}
	
	public Map<String, Object> selectSendSapSupReg(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.SupReg.selectSendSapSupReg", paramMap);
    }
	
	public Map<String, Object> selectCheckSupReg(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.SupReg.selectCheckSupReg", paramMap);
    }	
	
	public List<Map<String, Object>> selectSendSupReg(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.SupReg.selectSendSupReg", paramMap);
	}	
	
	public List<Map<String, Object>> selectOpAccountList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.SupReg.selectSupRegAmt", paramMap);
	}
	
	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.SupReg.selectOpDeptList", paramMap);
	}
	
	public void insertSupReg(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.SupReg.insertSupReg", paramMap);
	}
	
	public void updateSupReg(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.SupReg.updateSupReg", paramMap);
	}
	
	public void updateStatusSupReg(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.SupReg.updateStatusSupReg", paramMap);
	}	
	
	public void applySupReg(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.SupReg.applySupReg", paramMap);
	}
	
	public void applyCancelSupReg(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.SupReg.applyCancelSupReg", paramMap);
	}
	
	public void returnSupReg(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.SupReg.returnSupReg", paramMap);
	}
	
	public void delSupReg(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.SupReg.delSupReg", paramMap);
	}
}
