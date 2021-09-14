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
import com.app.ildong.sys.dao.SysMainImageDAO;


@Service("sysMainImageService")
public class SysMainImageService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private SysMainImageDAO sysMainImageDAO;

	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectMainImageList(Map<String, Object> paramMap) {
		return sysMainImageDAO.selectMainImageList(paramMap);
	}
	
	public List<Map<String, Object>> selectInImageList(Map<String, Object> paramMap) {
		return sysMainImageDAO.selectInImageList(paramMap);
	}
	
	public List<Map<String, Object>> selectOutImageList(Map<String, Object> paramMap) {
		return sysMainImageDAO.selectOutImageList(paramMap);
	}
	
    public Map<String,Object> saveMainImage(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("DELETED");
        
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("APP_SEQ", paramMap.get("TB_APP_SEQ"));
            	sysMainImageDAO.saveMainImage(updData);
            }
        }        
        
    	return paramMap;
    }

}
