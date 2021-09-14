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
import com.app.ildong.wrh.dao.WrhVendorScheduledDAO;
import com.app.ildong.wrh.dao.WrhStockDueDateRegistDAO;

@Service("WrhVendorScheduledService")
public class WrhVendorScheduledService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private WrhVendorScheduledDAO vendorScheduledDAO;
	
	@Autowired
	private WrhStockDueDateRegistDAO wrhStockDueDateRegistDAO;	
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVendorScheduled(Map<String, Object> paramMap){
		return vendorScheduledDAO.selectVendorScheduled(paramMap);
	}

}