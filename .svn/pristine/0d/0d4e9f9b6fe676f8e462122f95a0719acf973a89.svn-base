package com.app.ildong.usr.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.usr.dao.UsrUserSearchDAO;

@Service("UsrUserSearchService")
public class UsrUserSearchService extends BaseService {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private UsrUserSearchDAO usrUserSearchDAO;
	
	@Autowired
    private DigestUtil digestUtil;

	public List<Map<String,Object>> selectUsrUserSearchInList(Map<String,Object> paramMap) {
		return usrUserSearchDAO.selectUsrUserSearchInList(paramMap);
	}
	
	public List<Map<String,Object>> selectUsrUserSearchOutList(Map<String,Object> paramMap) {
		return usrUserSearchDAO.selectUsrUserSearchOutList(paramMap);
	}
	
	//외부 유저 비밀번호 초기화(사업자번호와 동일) 하기
	public void updateAllUserPwd(Map<String,Object> paramMap) throws Exception {
		
		
		paramMap.put("COMP_CD", getCompCd());
		
		List<Map<String, Object>> userIdList = usrUserSearchDAO.selectUserIdAll(paramMap);
		
		if(userIdList != null){
			if(userIdList.size() > 0){
				
				int num = 0;
				for(Map<String, Object> userIdMap : userIdList){

					String USER_ID = userIdMap.get("USER_ID").toString();				//유저아이디
					String POBUSI_REG_NO = userIdMap.get("POBUSI_REG_NO").toString();	//사업자번호
					//패스워드 암호화
					String encryptedPwd = digestUtil.digest(POBUSI_REG_NO , USER_ID);		//사업자번호와 동일하게 패스워드 만들기
					
					Map<String, Object> updateParam = new HashMap<String, Object>();
					
					updateParam.put("T_USER_ID", USER_ID);
					updateParam.put("T_PASSWORD", encryptedPwd);
					updateParam.put("COMP_CD", getCompCd());
					

					int updateCnt = usrUserSearchDAO.updateUserPwdChg(updateParam);
					
					if(updateCnt == 1){
			    		
			    	}else{
			    		throw new ServiceException("비밀번호 변경 시 오류 발생하였습니다.");
			    	}
					
					num++;
					
					logger.debug("num  : " + num + "  id : " + USER_ID + "  PWD  : " + encryptedPwd);
					
				}
				
			}
			
		}
		
		
	}

	
	//내부 유저 비밀번호 초기화(유저아이디와 동일) 하기
	public void updateInAllUserPwd(Map<String,Object> paramMap) throws Exception {
		
		
		paramMap.put("COMP_CD", getCompCd());
		
		List<Map<String, Object>> userIdList = usrUserSearchDAO.selectInUserIdAll(paramMap);
		
		if(userIdList != null){
			if(userIdList.size() > 0){
				
				int num = 0;
				for(Map<String, Object> userIdMap : userIdList){
					
					String USER_ID = userIdMap.get("USER_ID").toString();				//유저아이디
					//패스워드 암호화
					String encryptedPwd = digestUtil.digest(USER_ID , USER_ID);		//유저아이디와 동일하게 패스워드 만들기
					
					Map<String, Object> updateParam = new HashMap<String, Object>();
					
					updateParam.put("T_USER_ID", USER_ID);
					updateParam.put("T_PASSWORD", encryptedPwd);
					updateParam.put("COMP_CD", getCompCd());
					
					
					int updateCnt = usrUserSearchDAO.updateInUserPwdChg(updateParam);
					
					if(updateCnt == 1){
						
					}else{
						throw new ServiceException("비밀번호 변경 시 오류 발생하였습니다.");
					}
					
					num++;
					
					logger.debug("num  : " + num + "  id : " + USER_ID + "  PWD  : " + encryptedPwd);
					
				}
				
			}
			
		}
		
		
	}
}
