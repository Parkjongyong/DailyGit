package com.app.ildong.bdg.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bdgVendBankMgtDAO")
public class BdgVendBankMgtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVendBankMgtHeadList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VendBankMgt.selectVendBankMgtHeadList", paramMap);
	}
	
	public List<Map<String, Object>> selectApprVendBankList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VendBankMgt.selectApprVendBankList", paramMap);
	}	
	
	public List<Map<String, Object>> selectVendBankMgtDetailList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VendBankMgt.selectVendBankMgtDetailList", paramMap);
	}
	
	public List<Map<String, Object>> selectVendBankMgtHeadListPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VendBankMgt.selectVendBankMgtHeadListPop", paramMap);
	}
	
	public List<Map<String, Object>> selectVendBankMgtDetailListPop(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VendBankMgt.selectVendBankMgtDetailListPop", paramMap);
	}	
	
	public List<Map<String, Object>> selectSendVendBankData(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.bdg.VendBankMgt.selectSendVendBankData", paramMap);
	}
	
	public Map<String, Object> selectHeadFlagYn(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.VendBankMgt.selectHeadFlagYn", paramMap);
    }
	
	public Map<String, Object> selectCheckVendBankMgt(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.VendBankMgt.selectCheckVendBankMgt", paramMap);
    }	
	
	public Map<String, Object> selectDetailFlagYn(Map<String, Object> paramMap) {
        return sqlSessionTemplate.selectOne("com.bdg.VendBankMgt.selectDetailFlagYn", paramMap);
    }	
	
	public void updatVendBankMgtStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VendBankMgt.updatVendBankMgtStatus", paramMap);
	}
	
	public void updatVendBankMgtEpsStatus(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VendBankMgt.updatVendBankMgtEpsStatus", paramMap);
	}
	
	public void updatSendFlag(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VendBankMgt.updatSendFlag", paramMap);
	}
	
	public void updatVendBankMgtStatus6(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VendBankMgt.updatVendBankMgtStatus6", paramMap);
	}	
	
	public void saveVendBankHeadMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VendBankMgt.saveVendBankHeadMgt", paramMap);
	}
	
	public void saveVendBankDetailMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VendBankMgt.saveVendBankDetailMgt", paramMap);
	}	
	
	public void deleteVendBankHeadMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VendBankMgt.deleteVendBankHeadMgt", paramMap);
	}
	
	public void deleteVendBankDetailMgt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VendBankMgt.deleteVendBankDetailMgt", paramMap);
	}
	
	public void deleteVendBankDetailMgt2(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.bdg.VendBankMgt.deleteVendBankDetailMgt2", paramMap);
	}	
	
}
