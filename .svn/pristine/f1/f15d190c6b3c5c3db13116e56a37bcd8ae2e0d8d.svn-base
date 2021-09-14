package com.app.ildong.bdg.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.bdg.dao.BdgVacationMgmtDAO;

@Service("BdgVacationMgmtService")
public class BdgVacationMgmtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgVacationMgmtDAO vacationMgmtDAO;
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectVacationMgmt(Map<String, Object> paramMap){
		return vacationMgmtDAO.selectVacationMgmt(paramMap);
	}

	public List<Map<String, Object>> selectVacationDetail(Map<String, Object> paramMap){
		return vacationMgmtDAO.selectVacationDetail(paramMap);
	}
	
	public Map<String,Object> receptionTravel(Map<String, Object> paramMap) throws ServiceException, Exception {
		vacationMgmtDAO.deleteTravel(paramMap);
		List<Map<String, Object>> travelList = vacationMgmtDAO.receptionTravel(paramMap);
		for (Map<String, Object> data: travelList) {
			data.put("CRE_USER", getUserId());
			
			// ETC CHC 구분값 있는것만 INSERT
			Map<String, Object> chcEtcGubn = vacationMgmtDAO.chkChcEtcGubn(data);
			if(!"".equals(StringUtil.isNullToString(chcEtcGubn.get("ETC_CHC_GBN")))){
				data.put("ETC_CHC_GBN", chcEtcGubn.get("ETC_CHC_GBN"));
				vacationMgmtDAO.insertMisoTrip(data);	
			}
			
		}
		
		return paramMap;
	}
	
	public Map<String,Object> receptionVacation(Map<String, Object> paramMap) throws ServiceException, Exception {
		vacationMgmtDAO.deleteVacationH(paramMap);
		vacationMgmtDAO.deleteVacationD(paramMap);
		List<Map<String, Object>> vacationHList = vacationMgmtDAO.receptionVacationH(paramMap);
		List<Map<String, Object>> vacationDList = vacationMgmtDAO.receptionVacationD(paramMap);
		for (Map<String, Object> data: vacationHList) {
			data.put("MOD_USER", getUserId());
			data.put("CRE_USER", getUserId());
			Map<String, Object> chcEtcGubn = vacationMgmtDAO.chkChcEtcGubn(data);
			if(!"".equals(StringUtil.isNullToString(chcEtcGubn.get("ETC_CHC_GBN")))){
				data.put("ETC_CHC_GBN", chcEtcGubn.get("ETC_CHC_GBN"));
				vacationMgmtDAO.insertVacationH(data);	
			}
		}
		
		for (Map<String, Object> data: vacationDList) {
			data.put("MOD_USER", getUserId());
			data.put("CRE_USER", getUserId());
			Map<String, Object> chcEtcGubn = vacationMgmtDAO.chkChcEtcGubn(data);
			if(!"".equals(StringUtil.isNullToString(chcEtcGubn.get("ETC_CHC_GBN")))){
				data.put("ETC_CHC_GBN", chcEtcGubn.get("ETC_CHC_GBN"));
				vacationMgmtDAO.insertVacationD(data);	
			}
			
		}
		
		return paramMap;
	}
	
	public Map<String,Object> confirmVacation(Map<String, Object> paramMap) throws ServiceException, Exception {
		paramMap.put("CRE_USER", getUserId());
		vacationMgmtDAO.deleteSendTrip(paramMap);
		vacationMgmtDAO.confirmVacation(paramMap);
		return paramMap;
	}
	
}