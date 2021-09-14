package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("modifyMgtDAO")
public class BdgModifyMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectAccountList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ModifyMgt.selectAccountList", paramMap);
	}
	
	public List<Map<String, Object>> selectDeptList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ModifyMgt.selectDeptList", paramMap);
	}
	
	public List<Map<String, Object>> selectModifyMgtHeader(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ModifyMgt.selectModifyMgtHeader", paramMap);
	}
	
	public List<Map<String, Object>> selectModifyMgtDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ModifyMgt.selectModifyMgtDetail", paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ModifyMgt.selectStatusHeader", paramMap);
    }
	
	public Map<String, Object> selectStatusHeader2(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ModifyMgt.selectStatusHeader2", paramMap);
    }	
	
	public void saveModifyMgtHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.saveModifyMgtHeader", paramMap);
	}
	
	public void apprModifyMgtHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.apprModifyMgtHeader", paramMap);
	}
	
	public void returnModifyMgtHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.returnModifyMgtHeader", paramMap);
	}
	
	public void saveModifyMgtDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.saveModifyMgtDetail", paramMap);
	}
	
	public void delModifyH(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.delModifyH", paramMap);
	}
	
	public void delModifyD(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.delModifyD", paramMap);
	}
	
	public void delModifyMgtDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.delModifyMgtDetail", paramMap);
	}
	
	public void saveModifyRemark(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.saveModifyRemark", paramMap);
	}
	
	public void createModifyMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.createModifyMgt", paramMap);
	}
	
	public void saveModifyMaster(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.saveModifyMaster", paramMap);
	}

	public List<Map<String, Object>> selectModifyMgtHeaderPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.ModifyMgt.selectModifyMgtHeaderPop", paramMap);
	}
	
	public void updateHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.ModifyMgt.updateHeader", paramMap);
	}	

	public Map<String, Object> selectEpsInfoData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.ModifyMgt.selectEpsInfoData", paramMap);
    }	
}
