package com.app.ildong.bdg.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.bdg.dao.BdgTangAssetMgtDAO;
import com.app.ildong.common.dao.CommonDAO;
import com.app.ildong.common.dao.CommonSelectDAO;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.StringUtil;
@Service("bdgTangAssetMgtService")
public class BdgTangAssetMgtService extends BaseService{
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private BdgTangAssetMgtDAO bdgTangAssetMgtDAO;
	
    @Autowired
    private CommonDAO commonDAO;	
	
    @Autowired
    private CommonSelectDAO commonSelectDAO;		
	
	/**
	 * @param paramMap
	 * @return
	 */
	public List<Map<String, Object>> selectTangAssetMgtHeadList(Map<String, Object> paramMap){
		return bdgTangAssetMgtDAO.selectTangAssetMgtHeadList(paramMap);
	}
	
	public List<Map<String, Object>> selectTangAssetTotalList(Map<String, Object> paramMap){
		return bdgTangAssetMgtDAO.selectTangAssetTotalList(paramMap);
	}
	
	public List<Map<String, Object>> selectTangAssetDetailList(Map<String, Object> paramMap){
		return bdgTangAssetMgtDAO.selectTangAssetDetailList(paramMap);
	}
	
	public Map<String, Object> selectStatusHeader(Map<String, Object> paramMap) {
        return bdgTangAssetMgtDAO.selectStatusHeader(paramMap);
    }
	
	public List<Map<String, Object>> selectApprList(Map<String, Object> paramMap){
		return bdgTangAssetMgtDAO.selectApprList(paramMap);
	}	
	
    public Map<String,Object> saveTangAssetMgt(Map<String,Object> paramMap) throws ServiceException, Exception {
        
    	Map<String, Object> headMap   = (Map<String, Object>) paramMap.get("HEAD_LIST");
    	Map<String, Object> detailMap = (Map<String, Object>) paramMap.get("DETAIL_LIST");
    	
    	List<Map<String, Object>> headList   = (List<Map<String, Object>>) headMap.get("CHECK_LIST");
    	List<Map<String, Object>> detailList = (List<Map<String, Object>>) detailMap.get("ALLDATA");
        
        // head 정보 등록
        if (null != headList && 0 < headList.size()) {
            for (Map<String, Object> data: headList) {
            	
            	String investNo = StringUtil.isNullToString(data.get("INVEST_NO"));
            	// 투자번호가 없는 경우 채번
            	if ("XXXXXXX".equals(investNo)) {
            		Map<String, Object> retrunParam = bdgTangAssetMgtDAO.selectInvestNo(data);
            		System.out.println("INVEST_NO 채번::" + retrunParam.get("INVEST_NO").toString());
            		data.put("INVEST_NO"  , retrunParam.get("INVEST_NO").toString());
            		paramMap.put("INVEST_NO"  , retrunParam.get("INVEST_NO").toString());
            	}
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                
                
                bdgTangAssetMgtDAO.saveTangAssetMgtHead(data);
            }
        }
        
        // detail 정보 등록
        if (null != detailList && 0 < detailList.size()) {
            for (Map<String, Object> data: detailList) {
            	
            	String investNo = StringUtil.isNullToString(data.get("INVEST_NO"));
            	// 투자번호가 없는 경우 채번
            	if ("XXXXXXX".equals(investNo)) {
            		data.put("INVEST_NO"  , paramMap.get("INVEST_NO").toString());
            	}            	
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                bdgTangAssetMgtDAO.saveTangAssetMgtDetail(data);
                
            }
            
        }
        
        // head 정보 등록
        if (null != headList && 0 < headList.size()) {
            for (Map<String, Object> data: headList) {
            	
            	
            	String investNo = StringUtil.isNullToString(data.get("INVEST_NO"));
            	// 투자번호가 없는 경우 채번
            	if ("XXXXXXX".equals(investNo)) {
            		data.put("INVEST_NO"  , paramMap.get("INVEST_NO").toString());
            	}
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                // 자본화 일자 추출
                Map<String, Object> retrunParam = bdgTangAssetMgtDAO.selectCapitalDate(data);
                
                String inputCapitalData = StringUtil.isNullToString(data.get("CAPITAL_DATE"));
                String newCapitalData   = StringUtil.isNullToString(retrunParam.get("CAPITAL_DATE"));
                String beforeCrtnYn     = StringUtil.isNullToString(data.get("BFR_CRTN_YN"));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
	            Calendar cal = Calendar.getInstance();
	            cal.setTime(sdf.parse(data.get("CRTN_YY").toString()));
                String capitalEndData1 = sdf.format(cal.getTime()).substring(0, 4) + "1231";
                //System.out.println("capitalEndData1 ::" + capitalEndData1);
                cal.add(Calendar.YEAR,-1);
                String capitalEndData2 = sdf.format(cal.getTime()).substring(0, 4) + "1231";
                //System.out.println("capitalEndData2 ::" + capitalEndData2);
                String capitalEndData = "";
                
                // 자본화 일자 가능한 최종 기한일을 지정
                if ("Y".equals(beforeCrtnYn)) {
                	capitalEndData = capitalEndData2;
                } else {
                	capitalEndData = capitalEndData1;
                }
                
                //System.out.println("inputCapitalData ::" + inputCapitalData);
                //System.out.println("newCapitalData ::" + newCapitalData);
                //System.out.println("capitalEndData ::" + capitalEndData);
                
                // DB에 등록되 자료를 기반으로 자본화 일자가 추출된 경우
                if (!"".equals(newCapitalData)) {
                	// 사용자가 직접 입력 또는 기 등록된 자본화가 존재하는 경우 비교
                	if (!"".equals(inputCapitalData)) {
                		// 일자 셋팅
                		Date date1 = sdf.parse(newCapitalData);
                		Date date2 = sdf.parse(inputCapitalData);
                		Date endDate = sdf.parse(inputCapitalData);
                		
                		// DB데이터로 등록된 자본화 일자가 사용자가 직접 입력 또는 기 등록된 자본화 일자보다 후일인 경우 변경
                		if (date1.after(date2)) {
                			data.put("CAPITAL_DATE" , newCapitalData);
                		// 사용자가 직접 입력 또는 기 등록된 자본화 일자가 DB에 등록된 데이터로 계산된 일자보다 후일인 경우
                		} else {
                			// 당해년도를 넘길 수 없기에 년말로 deadline과 비교
                			if (date1.after(endDate)) {
                				data.put("CAPITAL_DATE" , capitalEndData);
                			}
                			data.put("CAPITAL_DATE" , inputCapitalData);
                		}
                	} else {
                		data.put("CAPITAL_DATE" , newCapitalData);
                	}
                } else {
                	data.put("CAPITAL_DATE" , "");
                }
                
                
                // 자본화 일자 UPDATE!!!
                bdgTangAssetMgtDAO.updateTangAssetHeadDate(data);
            }
        }        
        
        
    	return paramMap;
    }
    
