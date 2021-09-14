package com.app.ildong.sys.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.exception.ServiceException;
import com.app.ildong.common.model.mvc.BaseService;
import com.app.ildong.common.util.DateUtil;
import com.app.ildong.common.util.StringUtil;
import com.app.ildong.sys.dao.SysRfcDAO;

@Service("SysRfcService")
public class SysRfcService extends BaseService {
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	private SysRfcDAO sysRfcDAO;
	
	@Autowired
	private JCoProcessService jcoProcessService;
	
	@Autowired
	private DigestUtil digestUtil;
	
	/**
	 * WBS정보 수신
	 * @param paramMap
	 * @throws ServiceException
	 * @throws Exception
	 */
	public void receiveWBSInfo(Map<String, Object> paramMap) throws ServiceException, Exception{
		List<Map<String, Object>> resultList = (List<Map<String, Object>>) paramMap.get("T_RESULT");
		
		if(resultList.size() > 0)
		{
			for(int i = 0 ; i < resultList.size(); i ++)
			{
				Map<String, Object> resMap = resultList.get(i);
				Map<String, Object> pMap = new HashMap<String, Object>();
				
				pMap.put("CODE", resMap.get("POSID"));
				pMap.put("NAME", resMap.get("POST1"));
				pMap.put("MASTER_CLASS_CODE", "960");
				pMap.put("COMP_CD", getCompCd());
				
				int cnt = sysRfcDAO.selectMasterInfoExist(pMap);
				
				//데이터가 없을 경우
				if(cnt == 0)
				{
					sysRfcDAO.insertMasterInfo(pMap);
				}
				//데이터가 있을 경우
				else
				{
					sysRfcDAO.updateMasterInfo(pMap);
				}
			}
		}
	}
	
	/**
	 * GL정보 수신
	 * @param paramMap
	 * @throws ServiceException
	 * @throws Exception
	 */
	public void receiveGLInfo(Map<String, Object> paramMap) throws ServiceException, Exception{
		List<Map<String, Object>> resultList = (List<Map<String, Object>>) paramMap.get("T_RESULT");
		
		if(resultList.size() > 0) {
			for(int i = 0 ; i < resultList.size(); i ++) {
				Map<String, Object> resMap = resultList.get(i);
				Map<String, Object> pMap = new HashMap<String, Object>();
				
				pMap.put("CODE", resMap.get("SAKNR"));
				pMap.put("NAME", resMap.get("TXT50"));
				pMap.put("MASTER_CLASS_CODE", "900");
				pMap.put("COMP_CD", getCompCd());
				
				int cnt = sysRfcDAO.selectMasterInfoExist(pMap);
				
				//데이터가 없을 경우
				if(cnt == 0) {
					sysRfcDAO.insertMasterInfo(pMap);
				
			    //데이터가 있을 경우
				} else {
				
					sysRfcDAO.updateMasterInfo(pMap);
				}
			}
		}
	}
	
