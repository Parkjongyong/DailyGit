package com.app.ildong.bdg.service;

import java.util.ArrayList;
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

import com.app.ildong.bdg.dao.BdgTravelCalDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BdgTravelCalService")
public class BdgTravelCalService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgTravelCalDAO travelCalDAO;
	
    @Autowired
    private CommonDAO commonDAO;	
	
    @Autowired
    private CommonSelectDAO commonSelectDAO;	

	@Autowired
	private DataSourceTransactionManager transactionManager;	

	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectTravelCal(Map<String, Object> paramMap){
		return travelCalDAO.selectTravelCal(paramMap);
	}

	public List<Map<String, Object>> selectTravelCalDetail(Map<String, Object> paramMap){
		return travelCalDAO.selectTravelCalDetail(paramMap);
	}
	
	public List<Map<String, Object>> createPdf(Map<String, Object> paramMap){
		return travelCalDAO.createPdf(paramMap);
	}	
	
	public Map<String, Object> selectSendTravelCal(Map<String, Object> paramMap) throws ServiceException, Exception {
		paramMap.put("COMP_CD" , getCompCd());
		paramMap.put("CRE_USER" , getUserId());
		paramMap.put("ORG_CD" , getDeptCd());

		List<Map<String,Object>> firstList     = travelCalDAO.selectSendTravelCalFirst(paramMap);
		
		List<Map<String,Object>> orgGroupList  = travelCalDAO.selectSendTravelCalList(paramMap);
		List<Map<String, Object>> sendList1    = new ArrayList<Map<String, Object>>(); 
		List<Map<String, Object>> sendList2    = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sendList3    = new ArrayList<Map<String, Object>>();
		
		
    	String DOC_NO  = "";
    	Map<String, Object> docNo = new HashMap<>();
    	docNo.put("DOC_GUBN", "P");
    	
		Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(docNo);
    	DOC_NO = docNoInfo.get("DOC_NO").toString();

		Map<String, Object> firstMap = firstList.get(0);
		firstMap.put("LEGACYNO", DOC_NO);
		sendList1.add(firstMap);
		
        for (Map<String, Object> data: orgGroupList) {
        	
        	data.put("LEGACYNO", DOC_NO);
        	data.put("CRE_USER" , getUserId());
        	
        	paramMap.put("ORG_CD", data.get("ORG_CD"));

    		List<Map<String,Object>> dataList2  = travelCalDAO.selectSendTravelCalIndiv(paramMap);
        	
            for (Map<String, Object> data2: dataList2) {
            	data2.put("LEGACYNO", DOC_NO);
            	data2.put("ORG_CD", data.get("ORG_CD"));
            	sendList2.add(data2);
            }

    		
    		List<Map<String,Object>> dataList3  = travelCalDAO.selectSendTravelCalDept(paramMap);
            
            for (Map<String, Object> data3: dataList3) {
            	data3.put("LEGACYNO", DOC_NO);
            	data3.put("ORG_CD", data.get("ORG_CD"));
            	sendList3.add(data3);
            }
        	
        	
        }
		
		
		
		Map<String,Object> returnParam = new HashMap<>();
		returnParam.put("LEGACYNO", DOC_NO);
		returnParam.put("IFFI017_01", sendList1);
		returnParam.put("IFFI017_02", sendList2);
		returnParam.put("IFFI017_03", sendList3);
		
		
        paramMap.put("SUCC_YN", "Y");
		
		return returnParam;
	}
	
	public Map<String, Object> selectSendCancelTravelCal(Map<String, Object> paramMap) throws ServiceException, Exception {
		
		paramMap.put("COMP_CD" , getCompCd());
		paramMap.put("CRE_USER" , getUserId());
		paramMap.put("ORG_CD" , getDeptCd());

		List<Map<String,Object>> firstList     = travelCalDAO.selectSendCancelTravelCalFirst(paramMap);
		
		List<Map<String,Object>> orgGroupList  = travelCalDAO.selectSendCancelTravelCal(paramMap);
		List<Map<String, Object>> sendList1    = new ArrayList<Map<String, Object>>(); 
		List<Map<String, Object>> sendList2    = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> sendList3    = new ArrayList<Map<String, Object>>();

		Map<String, Object> firstMap = firstList.get(0);
		sendList1.add(firstMap);
		
        for (Map<String, Object> data: orgGroupList) {
        	
        	data.put("CRE_USER" , getUserId());
        	
        	paramMap.put("ORG_CD", data.get("ORG_CD"));

    		List<Map<String,Object>> dataList2  = travelCalDAO.selectSendTravelCalIndiv(paramMap);
        	
            for (Map<String, Object> data2: dataList2) {
            	data2.put("ORG_CD", data.get("ORG_CD"));
            	sendList2.add(data2);
            }

    		
    		List<Map<String,Object>> dataList3  = travelCalDAO.selectSendTravelCalDept(paramMap);
            
            for (Map<String, Object> data3: dataList3) {
            	data3.put("ORG_CD", data.get("ORG_CD"));
            	sendList3.add(data3);
            }
        	
        	
        }
		
		
		Map<String,Object> returnParam = new HashMap<>();
		returnParam.put("IFFI017_01", sendList1);
		returnParam.put("IFFI017_02", sendList2);
		returnParam.put("IFFI017_03", sendList3);
		
		
        paramMap.put("SUCC_YN", "Y");
		
		return returnParam;
	}	

    public Map<String,Object> updateSendBusin(Map<String,Object> paramMap) throws ServiceException, Exception {
    	try {
    		travelCalDAO.updateSendBusin(paramMap);    		
    		paramMap.put("SUCC_YN", "Y");
    		
    	} catch (Exception e1) {
    		paramMap.put("SUCC_YN", "N");
    		paramMap.put("ERR_MSG", "SAP전송 후 상태변경에 실패했습니다."); 
    	}
    	
    	return paramMap;    	
    }
    
    public Map<String,Object> updateSendCancelBusin(Map<String,Object> paramMap) throws ServiceException, Exception {
    	try {
    		travelCalDAO.updateSendCancelBusin(paramMap);    		
    		paramMap.put("SUCC_YN", "Y");
    		
    	} catch (Exception e1) {
    		paramMap.put("SUCC_YN", "N");
    		paramMap.put("ERR_MSG", "SAP전송 후 상태변경에 실패했습니다."); 
    	}
    	
    	return paramMap;    	
    }
	
}