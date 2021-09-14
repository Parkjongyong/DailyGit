package com.app.ildong.bat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatPurchOrderDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("batPurchOrderInterfaceService")
public class BatPurchOrderInterfaceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatPurchOrderDAO batPurchOrderDAO;
	
	public void makeInterfacePurchOrderData(List<Map<String, Object>> poHeadList
			                              , List<Map<String, Object>> poHeadRemkList
			                              , List<Map<String, Object>> poItemList
			                              , List<Map<String, Object>> poItemRemkList
			                              , Map<String, Object> paramMap) throws ServiceException, Exception {
		int cnt1 = 0;
		int cnt2 = 0;
		int cnt3 = 0;
		int cnt4 = 0;
		// 데이터가 존재하는  경우만  PO_HEAD_IF 테이블에 반영!
        if (null != poHeadList && 0 < poHeadList.size()) {
            for (Map<String, Object> poHead: poHeadList) {
            	cnt1++;
            	// IF KEY를 TO_DATE로 셋팅
            	poHead.put("TRANSACTION_NO", paramMap.get("TRANSACTION_NO"));
            	// PO_HEAD_IF 생성
            	batPurchOrderDAO.mergePOHederIfData(poHead);
            }
        }
        
		// 데이터가 존재하는  경우만 PO_HEAD_REMARK_IF 테이블에 반영!
        if (null != poHeadRemkList && 0 < poHeadRemkList.size()) {
            for (Map<String, Object> poHeadRemk: poHeadRemkList) {
            	cnt2++;
            	// IF KEY를 TO_DATE로 셋팅
            	poHeadRemk.put("TRANSACTION_NO", paramMap.get("TRANSACTION_NO"));
            	// PO_HEAD_REMARK_IF 생성
            	batPurchOrderDAO.mergePOHederRemkIfData(poHeadRemk);
            }
        }

		
		// 데이터가 존재하는  경우만 PO_ITEM_IF 테이블에 반영!
        if (null != poItemList && 0 < poItemList.size()) {
            for (Map<String, Object> poItem: poItemList) {
            	cnt3++;
            	// IF KEY를 TO_DATE로 셋팅
            	poItem.put("TRANSACTION_NO", paramMap.get("TRANSACTION_NO")); 
            	// PO_ITEM_IF 생성
            	batPurchOrderDAO.mergePOItemIfData(poItem);
            }
        }
    	
    	// 데이터가 존재하는  경우만 PO_ITEM_REMARK IF 테이블에 반영!
        if (null != poItemList && 0 < poItemList.size()) {
            for (Map<String, Object> poItemRemk: poItemRemkList) {
            	cnt4++;
            	// IF KEY를 TO_DATE로 셋팅
            	poItemRemk.put("TRANSACTION_NO", paramMap.get("TRANSACTION_NO")); 
            	// PO_ITEM_REMARK 생성
            	batPurchOrderDAO.mergePOItemRemkIfData(poItemRemk);
            }
        }
        
        System.out.println("cnt1:::: "+ cnt1);
        System.out.println("cnt2:::: "+ cnt2);
        System.out.println("cnt3:::: "+ cnt3);
        System.out.println("cnt4:::: "+ cnt4);
	}
}
