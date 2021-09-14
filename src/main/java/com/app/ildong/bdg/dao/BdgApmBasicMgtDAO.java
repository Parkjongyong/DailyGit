package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("ApmBasicMgtDAO")
public class BdgApmBasicMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectApmBasicMgt(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmBasicMgt.selectApmBasicMgt", paramMap);
	}
	
	public Map<String, Object> selectCheckStatusApmBasic(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ApmBasicMgt.selectCheckStatusApmBasic", paramMap);
    }	

	public List<Map<String, Object>> selectApmBasicMgtIf(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmBasicMgt.selectApmBasicMgtIf", paramMap);
	}
	
	public List<Map<String, Object>> selectApmBasicMgtAmt(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmBasicMgt.selectApmBasicMgtAmt", paramMap);
	}
	
	public List<Map<String, Object>> selectSendApmBasicMgt(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmBasicMgt.selectSendApmBasicMgt", paramMap);
	}	
	
	public List<Map<String, Object>> selectOpAccountList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmBasicMgt.selectApmBasicMgtAmt", paramMap);
	}
	
	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmBasicMgt.selectOpDeptList", paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ApmBasicMgt.selectStatusHeader", paramMap);
    }
	
	public Map<String, Object> selectStatusCnt(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ApmBasicMgt.selectStatusCnt", paramMap);
    }	
	
	public void apprApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.apprApmBasicMgt", paramMap);
	}
	
	public void updateStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.updateStatus", paramMap);
	}     	
	
	public void insertApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.insertApmBasicMgt", paramMap);
	}
	
	public void updateApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.updateApmBasicMgt", paramMap);
	}
	
	public void delApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.delApmBasicMgt", paramMap);
	}
	
	public void confirmApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.confirmApmBasicMgt", paramMap);
	}
	
	public void confirmCancelApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.confirmCancelApmBasicMgt", paramMap);
	}
	
	public void returnApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.returnApmBasicMgt", paramMap);
	}
	
	public void rejectApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.rejectApmBasicMgt", paramMap);
	}	
	
	public void updateApmBasicMgtSap(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.updateApmBasicMgtSap", paramMap);
	}
	
	public int sendCheckCnt(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bdg.ApmBasicMgt.sendCheckCnt", paramMap);
	}
	
	public void sendApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.sendApmBasicMgt", paramMap);
	}
	
	public void sendCancelApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.sendCancelApmBasicMgt", paramMap);
	}
	
	public void delAllApmBasicMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.delAllApmBasicMgt", paramMap);
	}
	
	public void delAllApmIf(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.delAllApmIf", paramMap);
	}
	
	public void insertApmIf(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.insertApmIf", paramMap);
	}
	
	public void insertApmBasic(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ApmBasicMgt.insertApmBasic", paramMap);
	}	

	public List<Map<String, Object>> selectApmBasicMgtPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ApmBasicMgt.selectApmBasicMgtPop", paramMap);
	}

}
