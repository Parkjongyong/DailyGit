package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatBugtResultDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;

@Service("batBugtResultInterfaceService")
public class BatBugtResultInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatBugtResultDAO batBugtResultDAO;
	
	public void makeBugtResultData(Map<String, Object> paramMap, List<Map<String, Object>> bugtResultList) throws ServiceException, Exception {
		
		// 데이터가 존재하는  경우만 CO_ORDER_MST 테이블에 반영!
        if (null != bugtResultList && 0 < bugtResultList.size()) {
            for (Map<String, Object> bugtResult: bugtResultList) {
            	
            	String CCTR_CD        = StringUtil.isNullToString(bugtResult.get("AKOSTL")).trim();
            	String BELONG_CCTR_CD = StringUtil.isNullToString(bugtResult.get("BKOSTL")).trim();
            	String SALE_NO        = StringUtil.isNullToString(bugtResult.get("BELNR")).trim();
            	String ACCOUNT_NO     = StringUtil.isNullToString(bugtResult.get("KSTAR")).trim();
            	String DEL            = StringUtil.isNullToString(bugtResult.get("DEL")).trim();
            	
//                System.out.println("CCTR_CD::[" + CCTR_CD + "]");
//                System.out.println("BELONG_CCTR_CD::[" + BELONG_CCTR_CD + "]");
//                System.out.println("SALE_NO::[" + SALE_NO + "]");
//                System.out.println("ACCOUNT_NO::[" + ACCOUNT_NO + "]");
//                System.out.println("DEL" + DEL + "]");
            	if ("X".equals(DEL)) {
            		bugtResult.put("MONAT", paramMap.get("MONAT").toString());
            		batBugtResultDAO.deleteBugtResultData(bugtResult);
            	} else {
                	if (   !"".equals(CCTR_CD)
                    		&& !"".equals(BELONG_CCTR_CD)	
                    		&& !"".equals(SALE_NO)
                    		&& !"".equals(ACCOUNT_NO)
                    		) {
                        	// 신규 데이터  insert or 기등록데이터  update 
                        	batBugtResultDAO.mergeBugtResultData(bugtResult);            		
                    	}            		
            	}
            }
        }
	}	
}
