package com.app.ildong.common.interceptor;

import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.app.ildong.common.session.UserSessionUtil;

/**
 * 인증여부 체크 인터셉터
 *
 */
public class AuthenticInterceptor extends HandlerInterceptorAdapter {
	protected final Log logger = LogFactory.getLog(getClass());
	
	private Set<String> uncheckUrl;

	public void setUncheckUrl(Set<String> uncheckUrl){

		this.uncheckUrl = uncheckUrl;
	}
	
	/**
	 * 세션에 로그인정보가 있는지 여부로 인증 여부를 체크한다.
	 * 로그인정보가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ServletException {

		try {
			
			String strReqMapping = request.getRequestURI().replaceFirst(request.getContextPath(), "");
			String contentType = StringUtils.defaultIfBlank(request.getContentType(), "");
			if( logger.isDebugEnabled()) {
				logger.debug("strReqMapping = " + strReqMapping);
				logger.debug("contentType = " + contentType);
				logger.debug("getRequestedSessionId = " + request.getRequestedSessionId());
				
			}
			Map<String,Object> loginInfo =  UserSessionUtil.getUserSession(request);
			if( logger.isDebugEnabled()) {
				logger.debug("loginInfo = " + loginInfo);
			}
			
			boolean isAuthenticated = false;
			
			if( loginInfo == null ) {
				isAuthenticated = false;
			} else {
				String userId = (String)loginInfo.get("USER_ID");
				if( userId == null ) {
					isAuthenticated = false;
				} else {
					isAuthenticated = true;
				}
			}
				
			if (
				// 기본 예산
			       "/com/bdg/bdgBasicMgtPop.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgBasicMgtEps.do".equals(request.getRequestURI())
			    || "/com/bdg/selectBasicMgtHeaderPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectBasicMgtDetail.do".equals(request.getRequestURI())
			    
			    // 수정 예산
			    || "/com/bdg/bdgModifyMgtEps.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgModifyMgtPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectModifyMgtHeaderPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectModifyMgtDetail.do".equals(request.getRequestURI())
			    
			    // 실행 예산
			    || "/com/bdg/bdgExecBugtMgtEps.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgExecBugtMgtPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectExecBugtMgtHeadListPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectExecBugtMgtDetailList.do".equals(request.getRequestURI())
			    
			    // APM 예산신청
			    || "/com/bdg/bdgApmBasicMgtPop.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgApmBasicMgtEps.do".equals(request.getRequestURI())
			    || "/com/bdg/selectApmBasicMgtPop.do".equals(request.getRequestURI())
			    
			    // APM 이관신청
			    || "/com/bdg/bdgApmTransMgtEps.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgApmTransMgtPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectEstCostReqListPop.do".equals(request.getRequestURI())		
			    
			    // 견적원가의뢰
			    || "/com/bdg/bdgEstCostReqEps.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgEstCostReqPop.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgEstCostDetail.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgEstCostDetailResult.do".equals(request.getRequestURI())
			    || "/com/bdg/selectEstCostReqDetail.do".equals(request.getRequestURI())
			    || "/com/bdg/selectEstCostReqDetailResult.do".equals(request.getRequestURI())
			    || "/com/bdg/selectEstCostCnt.do".equals(request.getRequestURI())
			    || "/com/bdg/selectApmTransMgtPop.do".equals(request.getRequestURI())		
			    || "/com/bdg/selectApmTransMgtDetailList.do".equals(request.getRequestURI())			    
			    
			    // 추가 예산신청
			    || "/com/bdg/bdgSupplementEps.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgSupplementPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectSupplementPop.do".equals(request.getRequestURI())
			    
			    // 유형자산 신청
			    || "/com/bdg/bdgTangAssetMgtEps.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgTangAssetMgtPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectTangAssetMgtHeadListPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectTangAssetDetailList.do".equals(request.getRequestURI())
			    
			    // 부서견본 
			    || "/com/bdg/bdgDeptSampleMgtEps.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgDeptSampleMgtPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectDeptSampleMgtListPop.do".equals(request.getRequestURI())
			    
			    // 공급업체 계좌등록
			    || "/com/bdg/bdgVendBankMgtEps.do".equals(request.getRequestURI())
			    || "/com/bdg/bdgVendBankMgtPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectVendBankMgtHeadListPop.do".equals(request.getRequestURI())
			    || "/com/bdg/selectVendBankMgtDetailList.do".equals(request.getRequestURI())
			    
			    // 외부업체 공지사항, FAQ, 자료실
			    || "/com/sys/sysInFaqListPop.do".equals(request.getRequestURI())
			    || "/com/sys/sysInDataListPop.do".equals(request.getRequestURI())
			    || "/com/sys/sysOutBoardDetail.do".equals(request.getRequestURI())
			    || "/com/sys/selectSysOutBoardFaqList.do".equals(request.getRequestURI())
			    || "/com/sys/selectSysOutBoardDataList.do".equals(request.getRequestURI())
			    
			    //모바일 창고관리
			    || "/com/wrh/wrhStorageSpaceM.do".equals(request.getRequestURI())
			   ) {
				isAuthenticated = true;
			}
			
			if( logger.isDebugEnabled()) {
				logger.debug(" URI = " +  request.getRequestURI() + ",  isAuthenticated = " + isAuthenticated);
			}			
			
			if ( isAuthenticated == false) {
				//Ajax 콜인지 아닌지 판단
                if(isAjaxRequest(request)){
                    logger.info("======= call /sessionIntercepter session is null =======");
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                    return false;
                } else {
                	System.out.println("isAuthenticated in------------------");
                	// 내부사용자 도메인으로 처리해야함!
            		Map<String,Object> userinfo  = UserSessionUtil.getUserSession(request);
                	String internalUser = (String)userinfo.get("USER_CLS"); 
                	System.out.println("internalUser------------------>" + (String)userinfo.get("USER_CLS"));
                	if("B".equals(internalUser)) {
                    	ModelAndView modelAndView = new ModelAndView("redirect:/loginView.do");
                    	throw new ModelAndViewDefiningException(modelAndView);
                	} else {
                    	ModelAndView modelAndView = new ModelAndView("redirect:/loginViewExternal.do");
                    	throw new ModelAndViewDefiningException(modelAndView);
                	}
//                	ModelAndView modelAndView = new ModelAndView("redirect:/common/error/noauth.jsp");
//                	throw new ModelAndViewDefiningException(modelAndView);
                }
			}
			
			boolean isPassUrl = false;
			for(Iterator<String> it = this.uncheckUrl.iterator(); it.hasNext();){
	
				if(Pattern.matches((String)it.next(), strReqMapping)){// 정규표현식을 이용해서 요청 URI가 허용된 URL에 맞는지 점검함.
					isPassUrl = true;
					break;
				}
			}
		
			if( isPassUrl == false) {
				
				if ("".equals(contentType) || "application/x-www-form-urlencoded".equals(contentType)) {
					
					Boolean existPageAuth = false;
					String gMenuNo = StringUtils.defaultIfBlank((String)request.getParameter("G_MENU_CD"), "");
		
					if( ! "".equals(gMenuNo) ) {
						Map<String,Object> menuMap = (Map<String,Object>)loginInfo.get("MENU_MAP");
		
						if( menuMap.containsKey(gMenuNo)) {
							existPageAuth = true;
						} else {
							existPageAuth = false;
						}
					} else {
						existPageAuth = false;
					}
					
					if( logger.isDebugEnabled()) {
						logger.debug("MENU AUTH CHECK : gMenuNo=" + gMenuNo + ", "+ existPageAuth);
					}
					
					if( existPageAuth == false) {

						ModelAndView modelAndView = new ModelAndView("redirect:/common/error/noaccess.jsp");
						throw new ModelAndViewDefiningException(modelAndView);
					}
		
				}
			}
		} catch ( ModelAndViewDefiningException mde) {
			throw mde;
		} catch ( Exception e ) {
			logger.error(e.getMessage());
			
			ModelAndView modelAndView = new ModelAndView("redirect:/common/error/error.jsp");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		return true;
	}
	
	
	/**
	 * Ajax Request 확인
	 * @param request
	 * @return
	 */
	private boolean isAjaxRequest(HttpServletRequest request) {
		String ajaxHeader = "ajax";
        if( logger.isDebugEnabled()) {
        	logger.info("======= req.getHeader('ajax') : " + request.getHeader(ajaxHeader));
        }
        return request.getHeader(ajaxHeader) != null && "true".equals(request.getHeader(ajaxHeader));
        
    }

	
	
	
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object controller, ModelAndView modelAndView) throws Exception {
		
		try {

			String gTopMenuNo = StringUtils.defaultIfBlank(request.getParameter("G_TOP_MENU_CD"), "");
			String gMenuNo = StringUtils.defaultIfBlank(request.getParameter("G_MENU_CD"), "");
			
			if( modelAndView != null ) {
				if( ! "".equals(gTopMenuNo)) {
					modelAndView.addObject("G_TOP_MENU_CD", gTopMenuNo);
				}
				
				if( ! "".equals(gMenuNo)) {
					modelAndView.addObject("G_MENU_CD", gMenuNo);
				}
			}
		} catch( Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	
	
}