    public Map<String,Object> apprTangAssetMgt(Map<String,Object> paramMap) throws ServiceException, Exception {

		paramMap.put("COMP_CD"    , paramMap.get("SB_COMP_CD"));
		paramMap.put("CRTN_YY"    , paramMap.get("TB_CRTN_YY"));
		paramMap.put("ORG_CD"     , paramMap.get("TB_ORG_CD"));
		
		paramMap.put("DOC_GUBN"   , "JT"); // DOC_GUBN 변경 필요
		
		paramMap.put("SABUN"      , getUserId());
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
    	
    	// HEAD정보 기준으로 문서관리번호 채번
    	Map<String, Object> docNoInfo = commonSelectDAO.selectDocNo(paramMap);
    	
    	paramMap.put("EPS_DOC_NO" , docNoInfo.get("DOC_NO")); // DOC_GUBN 변경 필요
    	commonDAO.insertEpsHistory(paramMap);

    	paramMap.put("STATUS"   , "2"); // 상태코드 변경처리
    	bdgTangAssetMgtDAO.apprTangAssetMgt(paramMap);
    	
    	return paramMap;
    }
    
    public Map<String,Object> saveEpsHistory(Map<String,Object> paramMap) throws ServiceException, Exception {
    	// 전달받은 데이터 셋팅
    	paramMap.put("EPS_DOC_NO"      , StringUtil.isNullToString(paramMap.get("key")));
    	paramMap.put("EPS_MAIN_KEY"    , StringUtil.isNullToString(paramMap.get("fiid")));
    	paramMap.put("EPS_PROCESS_KEY" , StringUtil.isNullToString(paramMap.get("piid")));
    	paramMap.put("STATUS"          , StringUtil.isNullToString(paramMap.get("appstatus")));
    	paramMap.put("EPS_FORM_ID"     , StringUtil.isNullToString(paramMap.get("legacyFormID")));
    	paramMap.put("APPROVAL_ID"     , StringUtil.isNullToString(paramMap.get("approverId")));
    	paramMap.put("APPROVAL_NAME"   , StringUtil.isNullToString(paramMap.get("approverName")));
    	if(paramMap.get("appComment") == null || paramMap.get("appComment") == "") {
    		paramMap.put("APPROVAL_DESC"   , StringUtil.isNullToString((paramMap.get("appComment"))));	
    	} else {
    		paramMap.put("APPROVAL_DESC"   , Base64.decodeBase64(StringUtil.isNullToString((String) (paramMap.get("appComment")))));	
    	}
    	paramMap.put("APPROVAL_DATE"   , StringUtil.isNullToString(paramMap.get("approverDate")));
    	
    	commonDAO.insertEpsHistory(paramMap);
    	String statusCode = paramMap.get("STATUS").toString();
    	//DRAFT:기안/APPROVAL:결재/COMPLETE:완료/ REJECT:반려/ WITHDRAW:회수
    	if (   "DRAFT".equals(statusCode)
    		|| "APPROVAL".equals(statusCode)) {
    		paramMap.put("STATUS" , "3");
    	} else if ("COMPLETE".equals(statusCode)) {
    		paramMap.put("STATUS" , "5");
    	} else if ("REJECT".equals(statusCode)) {
    		paramMap.put("STATUS" , "1");
    	} else if ("WITHDRAW".equals(statusCode)) {
    		paramMap.put("STATUS" , "1");
    	}
    	bdgTangAssetMgtDAO.updateHeader(paramMap);
    	return paramMap;
    }    
    
