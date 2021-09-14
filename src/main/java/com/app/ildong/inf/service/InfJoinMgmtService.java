package com.app.ildong.inf.service;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.auth.DefaultAuthenticationProvider;
import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.service.MessageSendService;
import com.app.ildong.common.util.PropertiesUtil;
import com.app.ildong.common.util.StringUtilEx;
import com.app.ildong.inf.dao.InfJoinMgmtDAO;

@Service("sInfJoinMgmtService")
public class InfJoinMgmtService extends BaseService {
	
    @Autowired
    private InfJoinMgmtDAO InfJoinMgmtDAO;
    
    private PropertiesUtil propertiesUtil = new PropertiesUtil();
    
    @Autowired
    private DigestUtil digestUtil;
    
    
    @Autowired
    private MessageSendService messageSendService;
    
    //회원 PW 찾기
    public Map<String,Object> selectFindUserPw(Map<String,Object> paramMap) throws Exception {
    	
    	Map<String,Object> resultMap = new HashMap<String, Object>();
    	String COMP_CD = "";
    	
    	//회원 PW 찾기
		Map<String,Object> findIdMap = InfJoinMgmtDAO.selectFindUserPw(paramMap);
		
		if(findIdMap == null || ("").equals(findIdMap.get("USER_ID").toString()) ){
			throw new ServiceException("가입정보가 존재하지 않습니다.");
		}else{

			String newPassword = StringUtilEx.makeRandomPassword();		//랜덤패스워드 생성
			
			String user_id = findIdMap.get("USER_ID").toString();
			//신규 패스워드 암호화
			String encryptedPwd = digestUtil.digest(newPassword, user_id.toLowerCase());
			
			if(("").equals(encryptedPwd) ){
				throw new ServiceException("임시비밀번호 암호화에 실패했습니다.");
			}
			
			paramMap.put("T_RANDOM_PASSWORD", encryptedPwd);
			
			//랜덤비밀번호로 교체
			int returnChgPasswrod = InfJoinMgmtDAO.updateResetUserPassword(paramMap);
			if(returnChgPasswrod == 1){
    		}else{
        		throw new ServiceException("임시비밀번호 설정시 오류 발생하였습니다.");
        	}
			
			
			Map<String, Object> sendMap = new HashMap<String, Object>();
			
			//이메일을 통한 PASSWORD검색
			sendMap.put("COMP_CD", COMP_CD);
			sendMap.put("MAIL_ID"				, "PPD_05");							//비밀번호찾기 관련
			sendMap.put("RECEIVER_EMAIL"		, findIdMap.get("EMAIL_ID"));				//받는사람이메일
			sendMap.put("USER_ID"				, findIdMap.get("USER_ID"));			//사용자 아이디(찾은 결과)
			sendMap.put("USER_INFO"				, "비밀번호");							//메일템플릿에 보낼 구분
			sendMap.put("USER_INFO_VLAUE"		, newPassword);							//메일템플릿에 보낼 구분값(새로생성된 패스워드)
			
			Map<String, Object> resultMail = messageSendService.sendMailMessage(sendMap);	//임시비밀번호 메일발송
			
			
			
			
			if( !("S").equals(resultMail.get("RESULT")) ){		//메일발송실패라면
				throw new ServiceException("임시비밀번호 메일발송에 실패했습니다.");
			}
		}
    	return resultMap;
    }
}
