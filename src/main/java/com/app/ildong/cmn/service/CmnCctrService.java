/**
 * 부서 조회 서비스
 * @author 길용덕
 * @since 2020.07.08
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.07.08   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.cmn.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.cmn.dao.CmnCctrDAO;
import com.app.ildong.common.model.mvc.BaseService;


@Service("cmnCctrService")
public class CmnCctrService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private CmnCctrDAO cctrDAO;

	/**
	 * @param paramMap
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> selectCctrList(Map<String, Object> paramMap) throws Exception {
		paramMap.put("COMP_CD", getCompCd());
		paramMap.put("DEPT_CD", getDeptCd());
		return cctrDAO.selectCctrList(paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> selectCctrListA(Map<String, Object> paramMap) throws Exception {
		paramMap.put("COMP_CD", getCompCd());
		paramMap.put("USER_ID", getUserId());
		return cctrDAO.selectCctrListA(paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> selectCctrListB(Map<String, Object> paramMap) throws Exception {
		paramMap.put("COMP_CD", getCompCd());
		paramMap.put("DEPT_CD", getDeptCd());
		return cctrDAO.selectCctrListB(paramMap);
	}	
	
}
