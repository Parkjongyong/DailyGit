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

import com.app.ildong.bat.service.BatGRItemService;
import com.app.ildong.bat.service.BatLogService;
import com.app.ildong.bat.service.BatMasterService;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseJobBean;
import com.app.ildong.common.service.CommonSelectService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.service.SysCmmLogMgmtService;
import com.ildong.MM.BGT_ERP.IFMM033_BGT_S_DT_responseVEND_HEAD;
import com.ildong.MM.BGT_ERP.IFMM037_BGT_SOBindingStub;
import com.ildong.MM.BGT_ERP.IFMM037_BGT_SOServiceLocator;
import com.ildong.MM.BGT_ERP.IFMM037_BGT_S_DT;
import com.ildong.MM.BGT_ERP.IFMM037_BGT_S_DT_response;
import com.ildong.MM.BGT_ERP.IFMM037_BGT_S_DT_responseET_ITEM;
import com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_HEAD;
import com.ildong.MM.BGT_ERP.IFMM038_BGT_S_DT_responseIV_ITEM;

@Controller
public class makeGRItemDataController extends BaseJobBean {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BatMasterService batMasterService;
	
	@Autowired
	private BatLogService batLogService;
	
	@Autowired
	private BatGRItemService bBatGRItemService;	
	
    @Autowired
    private SysCmmLogMgmtService sysCmmLogMgmtService;
    
	@Autowired
	private CommonSelectService commonSelectService;
	
	private String _BATCH_JOB_ID	= "MAKE_GR_ITEM_DATA"; // 입고정보 I/F
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		try {
			String currTime = getTimeString(getCurrentTime());
			logger.debug("executeInternal 1 ( 5 second): currentTiem = " + currTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void makeGRItemDataJobRun(LinkedHashMap<String, Object> serviceParams) throws Exception {
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
				IFMM037_BGT_S_DT request = new IFMM037_BGT_S_DT();
				
	            Calendar cal = Calendar.getInstance();
	            cal.setTime(new Date());
	            DateFormat uDate = new SimpleDateFormat("yyyyMMdd");
	            DateFormat uTime = new SimpleDateFormat("HHmm00");	        	
	        	
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG2")))) {
	            	request.setI_CPUDT_TO(paramInfo.get("BATCH_ARG2").toString());
	            } else {
	            	request.setI_CPUDT_TO(uDate.format(cal.getTime()));
	            }
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG4")))) {
	            	request.setI_CPUTM_TO(paramInfo.get("BATCH_ARG4").toString());
	            } else {
	            	request.setI_CPUTM_TO(uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            }	            
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG1")))) {
	            	request.setI_CPUDT_FR(paramInfo.get("BATCH_ARG1").toString());
	            } else {
	            	//cal.add(Calendar.DATE,-60);
	            	request.setI_CPUDT_FR(uDate.format(cal.getTime()));
	            }
	            
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG3")))) {
	            	request.setI_CPUTM_FR(paramInfo.get("BATCH_ARG3").toString());
	            } else {
	            	//cal.add(Calendar.MINUTE,-30);
	            	//request.setI_CPUTM_FR(uDate.format(cal.getTime()) + uTime.format(cal.getTime()));
	            	request.setI_CPUTM_FR("000000");
	            }
	            
	            // 구매 오더 번호
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG5")))) {
	            	request.setI_EBELN(paramInfo.get("BATCH_ARG5").toString());
	            	System.out.println("BATCH_ARG5 I::" + paramInfo.get("BATCH_ARG5").toString());
	            }
	            
	            // 공급 업체
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG6")))) {
	            	request.setI_LIFNR(paramInfo.get("BATCH_ARG6").toString());
	            	System.out.println("BATCH_ARG6 I::" + paramInfo.get("BATCH_ARG6").toString());
	            }
	            
	            // 자재번호
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG7")))) {
	            	request.setI_MATNR(paramInfo.get("BATCH_ARG7").toString());
	            	System.out.println("BATCH_ARG7 I::" + paramInfo.get("BATCH_ARG7").toString());
	            }
	            
	            // 자재문서번호
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG8")))) {
	            	request.setI_MBLNR(paramInfo.get("BATCH_ARG8").toString());
	            	System.out.println("BATCH_ARG8 I::" + paramInfo.get("BATCH_ARG8").toString());
	            }
	            
	            // 자재전표연도
	            if (!"".equals(StringUtil.isNullToString(paramInfo.get("BATCH_ARG9")))) {
	            	request.setI_MJAHR(paramInfo.get("BATCH_ARG9").toString());
	            	System.out.println("BATCH_ARG9 I::" + paramInfo.get("BATCH_ARG9").toString());
	            }	            
	            
	            // 테스트용
	            /*
	            dtHeader.setI_CPUDT_TO("20200801");
	            dtHeader.setI_CPUDT_FR("20200101");
	            dtHeader.setI_CPUTM_TO("235959");
	            dtHeader.setI_CPUTM_FR("000000");
	            paramMap.put("TRANSACTION_NO", "20200801235959");
	        	*/				
	        	
	        	IFMM037_BGT_SOServiceLocator sl = new IFMM037_BGT_SOServiceLocator();
	        	IFMM037_BGT_SOBindingStub bs    = (IFMM037_BGT_SOBindingStub)sl.getHTTP_Port();
	        	IFMM037_BGT_S_DT_response res   = new IFMM037_BGT_S_DT_response();
	        	
	        	// USER ID/PW 셋팅
	        	// USER ID/PW 셋팅
	           	String sapId= PropertiesUtil.getProperty("sap.id");
	           	String sapPw= PropertiesUtil.getProperty("sap.pw");
	           	bs.setUsername(sapId);
	           	bs.setPassword(sapPw); 
	           	
	           	res = bs.IFMM037_BGT_SO(request);
	           	
	           	ifFlag = StringUtil.isNullToString(res.getIF_FLAG());
	           	ifMgs  = StringUtil.isNullToString(res.getIF_MSG());
	           	
	           	int etItemLen = 0;
           		if (null != res.getET_ITEM()) {
           			etItemLen = res.getET_ITEM().length;
           		}
           		
	           	// 성공시에만 수행하도록 ....
	           	if ("S".equals(ifFlag)) {
	           		
	           		IFMM037_BGT_S_DT_responseET_ITEM[] grItemRow = new IFMM037_BGT_S_DT_responseET_ITEM[etItemLen];
		           	List<Map<String, Object>> grItemList     = new ArrayList<Map<String, Object>>();
		           	
	           		if (etItemLen > 0) {
	           			grItemRow = res.getET_ITEM();
			           	//입고 정보
			           	for (IFMM037_BGT_S_DT_responseET_ITEM grItem : grItemRow) {
			           		Map<String, Object> grItemdMap = new HashMap<String,Object>();
			                for (Field field : grItem.getClass().getDeclaredFields()) {
			                    field.setAccessible(true);
			                    grItemdMap.put(field.getName(), field.get(grItem));
			                }           		
			                grItemList.add(grItemdMap);
			           	}
	           		}		           	
					
					// 2. 전송된 공급업체  정보를 I/F 테이블에 반영 
		           	bBatGRItemService.makeInterfaceGRItemData(grItemList);
		           	
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