	/**
	 * 인사정보 수신
	 * @param paramMap
	 * @throws ServiceException
	 * @throws Exception
	 */
	public void receiveEmpInfo(Map<String, Object> paramMap) throws ServiceException, Exception{
		
		List<Map<String, Object>> resultList = (List<Map<String, Object>>) paramMap.get("OUTTAB");
		if(resultList.size() > 0)
		{
			for(int i = 0 ; i < resultList.size() ; i ++)
			{
				Map<String, Object> resMap	= resultList.get(i);
				Map<String, Object> pMap	= new HashMap<String, Object>();
				
				//I/F 로그 추가.
				sysRfcDAO.insertUserIfInfo(resMap);
				
				pMap.put("COMP_CD",			resMap.get("EMP_COMPCD"));				/* 회사코드 */
				pMap.put("USER_ID",			resMap.get("EMP_NO"));					/* 사용자아이디 */
				pMap.put("USER_NAME",		resMap.get("EMP_NM"));					/* 사용자명 */
				pMap.put("USER_ENG_NAME",	resMap.get("EMP_ENGNM"));				/* 영문이름 */
				pMap.put("DEPT_CD",			resMap.get("DEPT_CD"));					/* 부서코드 */
				pMap.put("EMP_NO",			resMap.get("EMP_NO"));					/* 사원번호 */
				pMap.put("RSPOF_CD",		resMap.get("FUNC_CD"));					/* 직책코드 */
				pMap.put("CELL_PHONE_NO",	resMap.get("MTELNO"));					/* 휴대폰번호 */
				pMap.put("EMAIL",			resMap.get("EMP_MAIL_ID"));				/* 이메일 */
				pMap.put("EMP_STATUS",		resMap.get("EMP_STATUS"));				/* 재직구분(T:퇴직, H:휴직, C:재직) */
				
				String empStatus	= (String)ObjectUtils.defaultIfNull(resMap.get("EMP_STATUS"), "");
				
				//T_USERS 테이블에 데이터 확인.
				int cnt = sysRfcDAO.selectUserInfoExist(pMap);
				
				//재직일 경우
				if("C".equals(empStatus))
				{
					pMap.put("USG_YN", "Y");
					pMap.put("DEL_YN", "N");
				}
				//휴직일 경우
				else if("H".equals(empStatus))
				{
					pMap.put("USG_YN", "N");
					pMap.put("DEL_YN", "N");
				}
				//퇴직일 경우
				else
				{
					pMap.put("USG_YN", "N");
					pMap.put("DEL_YN", "Y");
				}
				
				//데이터가 없을 경우
				if(cnt == 0)
				{
					String userId = (String)ObjectUtils.defaultIfNull(pMap.get("USER_ID"), "");
					
					//사용자의 이름이 없을 경우 사번으로 대체.
					if("".equals((String)ObjectUtils.defaultIfNull(pMap.get("USER_NAME"), "")))
					{
						pMap.put("USER_NAME", userId);
					}
					//추가되는 값은 상위부서가 없으므로 상위부서 구해서 Insert 해줌.
/*					String upDeptCd = "";
					Map<String, Object> deptMap = sysRfcDAO.selectUpDetpInfo(pMap);
					upDeptCd = (String)ObjectUtils.defaultIfNull(deptMap.get("UP_DEPT_CD"), "");
					pMap.put("BG_DEPT_CD", upDeptCd);
					*/
					//기본값으로 사번을 암호화하여 추가.
					@SuppressWarnings("static-access")
					String encryptedPwd = digestUtil.digest(userId, userId);
					pMap.put("PASSWORD", encryptedPwd);
					
					sysRfcDAO.insertUserInfoByIF(pMap);
					int roleCnt = sysRfcDAO.selectRoleInfoExist(pMap);
					if(roleCnt == 0)
					{
						//R600권한 추가.(사업부)
						pMap.put("ROLE_CD", "R600");
						sysRfcDAO.insertUserRoleByIF(pMap);	
					}
				}
				//데이터가 있을 경우
				else
				{
					//데이터 비교 후 UPDATE한다.
					Map<String, Object> userMap = sysRfcDAO.selectDetailUserInfo(pMap);
					String deptCd		= (String)ObjectUtils.defaultIfNull(userMap.get("DEPT_CD"), "");
					String rspofCd		= (String)ObjectUtils.defaultIfNull(userMap.get("RSPOF_CD"), "");
					String cellPhoneNo	= (String)ObjectUtils.defaultIfNull(userMap.get("CELL_PHONE_NO"), "");
					String email		= (String)ObjectUtils.defaultIfNull(userMap.get("EMAIL"), "");
					String userEngName	= (String)ObjectUtils.defaultIfNull(userMap.get("USER_ENG_NAME"), "");
					String usgYn		= (String)ObjectUtils.defaultIfNull(userMap.get("USG_YN"), "");
					String delYn		= (String)ObjectUtils.defaultIfNull(userMap.get("DEL_YN"), "");
					
					String cDeptCd		= (String)ObjectUtils.defaultIfNull(pMap.get("DEPT_CD"), "");
					String cRspofCd		= (String)ObjectUtils.defaultIfNull(pMap.get("RSPOF_CD"), "");
					String cCellPhoneNo	= (String)ObjectUtils.defaultIfNull(pMap.get("CELL_PHONE_NO"), "");
					String cEmail		= (String)ObjectUtils.defaultIfNull(pMap.get("EMAIL"), "");
					String cUserEngName	= (String)ObjectUtils.defaultIfNull(pMap.get("USER_ENG_NAME"), "");
					String cUsgYn		= (String)ObjectUtils.defaultIfNull(pMap.get("USG_YN"), "");
					String cDelYn		= (String)ObjectUtils.defaultIfNull(pMap.get("DEL_YN"), "");
					
					//정보가 다를 경우만 업데이트
					if(!deptCd.equals(cDeptCd) || !rspofCd.equals(cRspofCd) || !cellPhoneNo.equals(cCellPhoneNo) || !email.equals(cEmail) || !userEngName.equals(cUserEngName) || !usgYn.equals(cUsgYn) || !delYn.equals(cDelYn))
					{
						sysRfcDAO.updateUserInfoByIF(pMap);
					}
				}
			}
		}
	}
	
