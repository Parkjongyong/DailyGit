package com.app.ildong.bdg.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bdg.dao.BdgPromDetailDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;

@Service("BdgPromDetailService")
public class BdgPromDetailService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgPromDetailDAO promDetail;
	
	@Autowired
	private CommonSelectDAO commonSelectDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectPromDetail(Map<String, Object> paramMap){
		return promDetail.selectPromDetail(paramMap);
	}
	
	public List<Map<String, Object>> selectPromDetailExcel(Map<String, Object> paramMap){
		return promDetail.selectPromDetailExcel(paramMap);
	}
	
	public List<Map<String, Object>> selectOpAccountList(Map<String, Object> paramMap){
		return promDetail.selectOpAccountList(paramMap);
	}
	
	public List<Map<String, Object>> selectOpDeptList(Map<String, Object> paramMap){
		return promDetail.selectOpDeptList(paramMap);
	}
	
    public Map<String,Object> delPromDetail(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
    	if (null != delList && 0 < delList.size()) {
    		for (Map<String, Object> data: delList) {
    			promDetail.delPromDetail(data);
    		}
    	}
        
    	
    	return paramMap;
    }
    
    public Map<String,Object> savePromDetail(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("CHECK_LIST");
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> updData: updList) {
            	updData.put("CRE_USER"   , getUserId());
            	updData.put("MOD_USER"   , getUserId());
            	promDetail.updatePromDetail(updData);
            	
            }
        }        
    	return paramMap;
    }
 
    public Map<String,Object> savePromDetailExcel(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
		paramMap.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
		paramMap.put("CRTN_YYMM"  , paramMap.get("TB_CRTN_YYMM"));
		paramMap.put("ORG_CD"     , paramMap.get("TB_ORG_CD"));
		paramMap.put("CHC_ETC_GBN", paramMap.get("SB_CHC_ETC_GBN"));
		paramMap.put("DISTRIB_CD" , paramMap.get("SB_DIST"));
        
        if (paramMap.get("ITEM_LIST") != null) {

        	promDetail.delPromDetailExcel(paramMap);
            
            for (Map<String, Object> dataMap : (List<Map<String, Object>>)paramMap.get("ITEM_LIST")) {
            	
                Map <String,Object> oMap = new  HashMap<>();
                
                oMap.put("COMP_CD", paramMap.get("SB_COMP_CD"));
                oMap.put("CRTN_YYMM", paramMap.get("TB_CRTN_YYMM"));
                oMap.put("ORG_CD", paramMap.get("TB_ORG_CD"));
                oMap.put("CHC_ETC_GBN", paramMap.get("SB_CHC_ETC_GBN"));
                
                oMap.put("REQ_SABUN", dataMap.get("REQ_SABUN"));
                oMap.put("DISTRIB_CD", dataMap.get("DISTRIB_CD"));
                oMap.put("FORWARD_AMT", dataMap.get("FORWARD_AMT"));
                oMap.put("BAL_BUGT_AMT", dataMap.get("BAL_BUGT_AMT"));
                oMap.put("ETC_BUGT_AMT", dataMap.get("ETC_BUGT_AMT"));
                
                Map<String, Object> resultMap = promDetail.receptionPromDetail(oMap);
                
                oMap.put("RESULT_AMT", StringUtil.isNullToString(resultMap.get("RESULT_AMT")));
                promDetail.insertPromDetailExcel(oMap);
            }
        }
		
		
		
    	return paramMap;
    }
    
    public Map<String,Object> savePromDetailUpload(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	paramMap.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
    	paramMap.put("CRTN_YYMM"  , paramMap.get("TB_CRTN_YYMM"));
    	paramMap.put("ORG_CD"     , paramMap.get("TB_ORG_CD"));
    	paramMap.put("CHC_ETC_GBN", paramMap.get("SB_CHC_ETC_GBN"));
    	paramMap.put("DISTRIB_CD" , paramMap.get("SB_DIST"));
    	
   		promDetail.delPromDetailUpload(paramMap);
		promDetail.savePromDetailUpload(paramMap);
		
    	return paramMap;
    }
 
	public Map<String,Object> receptionPromDetail(Map<String, Object> paramMap) throws ServiceException, Exception {
		
    	Map<String, Object> receptionMap        = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> receptionList = (List<Map<String, Object>>) receptionMap.get("CHECK_LIST");
    	
		if (paramMap.get("ITEM_LIST") != null) {
			for (Map<String, Object> data : receptionList) {
				Map<String, Object> resultMap = promDetail.receptionPromDetail(data);
				data.put("MOD_USER", getUserId());
				data.put("RESULT_AMT", StringUtil.isNullToString(resultMap.get("RESULT_AMT")));
				promDetail.updatePromDetail2(data);
			}		
		}
		
		return paramMap;
	}
    
    
}