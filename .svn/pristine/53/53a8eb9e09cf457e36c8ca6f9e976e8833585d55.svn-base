package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("supplementDAO")
public class BdgSupplementDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectSupplement(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.Supplement.selectSupplement", paramMap);
	}

	public List<Map<String, Object>> selectSupplementDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.Supplement.selectSupplementDetail", paramMap);
	}

	public List<Map<String, Object>> selectSupplementAmt(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.Supplement.selectSupplementAmt", paramMap);
	}

	public List<Map<String, Object>> selectApprList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.Supplement.selectApprList", paramMap);
	}
	
	public List<Map<String, Object>> selectAccountList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.Supplement.selectAccountList", paramMap);
	}
	
	public List<Map<String, Object>> selectDeptList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.Supplement.selectDeptList", paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.Supplement.selectStatusHeader", paramMap);
    }
	
	public int selectApprStatus(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("com.bdg.Supplement.selectApprStatus", paramMap);
	}		
	
	public void insertSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.insertSupplement", paramMap);
	}
	
	public void insertSupplementDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.insertSupplementDetail", paramMap);
	}	
	
	public void updateSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.updateSupplement", paramMap);
	}
	
	public void updateSupplementDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.updateSupplementDetail", paramMap);
	}	
	
	public void delSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.delSupplement", paramMap);
	}
	
	public void delSupplementDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.delSupplementDetail", paramMap);
	}	
	
	public void apprSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.apprSupplement", paramMap);
	}
	
	public void returnSupplement(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.returnSupplement", paramMap);
	}
	
	public void updateSupplementSap(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.updateSupplementSap", paramMap);
	}
	
	public void saveRemark(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.saveRemark", paramMap);
	}
	
	public List<Map<String, Object>> selectSupplementPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.Supplement.selectSupplementPop", paramMap);
	}
	
	public void updateHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.Supplement.updateHeader", paramMap);
	}
	
	public Map<String, Object> selectEpsInfoData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.Supplement.selectEpsInfoData", paramMap);
    }	


}
