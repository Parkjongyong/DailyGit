package com.app.ildong.bat.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bat.dao.BatInvoiceDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;

@Service("BatInvoiceService")
public class BatInvoiceService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatInvoiceDAO batInvoiceDAO;
	
	public void makeInterfaceInvoiceData(List<Map<String, Object>> invoiceHeadList, List<Map<String, Object>> invoiceItemList) throws ServiceException, Exception {
		
		int cnt1 = 0;
		int cnt2 = 0;
		// 데이터가 존재하는  경우만 IV_HEAD 테이블에 반영!
        if (null != invoiceHeadList && 0 < invoiceHeadList.size()) {
            for (Map<String, Object> invoiceHead: invoiceHeadList) {
            	batInvoiceDAO.mergeInvoiceHeadInfo(invoiceHead);
            	cnt1++;
            }
            System.out.println("invoiceHeadList cnt::" + cnt1);
        }
        
        // 데이터가 존재하는  경우만 IV_ITEM 테이블에 반영!
        if (null != invoiceItemList && 0 < invoiceItemList.size()) {
        	for (Map<String, Object> invoiceItem: invoiceItemList) {
        		/*
        		System.out.println("invoiceItem BELNR::" + invoiceItem.get("BELNR"));
        		System.out.println("invoiceItem GJAHR::" + invoiceItem.get("GJAHR"));
        		System.out.println("invoiceItem BUZEI::" + invoiceItem.get("BUZEI"));
        		System.out.println("invoiceItem MATNR::" + invoiceItem.get("MATNR"));
        		System.out.println("invoiceItem TXZ01::" + invoiceItem.get("TXZ01"));
        		System.out.println("invoiceItem MENGE::" + invoiceItem.get("MENGE"));
        		System.out.println("invoiceItem BSTME::" + invoiceItem.get("BSTME"));
        		System.out.println("invoiceItem WAERS::" + invoiceItem.get("WAERS"));
        		System.out.println("invoiceItem WRBTR::" + invoiceItem.get("WRBTR"));
        		System.out.println("invoiceItem SHKZG::" + invoiceItem.get("SHKZG"));
        		System.out.println("invoiceItem EBELN::" + invoiceItem.get("EBELN"));
        		System.out.println("invoiceItem EBELP::" + invoiceItem.get("EBELP"));
        		System.out.println("invoiceItem LFBNR::" + invoiceItem.get("LFBNR"));
        		System.out.println("invoiceItem LFPOS::" + invoiceItem.get("LFPOS"));
        		System.out.println("invoiceItem LFGJA::" + invoiceItem.get("LFGJA"));
        		System.out.println("invoiceItem BUDAT::" + invoiceItem.get("BUDAT"));
        		*/
            	batInvoiceDAO.mergeInvoiceItemInfo(invoiceItem);
            	cnt2++;
        	}
        	System.out.println("invoiceItemList cnt::" + cnt2);
        }
	}	
}