	/**
	 * 부서정보 수신
	 * @param paramMap
	 * @throws ServiceException
	 * @throws Exception
	 */
	public void receiveDeptInfo(Map<String, Object> paramMap) throws ServiceException, Exception{
		
		List<Map<String, Object>> resultList = (List<Map<String, Object>>) paramMap.get("OUTTAB");
		
		if(resultList.size() > 0)
		{
			for(int i = 0 ; i < resultList.size() ; i ++)
			{
				Map<String, Object> resMap	= resultList.get(i);
				Map<String, Object> pMap	= new HashMap<String, Object>();
				
				//I/F 로그 추가.
				sysRfcDAO.insertDeptIfInfo(resMap);
				
				pMap.put("DEPT_CD",			resMap.get("DEPT_CD"));				/* 부서코드 */
				pMap.put("DEPT_NAME",		resMap.get("DEPT_NM"));				/* 부서명 */
				pMap.put("UP_DEPT_CD",		resMap.get("PARENT_DEPT"));			/* 상위부서코드 */
				pMap.put("COMP_CD",			resMap.get("BUKRS"));				/* 회사코드 */
				pMap.put("HAS_CHILD_YN",	resMap.get("CHILD_FLAG"));			/* 하위부서여부 */
				pMap.put("DEL_YN",			resMap.get("DEL_FLAG"));			/* 삭제여부 */
				
				//T_DEPT 테이블에 데이터 확인.
				int cnt = sysRfcDAO.selectDeptInfoExist(pMap);
				
				//데이터가 없을 경우
				if(cnt == 0)
				{
					sysRfcDAO.insertDeptInfoByIF(pMap);
				}
				//데이터가 있을 경우
				else
				{
					//데이터 비교 후 UPDATE한다.
					Map<String, Object> deptMap = sysRfcDAO.selectDetailDeptInfo(pMap);
					String deptName		= (String)ObjectUtils.defaultIfNull(deptMap.get("DEPT_NAME"), "");
					String upDeptCd		= (String)ObjectUtils.defaultIfNull(deptMap.get("UP_DEPT_CD"), "");
					String hasChildYn	= (String)ObjectUtils.defaultIfNull(deptMap.get("HAS_CHILD_YN"), "");
					String delYn		= (String)ObjectUtils.defaultIfNull(deptMap.get("DEL_YN"), "");
					
					String cDeptName	= (String)ObjectUtils.defaultIfNull(pMap.get("DEPT_NAME"), "");
					String cUpDeptCd	= (String)ObjectUtils.defaultIfNull(pMap.get("UP_DEPT_CD"), "");
					String cHasChildYn	= (String)ObjectUtils.defaultIfNull(pMap.get("HAS_CHILD_YN"), "");
					String cDelYn		= (String)ObjectUtils.defaultIfNull(pMap.get("DEL_YN"), "");
					
					//정보가 다를 경우만 업데이트
					if(!deptName.equals(cDeptName) || !upDeptCd.equals(cUpDeptCd) || !hasChildYn.equals(cHasChildYn) || !delYn.equals(cDelYn))
					{
						sysRfcDAO.updateDeptInfoByIF(pMap);
					}
				}
			}
		}
	}
	
