package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("OpSupplementDAO")
public class BdgOpSupplementDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectOpSupplement(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpSupplement.selectOpSupplement", paramMap);
	}

	public List<Map<String, Object>> selectOpSupplementAmt(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpSupplement.selectOpSupplementAmt", paramMap);
	}

	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.OpSupplement.selectOpDeptList", paramMap);
	}
	
	public void insertOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.insertOpSupplement", paramMap);
	}
	
	public void updateOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.updateOpSupplement", paramMap);
	}
	
	public void delOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.delOpSupplement", paramMap);
	}
	
	public void confirmOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.confirmOpSupplement", paramMap);
	}
	
	public void confirmCancelOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.confirmCancelOpSupplement", paramMap);
	}
	
	public void returnOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.returnOpSupplement", paramMap);
	}
	
	public void updateOpSupplementSap(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.updateOpSupplementSap", paramMap);
	}
	
	public int sendCheckCnt(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bdg.OpSupplement.sendCheckCnt", paramMap);
	}
	
	public void sendOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.sendOpSupplement", paramMap);
	}
	
	public void sendCancelOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.sendCancelOpSupplement", paramMap);
	}
	
	public void updatSendOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.updatSendOpSupplement", paramMap);
	}
	
	public void updateCancelOpSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.OpSupplement.updateCancelOpSupplement", paramMap);
	}	

	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.OpSupplement.selectStatusHeader", paramMap);
    }	

}
