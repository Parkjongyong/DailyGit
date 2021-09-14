package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("basicMgtDAO")
public class BdgBasicMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectAccountList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BasicMgt.selectAccountList", paramMap);
	}
	
	public List<Map<String, Object>> selectDeptList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BasicMgt.selectDeptList", paramMap);
	}
	
	public List<Map<String, Object>> selectProjList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BasicMgt.selectProjList", paramMap);
	}
	
	public List<Map<String, Object>> selectBasicMgtHeader(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BasicMgt.selectBasicMgtHeader", paramMap);
	}
	
	public List<Map<String, Object>> selectBbugdet(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BasicMgt.selectBbugdet", paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.BasicMgt.selectStatusHeader", paramMap);
    }

	public Map<String, Object> selectBugtSumData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.BasicMgt.selectBugtSumData", paramMap);
    }
	
	public Map<String, Object> selectStatusHeader2(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.BasicMgt.selectStatusHeader2", paramMap);
    }	
	
	public List<Map<String, Object>> selectBasicMgtDetail(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BasicMgt.selectBasicMgtDetail", paramMap);
	}
	
	public void saveBasicMgtHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.saveBasicMgtHeader", paramMap);
	}
	
	public void apprBasicMgtHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.apprBasicMgtHeader", paramMap);
	}
	
	public void returnBasicMgtHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.returnBasicMgtHeader", paramMap);
	}
	
	public void saveBasicMgtDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.saveBasicMgtDetail", paramMap);
	}
	
	public void delBasicH(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.delBasicH", paramMap);
	}
	
	public void delBasicD(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.delBasicD", paramMap);
	}
	
	public void delBasicMgtDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.delBasicMgtDetail", paramMap);
	}
	
	public void saveHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.saveHeader", paramMap);
	}
	
	public void updateHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.updateHeader", paramMap);
	}	
    
	public void saveBasicMaster(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.saveBasicMaster", paramMap);
	}
	
	public void apprBasicMgtHeader2(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.BasicMgt.apprBasicMgtHeader2", paramMap);
	}
	
	public List<Map<String, Object>> selectBasicMgtHeaderPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.BasicMgt.selectBasicMgtHeaderPop", paramMap);
	}
	
	public Map<String, Object> selectEpsInfoData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.BasicMgt.selectEpsInfoData", paramMap);
    }	

}