	/**
	 * GL정보 수신
	 * @param paramMap
	 * @return
	 * @throws ServiceException
	 * @throws Exception
	 */
	public Map<String, Object> receiveGLInfoByBatch(Map<String, Object> paramMap) throws ServiceException, Exception
	{
		String procId 	= DateUtil.getCurrentDateTimeAsString()+StringUtil.getRandomStr(10);
		
		int cntSucc = 0;
		int cntFail = 0;
		int cntTotal = 0;
		
		paramMap.put("COMP_CD"		, getCompCd());
		paramMap.put("PROC_ID"		, procId);
		
		paramMap.put("FUNC_NAME", "ZFI_WITHUS_GL_ACCOUNT_LIST");
		
		try{
			Map<String, Object> resultMap = jcoProcessService.processJCoExecute(paramMap);
			
			if(resultMap.get("T_RESULT") != null)
			{
				List<Map<String, Object>> resultList = (List<Map<String, Object>>) resultMap.get("T_RESULT");
				cntTotal += resultList.size();
				if(resultList.size() > 0)
				{
					for(int i = 0 ; i < resultList.size(); i ++)
					{
						Map<String, Object> resMap = resultList.get(i);
						Map<String, Object> pMap = new HashMap<String, Object>();
						
						pMap.put("CODE", resMap.get("SAKNR"));
						pMap.put("NAME", resMap.get("TXT50"));
						pMap.put("MASTER_CLASS_CODE", "900");
						pMap.put("COMP_CD", getCompCd());
						
						int cnt = sysRfcDAO.selectMasterInfoExist(pMap);
						
						//데이터가 없을 경우
						if(cnt == 0)
						{
							try{
								sysRfcDAO.insertMasterInfo(pMap);
								cntSucc++;	
							}catch(Exception e){
								cntFail++;
							}
						}
						//데이터가 있을 경우
						else
						{
							try{
								sysRfcDAO.updateMasterInfo(pMap);
								cntSucc++;	
							}catch(Exception e){
								cntFail++;
							}
						}
					}
				}
			}
		}catch(Exception e){
			cntFail++;
		}
		
		if(cntFail > 0){
			paramMap.put("RESULT", "F");
		}else
		{
			paramMap.put("RESULT", "S");
		}
		
		paramMap.put("SUCC_CNT",	cntSucc);
		paramMap.put("FAIL_CNT",	cntFail);
		paramMap.put("TOTAL_CNT",	cntTotal);
		
		return paramMap;
	}
	
	/**
	 * WBS정보 수신
	 * @param paramMap
	 * @return
	 * @throws ServiceException
	 * @throws Exception
	 */
	public Map<String, Object> receiveWBSInfoByBatch(Map<String, Object> paramMap) throws ServiceException, Exception
	{
		String procId 	= DateUtil.getCurrentDateTimeAsString()+StringUtil.getRandomStr(10);
		
		int cntSucc = 0;
		int cntFail = 0;
		int cntTotal = 0;
		
		paramMap.put("COMP_CD"		, getCompCd());
		paramMap.put("PROC_ID"		, procId);
		
		paramMap.put("FUNC_NAME", "ZFI_WITHUS_WBS_LIST");
		paramMap.put("I_POSID", "%");
		
		try{
			Map<String, Object> resultMap = jcoProcessService.processJCoExecute(paramMap);
			
			if(resultMap.get("T_RESULT") != null)
			{
				List<Map<String, Object>> resultList = (List<Map<String, Object>>) resultMap.get("T_RESULT");
				
				cntTotal += resultList.size();
				
				if(resultList.size() > 0)
				{
					for(int i = 0 ; i < resultList.size(); i ++)
					{
						Map<String, Object> resMap = resultList.get(i);
						Map<String, Object> pMap = new HashMap<String, Object>();
						
						pMap.put("CODE", resMap.get("POSID"));
						pMap.put("NAME", resMap.get("POST1"));
						pMap.put("MASTER_CLASS_CODE", "960");
						pMap.put("COMP_CD", getCompCd());
						
						int cnt = sysRfcDAO.selectMasterInfoExist(pMap);
						
						//데이터가 없을 경우
						if(cnt == 0)
						{
							try{
								sysRfcDAO.insertMasterInfo(pMap);
								cntSucc++;	
							}catch(Exception e){
								cntFail++;
							}
						}
						//데이터가 있을 경우
						else
						{
							try{
								sysRfcDAO.updateMasterInfo(pMap);
								cntSucc++;	
							}catch(Exception e){
								cntFail++;
							}
						}
					}
				}
			}
		}catch(Exception e){
			cntFail++;
		}
		
		if(cntFail > 0){
			paramMap.put("RESULT", "F");
		}else
		{
			paramMap.put("RESULT", "S");
		}
		
		paramMap.put("SUCC_CNT",	cntSucc);
		paramMap.put("FAIL_CNT",	cntFail);
		paramMap.put("TOTAL_CNT",	cntTotal);
		
		return paramMap;
	}
	
