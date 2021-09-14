package com.app.ildong.bat.controller;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.app.ildong.bat.service.BatItemService;
import com.app.ildong.bat.service.BatLogService;
import com.app.ildong.bat.service.BatMasterService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.SD.BGT_ERP.IFSD110_BGT_SOBindingStub;
import com.ildong.SD.BGT_ERP.IFSD110_BGT_SOServiceLocator;
import com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DT;
import com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DTITEM;
import com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DT_response;
import com.ildong.SD.BGT_ERP.IFSD110_BGT_S_DT_responseITEM;

@Controller
public class makeItemDataController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatItemService batItemService;	
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;		
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_ITEM_DATA"; // 품목정보
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makeItemDataJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
		String compCd		= "";
		String runIp		= "";
		
		boolean goBatchRun 	= true;
		boolean batchSucc	= true;
		String batchErrMsg	= "";
		
		Map<String,Object> batchInfo = new HashMap<>();
		Map<String,Object> paramInfo = new HashMap<>();
		
		try {
			compCd	= getCompCd();
			runIp	= getServerIp();
			
			paramInfo = batMasterService.selectIsBatchWorking(compCd, _BATCH_JOB_ID, runIp);
			
			// BATCH 사용 유무 확인하여 실행여부 결정
			if ("N".equals(paramInfo.get("BATCH_YN"))) {
				if (logger.isDebugEnabled()) {
					logger.debug("NOT FIND FOR THIS BATCH : [BATCH_ID:" + _BATCH_JOB_ID +"][RUN_IP:"+ runIp + "]");
				}
				goBatchRun = false;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			if (logger.isDebugEnabled()) {
				logger.debug("NOT FIND FOR THIS BATCH : [BATCH_ID:" + _BATCH_JOB_ID +"]");
			}
		}
		
		if (goBatchRun) {
			//배치 시작 정보 기록
			String startTime;
			try {
				startTime = commonSelectService.selectDbTime();
				batchInfo = batLogService.insertBatchLogOnStart(compCd, _BATCH_JOB_ID, runIp, startTime);
			} catch (Exception e) {
				e.printStackTrace();
				if (logger.isDebugEnabled()) {
					logger.debug("배치 시작정보 기록 실패");
				}
			}
			
			/************************** 배치 수행 서비스 로직 처리 시작 ***********************/
			
			Map<String,Object> batchResult = new HashMap<>();
			
			String ifFlag = "";
			String ifMgs  = "";
			
			try {
				
				// 1. SOAP 통신으로 공급업체  정보 추출 
				IFSD110_BGT_S_DTITEM dtItem = new IFSD110_BGT_S_DTITEM();
				IFSD110_BGT_S_DT dt = new IFSD110_BGT_S_DT();
				dtItem.setPRODH("");
				dtItem.setSTUFE("");
	        	
	            // 제품계층구조
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG5")))) {
	            	dtItem.setPRODH(paramInfo.get("BATCH_ARG5").toString());
	            	System.out.println("BATCH_ARG5 I::" + paramInfo.get("BATCH_ARG5").toString());
	            }
	            
	            // 레벨번호
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG6")))) {
	            	dtItem.setSTUFE(paramInfo.get("BATCH_ARG6").toString());
	            	System.out.println("BATCH_ARG6 I::" + paramInfo.get("BATCH_ARG6").toString());
	            }
	            
	            dt.setITEM(dtItem);
	            
	            // 테스트용
	            /*
	            dtHeader.setI_CPUDT_TO("20200813");
	            dtHeader.setI_CPUDT_FR("20200101");
	            dtHeader.setI_CPUTM_TO("235959");
	            dtHeader.setI_CPUTM_FR("000000");
	            paramMap.put("TRANSACTION_NO", "20200801235959");
	        	*/		        	
	        	
	            IFSD110_BGT_SOServiceLocator sl = new IFSD110_BGT_SOServiceLocator();
	            IFSD110_BGT_SOBindingStub bs = (IFSD110_BGT_SOBindingStub)sl.getHTTP_Port();
	            IFSD110_BGT_S_DT_response res = new IFSD110_BGT_S_DT_response();
	        	
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	bs.setUsername(sapId);
	           	bs.setPassword(sapPw); 
	           	
	           	res = bs.IFSD110_BGT_SO(dt);
	           	
	           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
	           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());	
	           	
	           	int itemLen = 0;
           		if (null != res.getITEM()) {
           			itemLen = res.getITEM().length;
           		}
           		
	           	// 성공시에만 수행하도록 ....
	           	if ("S".equals(ifFlag)) {
	           		
	           		IFSD110_BGT_S_DT_responseITEM[] itemDtRow = new IFSD110_BGT_S_DT_responseITEM[itemLen];
	           		List<Map<String, Object>> itemList = new ArrayList<Map<String, Object>>();
		           	
	           		System.out.println("ivItemLen::" + itemLen);
	           		if (itemLen > 0) {
	           			itemDtRow = res.getITEM();
			           	//발주정보 ITEM
			           	for (IFSD110_BGT_S_DT_responseITEM item : itemDtRow) {
			           		Map<String, Object> itemMap = new HashMap<String,Object>();
			                for (Field field : item.getClass().getDeclaredFields()) {
			                    field.setAccessible(true);
			                    itemMap.put(field.getName(), field.get(item));
			                }           		
			                itemList.add(itemMap);
			           	}
	           		}	           		
					
					// 2. 전송된 ITEM 정보를 테이블에 반영 
	           		batItemService.makeInterfaceItemData(itemList);
					
					batchSucc = true;
					batchResult.put("ERR_MSG", "");	           		
	           		
	           	} else if ("E".equals(ifFlag)) {
	           		batchSucc = false;
	           		batchResult.put("ERR_MSG", ifMgs);
	           		batchErrMsg = ifMgs;
	           	}
	           	
	       	} catch (RemoteException e) {
				batchSucc = false;
				batchErrMsg = e.toString();
	       	} catch (ServiceException se) {
				batchSucc = false;
				batchErrMsg = se.toString();
	    	} catch (Exception e) {
				batchSucc = false;
				batchErrMsg = e.toString();
	        }
				
			/************************** 배치 수행 서비스 로직 처리 끝	 ***********************/
			
			String endTime;
			try {
				endTime = commonSelectService.selectDbTime();
				
				if (batchSucc) {
					batLogService.updateBatchLogOnEnd(compCd, String.valueOf(batchInfo.get("BATCH_SEQ")), endTime, batchResult);
				} else { 
					batLogService.updateBatchLogOnEnd(compCd, String.valueOf(batchInfo.get("BATCH_SEQ")), endTime, "N", batchErrMsg, batchResult);
				}
				
				// 화면에서 입력 받은 값을  초기화!
				sysCmmLogMgmtService.updateParamBatchMaster(paramInfo);
			} catch (Exception e) {
				e.printStackTrace();
				if (logger.isDebugEnabled()) {
					logger.debug("배치 종료정보 기록 실패");
				}
			}
		}
	}
}
