package com.app.ildong.sys.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.sap.JCoExecuteService;
import com.app.ildong.sys.dao.JCoLogDAO;

import net.minidev.json.JSONObject;

@Service("JCoProcessService")
@Transactional(propagation = Propagation.REQUIRES_NEW, noRollbackFor=Exception.class)
public class JCoProcessService extends BaseService {
	
	private static final Logger logger = LoggerFactory.getLogger(JCoProcessService.class);
	
	@Autowired
	private JCoLogDAO jCoLogDAO;
	
	public Map<String,Object> processJCoExecute(Map<String,Object> paramMap) {
		return processJCoExecute(paramMap, true);
	}
	
	/**
	 * 
	 * @param paramMap 입력파라미터 MAP
	 * FUNC_NAME - RFC 함수명 필수
	 * RETURN_NAME - RFC 결과(테이블) 이름, RETURN / E_RETURN / ET_RETURN 이 아닐 경우
	 * REF_DATA1 - RFC 리턴로그에 남길 참조값1 (옵션)
	 * REF_DATA2 - RFC 리턴로그에 남길 참조값2 (옵션)
	 * REF_DATA3 - RFC 리턴로그에 남길 참조값3 (옵션)
	 * RTN_CD_FIELD_NM - 리턴결과코드 필드명
	 * RTN_MSG_FIELD_NM - 리턴결과메세지 필드명
	 * 
	 * @return 결과Map : RFC별 리턴데이타 외에 아래의 정의된 필드값 리턴
	 * JCO_SEQ         - JCO 로그일련번호
	 * JCO_RESULT_CD   - 성공:S, 오류:E (RFC RETURN TABLE에서 하나라도 E,A가 있으면 E)
	 * JCO_RESULT_MSG  - 결과메세지(복수 메세지일 경우 첫번째 메세지)
	 * JCO_RESULT_MSG_ALL - 전체 결과 메세지(\n으로 개행)
	 * JCO_RESULT_MSG_ERR - 전체 에러 메세지(\n으로 개행)
	 */
	@SuppressWarnings("unchecked")
	public Map<String,Object> processJCoExecute(Map<String,Object> paramMap, boolean isLogging) {
		logger.debug("start processJCoExecute......................");
		Map<String,Object> responseData = new HashMap<>();
		
		String funcName 	= (String)paramMap.get("FUNC_NAME");
		logger.debug("FUNCTION NAME: " + funcName);
		String jcoLogSeq	= "";
		
		/*===================================================================*/
		/* JCO Log insert */
		/*===================================================================*/
		if (isLogging) {
			try {
				JSONObject jsonObject1	= new JSONObject(paramMap);
				
				responseData.put("COMP_CD"		, PropertiesUtil.getProperty("COMP_CD"));
				responseData.put("FUNCTION_NAME", funcName);
				responseData.put("JCO_PARAMS"	, jsonObject1.toString());
				
				jCoLogDAO.insertJCoLog(responseData);
				
				jcoLogSeq = String.valueOf(responseData.get("JCO_SEQ"));
				paramMap.put("I_IFKEY", jcoLogSeq); //JCO 일련번호를 RFC 입력파라미터로 설정
				
			} catch (Exception e) {
				logger.error("RFC log insert 오류", e);
			}
		}
		
		/*===================================================================*/
		/* RFC 호출 및 결과기록 */
		/*===================================================================*/
		Map<String,Object> resultMap = null;
		boolean isSuc = true;
		String rtnMsg = "";
		String rtnMsgAll = "";
		String rtnMsgErr = "";
		
		try {
			resultMap = JCoExecuteService.processJCoExecute(paramMap);
			
			if ("F".equals(MapUtils.getString(resultMap, "RESULT"))) {
				throw new Exception(MapUtils.getString(resultMap, "RESULT_MSG"));
			}
			
			//RETURN 결과 insert
			Object returnObj = null;
			if (StringUtils.isNotEmpty(MapUtils.getString(paramMap, "RETURN_NAME"))) {
				returnObj = resultMap.get(MapUtils.getString(paramMap, "RETURN_NAME")); 
			}
			if (returnObj == null) {
				returnObj = resultMap.get("RETURN");
			}
			if (returnObj == null) {
				returnObj = resultMap.get("E_RETURN");
			}
			if (returnObj == null) {
				returnObj = resultMap.get("ET_RETURN");
			}
			
			if (returnObj != null) {
				List<Map<String, Object>> returnList = null;
				if (returnObj instanceof Map) {
					returnList = new ArrayList<Map<String, Object>>();
					returnList.add((Map<String, Object>)returnObj);
				}else {
					returnList = (List<Map<String, Object>>)returnObj;
				}
				
				if (returnList != null) {
					for(Map<String, Object> rtn : returnList) {
						rtn.put("JCO_SEQ",  jcoLogSeq);
						rtn.put("RFC_NAME", funcName);
						rtn.put("REF_DATA1", MapUtils.getString(paramMap, "REF_DATA1"));
						rtn.put("REF_DATA2", MapUtils.getString(paramMap, "REF_DATA2"));
						rtn.put("REF_DATA3", MapUtils.getString(paramMap, "REF_DATA3"));
						
						//전체 리턴메세지
						rtnMsgAll += "* " + MapUtils.getString(rtn, "MESSAGE") + "\n"; 
						
						//에러 리턴메세지
						if ( "E".equals(MapUtils.getString(rtn, "TYPE")) || "A".equals(MapUtils.getString(rtn, "TYPE")) ) {
							rtnMsgErr += "* " + MapUtils.getString(rtn, "MESSAGE") + "\n";
						}
						
						// 로깅옵션이고 오류리턴 로그만 기록
						if (isLogging && ("E".equals(MapUtils.getString(rtn, "TYPE")) || "A".equals(MapUtils.getString(rtn, "TYPE")) ) ) {
							jCoLogDAO.insertJcoRetunLog(rtn);
						}
						//결과코드 및 메세지 체크
						if (StringUtils.isEmpty(rtnMsg)) {
							rtnMsg =  MapUtils.getString(rtn, "MESSAGE");
						}
						if (isSuc) {
							//오류나 중단이 있으면 실패
							if ("E".equals(MapUtils.getString(rtn, "TYPE")) || "A".equals(MapUtils.getString(rtn, "TYPE"))) {
								isSuc = false;
								rtnMsg = MapUtils.getString(rtn, "MESSAGE");
							}
						}
					}
				}
			}
			
			//별도의 결과 필드가 있을 경우
			if (StringUtils.isNotEmpty(MapUtils.getString(paramMap, "RTN_CD_FIELD_NM"))) {
				String rtnCdField = MapUtils.getString(paramMap, "RTN_CD_FIELD_NM","");
				String resultCd = MapUtils.getString(resultMap, rtnCdField);
				String resultMsg =MapUtils.getString(resultMap, MapUtils.getString(paramMap, "RTN_MSG_FIELD_NM","")); 
				if ("E".equals(resultCd) || "F".equals(resultCd)) {
					isSuc = false;
					rtnMsg = resultMsg;
					rtnMsgAll = resultMsg;
					rtnMsgErr = resultMsg;
					if (!isSuc && isLogging) {
						Map<String, Object> rtn = new HashMap<String, Object>();
						rtn.put("JCO_SEQ",  jcoLogSeq);
						rtn.put("RFC_NAME", funcName);
						rtn.put("REF_DATA1", MapUtils.getString(paramMap, "REF_DATA1"));
						rtn.put("REF_DATA2", MapUtils.getString(paramMap, "REF_DATA2"));
						rtn.put("REF_DATA3", MapUtils.getString(paramMap, "REF_DATA3"));
						rtn.put("TYPE",     "E");
						rtn.put("MESSAGE",   resultMsg);
						jCoLogDAO.insertJcoRetunLog(rtn);
					}
				}
			}
			
		} catch (Exception e) {
			logger.error("RFC 호출 오류", e);
			isSuc = false;
			rtnMsg = e.getMessage();
			
			// 로깅옵션이면
			if (isLogging) {
				Map<String, Object> rtn = new HashMap<String, Object>();
				rtn.put("JCO_SEQ",  jcoLogSeq);
				rtn.put("RFC_NAME", funcName);
				rtn.put("REF_DATA1", MapUtils.getString(paramMap, "REF_DATA1"));
				rtn.put("REF_DATA2", MapUtils.getString(paramMap, "REF_DATA2"));
				rtn.put("REF_DATA3", MapUtils.getString(paramMap, "REF_DATA3"));
				rtn.put("TYPE",    "E");
				rtn.put("MESSAGE", StringUtils.substring(rtnMsg, 0, 255));
				
				jCoLogDAO.insertJcoRetunLog(rtn);
			}
				
			resultMap.put("JCO_RESULT_CD",  isSuc?"S":"E");
			resultMap.put("JCO_RESULT_MSG", rtnMsg);
			resultMap.put("JCO_RESULT_MSG_ALL", rtnMsg);
			resultMap.put("JCO_RESULT_MSG_ERR", rtnMsgErr);
			
			return resultMap;
		}
		
		/*===================================================================*/
		/*JCO Log update */
		/*===================================================================*/
		if (isLogging) {
			try {
				JSONObject jsonObject2	= new JSONObject(resultMap);
				
				responseData.put("JCO_SEQ",  jcoLogSeq);
				responseData.put("COMP_CD",  PropertiesUtil.getProperty("COMP_CD"));
				responseData.put("JCO_DATA", jsonObject2.toString());
				responseData.put("RESULT",     isSuc?"S":"E");
				responseData.put("RESULT_MSG", rtnMsg);
				
				jCoLogDAO.updateJCoLog(responseData);
				
			} catch (Exception e) {
				logger.error("RFC log update 오류", e);
			}
		}
		
		resultMap.put("JCO_RESULT_CD",  isSuc?"S":"E");
		resultMap.put("JCO_RESULT_MSG", rtnMsg);
		resultMap.put("JCO_RESULT_MSG_ALL", rtnMsgAll);
		resultMap.put("JCO_RESULT_MSG_ERR", rtnMsgErr);
		
		logger.debug("end processJCoExecute......................");
		return resultMap;
	}
	
	/**
	 * jco return log 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectJcoReturnLogList(Map<String,Object> paramMap) throws Exception{
		return jCoLogDAO.selectJcoReturnLogList(paramMap);
	}
}