	/**
	 * 인사정보 수신
	 * @param paramMap
	 * @return
	 * @throws ServiceException
	 * @throws Exception
	 */
	public Map<String, Object> receiveEMPInfoByBatch(Map<String, Object> paramMap) throws ServiceException, Exception
	{
		String procId 	= DateUtil.getCurrentDateTimeAsString()+StringUtil.getRandomStr(10);
		
		int cntSucc = 0;
		int cntFail = 0;
		int cntTotal = 0;
		
		paramMap.put("COMP_CD"		, getCompCd());
		paramMap.put("PROC_ID"		, procId);
		
		paramMap.put("FUNC_NAME", "Z_HR_EAC_EMP");
		
		try{
			Map<String, Object> resultMap = jcoProcessService.processJCoExecute(paramMap);
			
			if(!"[]".equals(resultMap.get("OUTTAB").toString()))
			{
				List<Map<String, Object>> resultList = (List<Map<String, Object>>) resultMap.get("OUTTAB");
				cntTotal += resultList.size();
				
				if(resultList.size() > 0)
				{
					for(int i = 0 ; i < resultList.size() ; i ++)
					{
						Map<String, Object> resMap	= resultList.get(i);
						Map<String, Object> pMap	= new HashMap<String, Object>();
						
						//I/F 로그 추가.
						sysRfcDAO.insertUserIfInfo(resMap);
						
						pMap.put("COMP_CD",			resMap.get("EMP_COMPCD"));				/* 회사코드 */
						pMap.put("USER_ID",			resMap.get("EMP_NO"));					/* 사용자아이디 */
						pMap.put("USER_NAME",		resMap.get("EMP_NM"));					/* 사용자명 */
						pMap.put("USER_ENG_NAME",	resMap.get("EMP_ENGNM"));				/* 영문이름 */
						pMap.put("DEPT_CD",			resMap.get("DEPT_CD"));					/* 부서코드 */
						pMap.put("EMP_NO",			resMap.get("EMP_NO"));					/* 사원번호 */
						pMap.put("RSPOF_CD",		resMap.get("FUNC_CD"));					/* 직책코드 */
						pMap.put("CELL_PHONE_NO",	resMap.get("MTELNO"));					/* 휴대폰번호 */
						pMap.put("EMAIL",			resMap.get("EMP_MAIL_ID"));				/* 이메일 */
						pMap.put("EMP_STATUS",		resMap.get("EMP_STATUS"));				/* 재직구분(T:퇴직, H:휴직, C:재직) */
						
						String empStatus	= (String)ObjectUtils.defaultIfNull(resMap.get("EMP_STATUS"), "");
						
						//T_USERS 테이블에 데이터 확인.
						int cnt = sysRfcDAO.selectUserInfoExist(pMap);
						
						//재직일 경우
						if("C".equals(empStatus))
						{
							pMap.put("USG_YN", "Y");
							pMap.put("DEL_YN", "N");
						}
						//휴직일 경우
						else if("H".equals(empStatus))
						{
							pMap.put("USG_YN", "N");
							pMap.put("DEL_YN", "N");
						}
						//퇴직일 경우
						else
						{
							pMap.put("USG_YN", "N");
							pMap.put("DEL_YN", "Y");
						}
						
						//데이터가 없을 경우
						if(cnt == 0)
						{
							try{
								String userId = (String)ObjectUtils.defaultIfNull(pMap.get("USER_ID"), "");
								
								//사용자의 이름이 없을 경우 사번으로 대체.
								if("".equals((String)ObjectUtils.defaultIfNull(pMap.get("USER_NAME"), "")))
								{
									pMap.put("USER_NAME", userId);
								}
								//추가되는 값은 상위부서가 없으므로 상위부서 구해서 Insert 해줌.
/*								String upDeptCd = "";
								Map<String, Object> deptMap = sysRfcDAO.selectUpDetpInfo(pMap);
								upDeptCd = (String)ObjectUtils.defaultIfNull(deptMap.get("UP_DEPT_CD"), "");
								pMap.put("BG_DEPT_CD", upDeptCd);*/
								
								//기본값으로 사번을 암호화하여 추가.
								@SuppressWarnings("static-access")
								String encryptedPwd = digestUtil.digest(userId, userId);
								pMap.put("PASSWORD", encryptedPwd);
								
								sysRfcDAO.insertUserInfoByIF(pMap);
								int roleCnt = sysRfcDAO.selectRoleInfoExist(pMap);
								if(roleCnt == 0)
								{
									//R600권한 추가.(사업부)
									pMap.put("ROLE_CD", "R600");
									sysRfcDAO.insertUserRoleByIF(pMap);	
								}
								cntSucc++;
							}catch(Exception e){
								cntFail++;
							}
						}
						//데이터가 있을 경우
						else
						{
							//데이터 비교 후 UPDATE한다.
							Map<String, Object> userMap = sysRfcDAO.selectDetailUserInfo(pMap);
							String deptCd		= (String)ObjectUtils.defaultIfNull(userMap.get("DEPT_CD"), "");
							String rspofCd		= (String)ObjectUtils.defaultIfNull(userMap.get("RSPOF_CD"), "");
							String cellPhoneNo	= (String)ObjectUtils.defaultIfNull(userMap.get("CELL_PHONE_NO"), "");
							String email		= (String)ObjectUtils.defaultIfNull(userMap.get("EMAIL"), "");
							String userEngName	= (String)ObjectUtils.defaultIfNull(userMap.get("USER_ENG_NAME"), "");
							String usgYn		= (String)ObjectUtils.defaultIfNull(userMap.get("USG_YN"), "");
							String delYn		= (String)ObjectUtils.defaultIfNull(userMap.get("DEL_YN"), "");
							
							String cDeptCd		= (String)ObjectUtils.defaultIfNull(pMap.get("DEPT_CD"), "");
							String cRspofCd		= (String)ObjectUtils.defaultIfNull(pMap.get("RSPOF_CD"), "");
							String cCellPhoneNo	= (String)ObjectUtils.defaultIfNull(pMap.get("CELL_PHONE_NO"), "");
							String cEmail		= (String)ObjectUtils.defaultIfNull(pMap.get("EMAIL"), "");
							String cUserEngName	= (String)ObjectUtils.defaultIfNull(pMap.get("USER_ENG_NAME"), "");
							String cUsgYn		= (String)ObjectUtils.defaultIfNull(pMap.get("USG_YN"), "");
							String cDelYn		= (String)ObjectUtils.defaultIfNull(pMap.get("DEL_YN"), "");
							
							//정보가 다를 경우만 업데이트
							if(!deptCd.equals(cDeptCd) || !rspofCd.equals(cRspofCd) || !cellPhoneNo.equals(cCellPhoneNo) || !email.equals(cEmail) || !userEngName.equals(cUserEngName) || !usgYn.equals(cUsgYn) || !delYn.equals(cDelYn))
							{
								try{
									sysRfcDAO.updateUserInfoByIF(pMap);
									cntSucc++;	
								}catch(Exception e){
									cntFail++;
								}
							}
						}
					}
				}
			}
		}catch(Exception e){
			cntFail++;
		}
		
		if(cntFail > 0){
			paramMap.put("RESULT", "F");
		}else
		{
			paramMap.put("RESULT", "S");
		}
		
		paramMap.put("SUCC_CNT",	cntSucc);
		paramMap.put("FAIL_CNT",	cntFail);
		paramMap.put("TOTAL_CNT",	cntTotal);
		
		return paramMap;
	}
	
