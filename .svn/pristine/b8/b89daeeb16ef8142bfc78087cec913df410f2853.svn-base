package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgTangAssetMgtDAO")
public class BdgTangAssetMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectTangAssetMgtHeadList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TangAsset.selectTangAssetMgtHeadList", paramMap);
	}
	
	public List<Map<String, Object>> selectTangAssetDetailList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TangAsset.selectTangAssetDetailList", paramMap);
	}
	
	public List<Map<String, Object>> selectTangAssetTotalList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TangAsset.selectTangAssetTotalList", paramMap);
	}
	
	public Map<String, Object> selectInvestNo(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.TangAsset.selectInvestNo", paramMap);
    }	
	
	public Map<String, Object> selectCapitalDate(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.TangAsset.selectCapitalDate", paramMap);
    }
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.TangAsset.selectStatusHeader", paramMap);
    }
	
	public List<Map<String, Object>> selectApprList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TangAsset.selectApprList", paramMap);
	}	
	
	public void apprTangAssetMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.apprTangAssetMgt", paramMap);
	}	
	
	public void saveTangAssetMgtHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.saveTangAssetMgtHead", paramMap);
	}
	
	public void saveTangAssetMgtDetail(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.saveTangAssetMgtDetail", paramMap);
	}	
	
	public void updateTangAssetMgtStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.updateTangAssetMgtStatus", paramMap);
	}
	
	public void rejectTangAssetMgtStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.rejectTangAssetMgtStatus", paramMap);
	}	
	
	public void sendSapTangAssetData(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.sendSapTangAssetData", paramMap);
	}
	
	public void updateTangAssetHeadDate(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.updateTangAssetHeadDate", paramMap);
	}
	
	public void updateTangAssetHeadDelFlag(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.updateTangAssetHeadDelFlag", paramMap);
	}	
	
	public void deletTangAssetMgtHead(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.deletTangAssetMgtHead", paramMap);
	}
	
	public void deletTangAssetMgtDeatil(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.deletTangAssetMgtDeatil", paramMap);
	}
	
	
	public List<Map<String, Object>> selectSendAssetData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectList("com.bdg.TangAsset.selectSendAssetData", paramMap);
    }	

	public List<Map<String, Object>> selectTangAssetMgtHeadListPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.TangAsset.selectTangAssetMgtHeadListPop", paramMap);
	}
	
	public void updateHeader(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.TangAsset.updateHeader", paramMap);
	}
	
	public Map<String, Object> selectEpsInfoData(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.TangAsset.selectEpsInfoData", paramMap);
    }	
	

}
