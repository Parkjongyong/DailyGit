package com.app.ildong.bat.controller;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import com.app.ildong.bat.service.BatLogService;
import com.app.ildong.bat.service.BatMasterService;
import com.app.ildong.bat.service.BatPurchOrderInterfaceService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.MM.BGT_ERP.IFMM035_BGT_SOBindingStub;
import com.ildong.MM.BGT_ERP.IFMM035_BGT_SOServiceLocator;
import com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT;
import com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_response;
import com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD;
import com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_HEAD_REMARK;
import com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM;
import com.ildong.MM.BGT_ERP.IFMM035_BGT_S_DT_responsePO_ITEM_REMARK;

@Controller
public class makePurchOrderInterfaceController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatPurchOrderInterfaceService batPurchOrderInterfaceService;	
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;	
	
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_PURCH_ORDER_IF"; // 발주정보 I/F
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makePurchOrderInterfaceJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
			
			/**
			 * 대시보드 리포팅 처리
			 */
			Map<String,Object> batchResult = new HashMap<>();
			Map<String,Object> paramMap = new HashMap<>();
			
			String ifFlag = "";
			String ifMgs  = "";
			
			try {
				
				// 1. SOAP 통신으로 공급업체  정보 추출 
				IFMM035_BGT_S_DT request = new IFMM035_BGT_S_DT();
	        	
	            Calendar cal = Calendar.getInstance();
	            cal.setTime(new Date());
	            DateFormat uDate = new SimpleDateFormat("yyyyMMdd");
	            DateFormat uTime = new SimpleDateFormat("HHmm00");
	            
	            paramMap.put("TRANSACTION_NO", uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG2")))) {
	            	request.setI_UDATE_TO(paramInfo.get("BATCH_ARG2").toString());
	            	System.out.println("BATCH_ARG2 I::" + paramInfo.get("BATCH_ARG2").toString());
	            } else {
	            	request.setI_UDATE_TO(uDate.format(cal.getTime()));
	            	System.out.println("BATCH_ARG2 C::" + uDate.format(cal.getTime()));
	            }
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG4")))) {
	            	request.setI_UTIME_TO(paramInfo.get("BATCH_ARG4").toString());
	            	System.out.println("BATCH_ARG4 I::" + paramInfo.get("BATCH_ARG4").toString());
	            } else {
	            	request.setI_UTIME_TO(uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            	System.out.println("BATCH_ARG4 C::" + uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            }	            
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG1")))) {
	            	request.setI_UDATE_FR(paramInfo.get("BATCH_ARG1").toString());
	            	System.out.println("BATCH_ARG1 I::" + paramInfo.get("BATCH_ARG1").toString());
	            } else {
	            	System.out.println("BATCH_ARG1 C::" + uDate.format(cal.getTime()));
	            	request.setI_UDATE_FR(uDate.format(cal.getTime()));
	            }
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG3")))) {
	            	request.setI_UTIME_FR(paramInfo.get("BATCH_ARG3").toString());
	            	System.out.println("BATCH_ARG3 I::" + paramInfo.get("BATCH_ARG3").toString());
	            } else {
	            	//cal.add(Calendar.MINUTE,-30);
	            	//System.out.println("BATCH_ARG3 C::" + uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            	System.out.println("BATCH_ARG3 C::000000");
	            	//request.setI_UTIME_FR(uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            	request.setI_UTIME_FR("000000");
	            }
	            
	            // 공급업체
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG5")))) {
	            	request.setI_LIFNR(paramInfo.get("BATCH_ARG5").toString());
	            	System.out.println("BATCH_ARG5 I::" + paramInfo.get("BATCH_ARG5").toString());
	            }
	            
	            // 구매그룹
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG6")))) {
	            	request.setI_EKGRP(paramInfo.get("BATCH_ARG6").toString());
	            	System.out.println("BATCH_ARG6 I::" + paramInfo.get("BATCH_ARG6").toString());
	            }
	            
	            // 구매문서번호
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG7")))) {
	            	request.setI_EBELN(paramInfo.get("BATCH_ARG7").toString());
	            	System.out.println("BATCH_ARG7 I::" + paramInfo.get("BATCH_ARG7").toString());
	            }
	            
	            // 자재번호
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG8")))) {
	            	request.setI_MATNR(paramInfo.get("BATCH_ARG8").toString());
	            	System.out.println("BATCH_ARG8 I::" + paramInfo.get("BATCH_ARG8").toString());
	            }
	            
	            
	            // 테스트용
	            /*
	            request.setI_UDATE_TO("20200813");
	            request.setI_UDATE_FR("20200101");
	            request.setI_UTIME_TO("235959");
	            request.setI_UTIME_FR("000000");
	            paramMap.put("TRANSACTION_NO", "20200801235959");
	        	*/
	        	IFMM035_BGT_SOServiceLocator sl = new IFMM035_BGT_SOServiceLocator();
	        	IFMM035_BGT_SOBindingStub bs = (IFMM035_BGT_SOBindingStub)sl.getHTTP_Port();
	        	IFMM035_BGT_S_DT_response res = new IFMM035_BGT_S_DT_response();
	        	
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	bs.setUsername(sapId);
	           	bs.setPassword(sapPw);
	           	
	           	res = bs.IFMM035_BGT_SO(request);
	           	
	           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
	           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
	           	
	           	int poHeadLen = 0;
	           	int poHeadRemkLen = 0;
	           	int poItemLen = 0;	           	
	           	int poItemRemkLen = 0;
           		if (null != res.getPO_HEAD()) {
           			poHeadLen = res.getPO_HEAD().length;
           		}
           		
           		if (null != res.getPO_HEAD_REMARK()) {
           			poHeadRemkLen = res.getPO_HEAD_REMARK().length;
           		}
           		
           		if (null != res.getPO_ITEM()) {
           			poItemLen = res.getPO_ITEM().length;
           		} 
           		
           		if (null != res.getPO_ITEM_REMARK()) {
           			poItemRemkLen = res.getPO_ITEM_REMARK().length;
           		}            		
	           	
	           	// 성공시에만 수행하도록 ....
	           	if ("S".equals(ifFlag)) {
	           		
	           		IFMM035_BGT_S_DT_responsePO_HEAD[] poHeadRow            = new IFMM035_BGT_S_DT_responsePO_HEAD[poHeadLen];
	           		IFMM035_BGT_S_DT_responsePO_HEAD_REMARK[] poHeadRemkRow = new IFMM035_BGT_S_DT_responsePO_HEAD_REMARK[poHeadRemkLen];
	           		IFMM035_BGT_S_DT_responsePO_ITEM[] poItemRow            = new IFMM035_BGT_S_DT_responsePO_ITEM[poItemLen];
	           		IFMM035_BGT_S_DT_responsePO_ITEM_REMARK[] poItemRemkRow = new IFMM035_BGT_S_DT_responsePO_ITEM_REMARK[poItemRemkLen];
		           	List<Map<String, Object>> poHeadList     = new ArrayList<Map<String, Object>>();
		           	List<Map<String, Object>> poHeadRemkList = new ArrayList<Map<String, Object>>();
		           	List<Map<String, Object>> poItemList     = new ArrayList<Map<String, Object>>();
		           	List<Map<String, Object>> poItemRemkList = new ArrayList<Map<String, Object>>();
		           	
	           		if (poHeadLen > 0) {
	           			poHeadRow = res.getPO_HEAD();
			           	//발주정보 HEADER
			           	for (IFMM035_BGT_S_DT_responsePO_HEAD poHead : poHeadRow) {
			           		Map<String, Object> poHeadMap = new HashMap<String,Object>();
			                for (Field field : poHead.getClass().getDeclaredFields()) {
			                    field.setAccessible(true);
			                    poHeadMap.put(field.getName(), field.get(poHead));
			                }           		
			                poHeadList.add(poHeadMap);
			           	}
	           		}
	           		
	           		if (poHeadRemkLen > 0) {
	           			poHeadRemkRow = res.getPO_HEAD_REMARK();
			           	//발주정보 HEADER REMARK
			           	for (IFMM035_BGT_S_DT_responsePO_HEAD_REMARK poHeadRemk : poHeadRemkRow) {
			           		Map<String, Object> poHeadRemkMap = new HashMap<String,Object>();
			                for (Field field : poHeadRemk.getClass().getDeclaredFields()) {
			                    field.setAccessible(true);
			                    poHeadRemkMap.put(field.getName(), field.get(poHeadRemk));
			                }           		
			                poHeadRemkList.add(poHeadRemkMap);
			           	}
	           		}
	           		
	           		if (poItemLen > 0) {
	           			poItemRow = res.getPO_ITEM();
			           	//발주정보 ITEM
			           	for (IFMM035_BGT_S_DT_responsePO_ITEM poItem : poItemRow) {
			           		Map<String, Object> poItemMap = new HashMap<String,Object>();
			                for (Field field : poItem.getClass().getDeclaredFields()) {
			                    field.setAccessible(true);
			                    poItemMap.put(field.getName(), field.get(poItem));
			                }           		
			                poItemList.add(poItemMap);
			           	} 
	           		}
	           		
	           		if (poItemRemkLen > 0) {
	           			poItemRemkRow = res.getPO_ITEM_REMARK();
			           	//발주정보 ITEM REAMRK
			           	for (IFMM035_BGT_S_DT_responsePO_ITEM_REMARK poItemRemk : poItemRemkRow) {
			           		Map<String, Object> poItemRemkMap = new HashMap<String,Object>();
			                for (Field field : poItemRemk.getClass().getDeclaredFields()) {
			                    field.setAccessible(true);
			                    poItemRemkMap.put(field.getName(), field.get(poItemRemk));
			                }           		
			                poItemRemkList.add(poItemRemkMap);
			           	} 
	           		}	           		
					
					// 2. 전송된 공급업체  정보를 I/F 테이블에 반영 
	           		batPurchOrderInterfaceService.makeInterfacePurchOrderData(poHeadList, poHeadRemkList, poItemList, poItemRemkList, paramMap);
					
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