	/**
	 * 부서정보 수신
	 * @param paramMap
	 * @return
	 * @throws ServiceException
	 * @throws Exception
	 */
	public Map<String, Object> receiveDEPTInfoByBatch(Map<String, Object> paramMap) throws ServiceException, Exception
	{
		String procId 	= DateUtil.getCurrentDateTimeAsString()+StringUtil.getRandomStr(10);
		
		int cntSucc = 0;
		int cntFail = 0;
		int cntTotal = 0;
		
		paramMap.put("COMP_CD"		, getCompCd());
		paramMap.put("PROC_ID"		, procId);
		
		paramMap.put("FUNC_NAME", "Z_HR_EAC_DEPT");
		
		try{
			Map<String, Object> resultMap = jcoProcessService.processJCoExecute(paramMap);
			
			if(!"[]".equals(resultMap.get("OUTTAB").toString()))
			{
				List<Map<String, Object>> resultList = (List<Map<String, Object>>) resultMap.get("OUTTAB");
				cntTotal += resultList.size();
				
				if(resultList.size() > 0)
				{
					for(int i = 0 ; i < resultList.size() ; i ++)
					{
						Map<String, Object> resMap	= resultList.get(i);
						Map<String, Object> pMap	= new HashMap<String, Object>();
						
						//I/F 로그 추가.
						sysRfcDAO.insertDeptIfInfo(resMap);
						
						pMap.put("DEPT_CD",			resMap.get("DEPT_CD"));				/* 부서코드 */
						pMap.put("DEPT_NAME",		resMap.get("DEPT_NM"));				/* 부서명 */
						pMap.put("UP_DEPT_CD",		resMap.get("PARENT_DEPT"));			/* 상위부서코드 */
						pMap.put("COMP_CD",			resMap.get("BUKRS"));				/* 회사코드 */
						pMap.put("HAS_CHILD_YN",	resMap.get("CHILD_FLAG"));			/* 하위부서여부 */
						pMap.put("DEL_YN",			resMap.get("DEL_FLAG"));			/* 삭제여부 */
						
						//T_DEPT 테이블에 데이터 확인.
						int cnt = sysRfcDAO.selectDeptInfoExist(pMap);
						
						//데이터가 없을 경우
						if(cnt == 0)
						{
							try{
								sysRfcDAO.insertDeptInfoByIF(pMap);
								cntSucc++;
							}catch(Exception e){
								cntFail++;
							}
						}
						//데이터가 있을 경우
						else
						{
							//데이터 비교 후 UPDATE한다.
							Map<String, Object> deptMap = sysRfcDAO.selectDetailDeptInfo(pMap);
							String deptName		= (String)ObjectUtils.defaultIfNull(deptMap.get("DEPT_NAME"), "");
							String upDeptCd		= (String)ObjectUtils.defaultIfNull(deptMap.get("UP_DEPT_CD"), "");
							String hasChildYn	= (String)ObjectUtils.defaultIfNull(deptMap.get("HAS_CHILD_YN"), "");
							String delYn		= (String)ObjectUtils.defaultIfNull(deptMap.get("DEL_YN"), "");
							
							String cDeptName	= (String)ObjectUtils.defaultIfNull(pMap.get("DEPT_NAME"), "");
							String cUpDeptCd	= (String)ObjectUtils.defaultIfNull(pMap.get("UP_DEPT_CD"), "");
							String cHasChildYn	= (String)ObjectUtils.defaultIfNull(pMap.get("HAS_CHILD_YN"), "");
							String cDelYn		= (String)ObjectUtils.defaultIfNull(pMap.get("DEL_YN"), "");
							
							//정보가 다를 경우만 업데이트
							if(!deptName.equals(cDeptName) || !upDeptCd.equals(cUpDeptCd) || !hasChildYn.equals(cHasChildYn) || !delYn.equals(cDelYn))
							{
								try{
									sysRfcDAO.updateDeptInfoByIF(pMap);
									cntSucc++;
								}catch(Exception e){
									cntFail++;
								}
							}
						}
					}
				}
			}
		}catch(Exception e){
			cntFail++;
		}
		
		if(cntFail > 0){
			paramMap.put("RESULT", "F");
		}else
		{
			paramMap.put("RESULT", "S");
		}
		
		paramMap.put("SUCC_CNT",	cntSucc);
		paramMap.put("FAIL_CNT",	cntFail);
		paramMap.put("TOTAL_CNT",	cntTotal);
		
		return paramMap;
	}
	
}
