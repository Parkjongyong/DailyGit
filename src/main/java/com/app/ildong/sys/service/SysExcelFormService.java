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

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.sys.dao.SysExcelFormDAO;


@Service("sysExcelFormService")
public class SysExcelFormService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private SysExcelFormDAO excelFormDAO;

	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectExcelFormList(Map<String, Object> paramMap)
	{
		return excelFormDAO.selectExcelFormList(paramMap);
	}
	
	
	public Map<String, Object> selectExcelForm(Map<String, Object> paramMap)
	{
		return excelFormDAO.selectExcelForm(paramMap);
	}
	
    public Map<String,Object> saveExcelForm(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("DELETED");
        
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("APP_SEQ", paramMap.get("APP_SEQ"));
            	excelFormDAO.saveExcelForm(updData);
            }
        }        
        
    	return paramMap;
    }

}
