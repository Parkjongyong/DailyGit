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
package com.app.ildong.sys.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.sys.dao.SysDeptDAO;


@Service("sysDeptService")
public class SysDeptService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private SysDeptDAO deptDAO;

	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectDeptList(Map<String, Object> paramMap)
	{
		return deptDAO.selectDeptList(paramMap);
	}
	
}
