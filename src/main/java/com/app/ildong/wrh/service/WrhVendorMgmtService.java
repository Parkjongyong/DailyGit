/**
 * 공급업체  INFO/PURCHORG/USER 조회/저장 서비스
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
package com.app.ildong.wrh.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhVendorMgmtDAO;

@Service("vendorMgmtService")
public class WrhVendorMgmtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhVendorMgmtDAO vendorMgmtDAO;
	
	@Autowired
    private DigestUtil digestUtil;	
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVendorMgmtList(Map<String, Object> paramMap){
		return vendorMgmtDAO.selectVendorMgmtList(paramMap);
	}
	
    public Map<String,Object> initialWhrVendorMgmt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	List<Map<String, Object>> updList = (List<Map<String, Object>>) paramMap.get("ALLDATA");
        
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                
                String userId       =  (String) data.get("POBUSI_NO");
        		String encryptedPwd = digestUtil.digest("#"+userId, userId);
        		data.put("USER_PW", encryptedPwd);
        		
                vendorMgmtDAO.initialWhrVendorMgmt(data);
            }
        }
        
    	return paramMap;
    }	
}