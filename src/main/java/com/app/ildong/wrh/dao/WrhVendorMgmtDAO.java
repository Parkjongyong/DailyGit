/**
 * 공급업체  INFO/PURCHORG/USER 조회/저장 DAO
 * @author 길용덕
 * @since 2020.07.15
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.07.15   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.wrh.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("vendorMgmtDAO")
public class WrhVendorMgmtDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVendorMgmtList(Map<String, Object> paramMap){
		return sqlSessionTemplate.selectList("com.wrh.VendorMgmt.selectVendorMgmtList", paramMap);
	}
	
	public void initialWhrVendorMgmt(Map<String, Object> paramMap) {
		sqlSessionTemplate.insert("com.wrh.VendorMgmt.initialWhrVendorMgmt", paramMap);
	}	
	
}
