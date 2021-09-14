package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgEstCostReqDAO")
public class BdgEstCostReqDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectEstCostReqList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.EstCostReq.selectEstCostReqList", paramMap);
	}
	
	public List<Map<String, Object>> selectEstCostReqListPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.EstCostReq.selectEstCostReqListPop", paramMap);
	}
	
	public List<Map<String, Object>> selectEstCostReqDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.EstCostReq.selectEstCostReqDetail", paramMap);
	}
	
	public List<Map<String, Object>> selectSendEstCostReqList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.EstCostReq.selectSendEstCostReqList", paramMap);
	}	
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.EstCostReq.selectStatusHeader", paramMap);
    }
	
	public void updateEstCostReqStatus6(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.updateEstCostReqStatus6", paramMap);
	}
	
	public void updateEstCostReqStatus6All(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.updateEstCostReqStatus6All", paramMap);
	}	
	
	public void updatSendFlag(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.updatSendFlag", paramMap);
	}	
	
	public void apprEstCost(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.apprEstCost", paramMap);
	}
	
	public void updateStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.updateStatus", paramMap);
	} 	
	
	public void updateEstCostReq(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.updateEstCostReq", paramMap);
	}
	
	public void insertEstCostReq(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.insertEstCostReq", paramMap);
	}
	
	public void insertEstCostDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.insertEstCostDetail", paramMap);
	}
	
	public void deleteEstCostReq(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.deleteEstCostReq", paramMap);
	}	
	
	public void deleteEstCostHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.deleteEstCostHead", paramMap);
	}	
	
	public void deleteEstCostDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.deleteEstCostDetail", paramMap);
	}	
	
	public void updatEstCostReqStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.EstCostReq.updatEstCostReqStatus", paramMap);
	}

	public Map<String, Object> getReqDocNo() {
        return sqlSessionTemplate.selectOne("com.bdg.EstCostReq.getReqDocNo");
    }	
	
	public Map<String, Object> selectEstCostCnt(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bdg.EstCostReq.selectEstCostCnt", paramMap);
	}
	
	public List<Map<String, Object>> selectEstCostReqDetailResult(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.EstCostReq.selectEstCostReqDetailResult", paramMap);
	}
	
	
}