    public Map<String,Object> updateTangAssetMgtStatus(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	Map<String, Object> headMap   = (Map<String, Object>) paramMap.get("HEAD_LIST");
    	List<Map<String, Object>> headList   = (List<Map<String, Object>>) headMap.get("CHECK_LIST");
        
        // head 정보 등록
        if (null != headList && 0 < headList.size()) {
            for (Map<String, Object> data: headList) {
            	
                data.put("CRE_USER"   , getUserId());
                data.put("MOD_USER"   , getUserId());
                data.put("STATUS"   , paramMap.get("STATUS"));
                
            	//STATUS는 화면의 버튼 기능에 가변적으로 처리
            	// 상태 UPDATE!!                
                bdgTangAssetMgtDAO.updateTangAssetMgtStatus(data);
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> rejectTangAssetMgtStatus(Map<String,Object> paramMap) throws ServiceException, Exception {
    	
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
                
    	//STATUS는 화면의 버튼 기능에 가변적으로 처리
    	// 상태 UPDATE!!                
        bdgTangAssetMgtDAO.rejectTangAssetMgtStatus(paramMap);
            
    	return paramMap;
    }    
    
    public Map<String,Object> deleteTangAssetData(Map<String,Object> paramMap) throws ServiceException, Exception {
    	Map<String, Object> dataMap       = (Map<String, Object>) paramMap.get("ITEM_LIST");
    	List<Map<String, Object>> delList = (List<Map<String, Object>>)dataMap.get("DELETED");
        
        // head/detail 정보 삭제
        if (null != delList && 0 < delList.size()) {
            for (Map<String, Object> data: delList) {
            	
            	data.put("MOD_USER"   , getUserId());
            	String sendYn = StringUtil.isNullToString(data.get("SAP_SEND_YN"));
            	// SAP 전송 된건은 물리삭제가 아닌 삭제 플래그 처리
            	if ("Y".equals(sendYn)) {
            		bdgTangAssetMgtDAO.updateTangAssetHeadDelFlag(data);
            	} else {
                    bdgTangAssetMgtDAO.deletTangAssetMgtHead(data);
                    bdgTangAssetMgtDAO.deletTangAssetMgtDeatil(data);            		
            	}
            }
        }
        
    	return paramMap;
    }
    
    public Map<String,Object> sendSapTangAssetData(Map<String,Object> paramMap) throws ServiceException, Exception {
        
//    	Map<String, Object> headMap        = (Map<String, Object>) paramMap.get("ITEM_LIST");
//    	List<Map<String, Object>> headList = (List<Map<String, Object>>) headMap.get("CHECK_LIST");
//        
//        // head 정보 등록
//        if (null != headList && 0 < headList.size()) {
//            for (Map<String, Object> data: headList) {
//                data.put("CRE_USER"   , getUserId());
//                data.put("MOD_USER"   , getUserId());
//                bdgTangAssetMgtDAO.sendSapTangAssetData(data);
//            }
//        }
        
    	paramMap.put("CRE_USER"   , getUserId());
    	paramMap.put("MOD_USER"   , getUserId());
        bdgTangAssetMgtDAO.sendSapTangAssetData(paramMap);
        
    	return paramMap;
    }
    
	public List<Map<String, Object>> selectSendAssetData(Map<String, Object> paramMap) throws ServiceException, Exception {
		return bdgTangAssetMgtDAO.selectSendAssetData(paramMap);
	}
	
	public List<Map<String, Object>> selectTangAssetMgtHeadListPop(Map<String, Object> paramMap){
		return bdgTangAssetMgtDAO.selectTangAssetMgtHeadListPop(paramMap);
	}
	
	public Map<String, Object> selectEpsInfoData(Map<String, Object> paramMap) {
        return bdgTangAssetMgtDAO.selectEpsInfoData(paramMap);
    }	
	

}