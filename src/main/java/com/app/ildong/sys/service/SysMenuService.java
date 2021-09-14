/**
 * 메뉴 조회/등록/삭제 서비스
 * @author 길용덕
 * @since 2020.06.17
 * 
 * << 개정이력(Modification Information) >>
 *  ------------------------------------------------- 
 *  수정일                    수정자            수정내용
 *  ----------   -------- ---------------------------
 *  2020.06.17   길용덕            최초생성
 *  -------------------------------------------------
 */
package com.app.ildong.sys.service;

import java.util.List;

import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ecbank.framework.exception.BizException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.sys.dao.SysMenuDAO;


@Service("sysMenuService")
public class SysMenuService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private SysMenuDAO menuDAO;

	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMenuList(Map<String, Object> paramMap)
	{
		return menuDAO.selectMenuList(paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMenuDetailList(Map<String, Object> paramMap)
	{
		return menuDAO.selectMenuDetailList(paramMap);
	}
	
	/**
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String,Object> updateMenu(Map<String,Object> paramMap) throws BizException, Exception {
		String mode = (String)ObjectUtils.defaultIfNull(paramMap.get("MODE"), "");
		
		paramMap.put("COMP_CD", getCompCd());
		paramMap.put("REG_ID" , getUserId());
		//추가
		if("ADD".equals(mode))
		{
			menuDAO.insertMenuDetail(paramMap);
		}
		//수정
		else
		{
			menuDAO.updateMenuDetail(paramMap);
		}
		
		return paramMap;
	}
	
	/**
	 * @param paramMap
	 * @return
	 * @throws BizException
	 * @throws Exception
	 */
	public Map<String,Object> deleteMenu(Map<String,Object> paramMap) throws BizException, Exception {
		paramMap.put("REG_ID" , getUserId());
		
		String menuCd = paramMap.get("MENU_CD_ARR").toString();
		String[] menuCdArr = menuCd.split(",");
		paramMap.put("MENU_CD_ARR", menuCdArr);
		Map<String,Object> oChkMap = menuDAO.checkDeleteMenuList(paramMap);
		if(!"0".equals(String.valueOf(oChkMap.get("CNT")))) {
//			throw new BizException("sys.menu.delete.existRole");//권한 등록된 메뉴가 있어 삭제 할수 없습니다.
			throw new BizException("권한 등록된 메뉴가 있어 삭제 할수 없습니다.");//권한 등록된 메뉴가 있어 삭제 할수 없습니다.
		}
		menuDAO.deleteMenu(paramMap);
		
		return paramMap;
	}
}
