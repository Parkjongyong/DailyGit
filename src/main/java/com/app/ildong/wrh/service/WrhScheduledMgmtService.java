package com.app.ildong.wrh.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.wrh.dao.WrhScheduledMgmtDAO;
import com.app.ildong.wrh.dao.WrhStockDueDateRegistDAO;

@Service("WrhScheduledMgmtService")
public class WrhScheduledMgmtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhScheduledMgmtDAO scheduledMgmtDAO;
	
	@Autowired
	private WrhStockDueDateRegistDAO wrhStockDueDateRegistDAO;	
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectScheduledMgmt(Map<String, Object> paramMap){
		return scheduledMgmtDAO.selectScheduledMgmt(paramMap);
	}

    public Map<String,Object> saveScheduledMgmt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
        Map<String, Object> dataMap = (Map<String, Object>) paramMap.get("ITEM_LIST");
        List<Map<String, Object>> updList = (List<Map<String, Object>>)dataMap.get("UPDATED");
        Map<String,Object> storageSpace = new HashMap<>();
        if (null != updList && 0 < updList.size()) {
            for (Map<String, Object> data: updList) {
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                data.put("TB_DOC_NO"      , paramMap.get("TB_H_DOC_NO"));
                data.put("TB_COMP_CD"     , paramMap.get("TB_COMP_CD"));
                data.put("TB_PLANT_CODE"  , paramMap.get("TB_PLANT_CODE"));
                data.put("TB_LOCATION"    , paramMap.get("TB_LOCATION"));
                data.put("TB_GR_DELY_DATE", paramMap.get("TB_GR_DELY_DATE"));

                scheduledMgmtDAO.saveScheduledMgmt(data);
                // ?????? ????????? ??????
            	storageSpace.put("COMP_CD"          , data.get("COMP_CD"));
            	storageSpace.put("PLANT_CD"         , data.get("PLANT_CODE"));
            	storageSpace.put("STORAGE_CD"       , data.get("LOCATION"));                    	
            	storageSpace.put("STRD_DATE"        , data.get("GR_DELY_DATE"));
            	storageSpace.put("CRE_USER"         , getUserId());
            	storageSpace.put("MOD_USER"         , getUserId());

            	storageSpace.put("TB_COMP_CD"       , data.get("COMP_CD"));
            	storageSpace.put("TB_PLANT_CD"      , data.get("PLANT_CODE"));
            	storageSpace.put("TB_STORAGE_CD"    , data.get("LOCATION"));                    	
            	storageSpace.put("TB_GR_DELY_DATE"  , data.get("GR_DELY_DATE"));

            	
                Map<String, Object> strorageInfo =  wrhStockDueDateRegistDAO.checkStorageSpace(data);
                
                if (!"".equals(strorageInfo.get("CHK_YN")) && null != strorageInfo.get("CHK_YN")) {
                	// ????????? ???????????? ???????????? ??????, ?????? ??????????????? ????????? ????????? ????????????
                	if ("N".equals(strorageInfo.get("CHK_YN"))) {
                		paramMap.put("SUCC_YN", "N");
                		paramMap.put("ERR_MSG", "?????? ???????????? ????????????????????? ???????????????. ?????? ??? ???????????????.");
                		// ????????? Exception ??????
                		throw new Exception("?????? ???????????? ????????????????????? ???????????????. ?????? ??? ???????????????.");
                		
                	}
                }

            	
            	// ?????? ?????? MERGE
                wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
                // ???????????? ???????????? ????????? ?????? ??????
                if (!"".equals(data.get("GR_DELY_DATE_OLD")) && null != data.get("GR_DELY_DATE_OLD")) {
                	// ???????????? ???????????? ?????? ???????????? ?????? ??????
                	if (!data.get("GR_DELY_DATE").equals(data.get("GR_DELY_DATE_OLD"))) {
                        // ?????? ?????? MERGE
                		storageSpace.put("STRD_DATE", data.get("GR_DELY_DATE_OLD"));
                        wrhStockDueDateRegistDAO.mergeStorageSpace(storageSpace);
                	}
                }
            }
        }
        
        paramMap.put("SUCC_YN", "Y");
        
    	return paramMap;
    }	
}