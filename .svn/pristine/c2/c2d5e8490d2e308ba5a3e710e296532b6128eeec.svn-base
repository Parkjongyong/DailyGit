package com.app.ildong.common.crypt;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.app.ildong.common.crypt.DigestUtil;
import com.app.ildong.common.model.mvc.BaseController;
import com.app.ildong.common.util.PropertiesUtil;

public class test  extends BaseController {
	
	
	@Autowired
    private static DigestUtil digestUtil;
	
	
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println(digestUtil.digest("paruadmin@01", "sysadmin"));
		//GeP98U9aMJJ1CK6x6URSPqdFL5kFk0gJ9DgYsnayck0=
//		System.out.println(digestUtil.digest("1111", "user1"));
		System.out.println("demo : " + digestUtil.digest("demo", "demo"));
		System.out.println("demo1 : " + digestUtil.digest("demo", "demo1"));
		System.out.println("VENDOR01 : " + digestUtil.digest("demo", "VENDOR01"));
		System.out.println("VENDOR02 : " + digestUtil.digest("demo", "VENDOR02"));
		
		//VENDOR02
		//randomPassword   : 
		//x79bKLOWzWSNWPcGRqF8zqB2fqmGxTyn79Wvp0UQ3rs=
		//x79bKLOWzWSNWPcGRqF8zqB2fqmGxTyn79Wvp0UQ3rs=
		//8fyvYTz7OldVX3NNtYeB6BpXy9ZEdHcKaIWOYv1yFqw=
		
		System.out.println(StringUtils.leftPad("123456", 10, "0"));
		/*
		 * 
		 * 
		 
		 http://www.i-supply.co.kr/
		★관리자 - ID : sysadmin, PW : paruadmin@01
		
		사용자 - ID : demo, PW : demo
		사용자 - ID : demo1, PW : demo
		
		
		http://partner.i-supply.co.kr/
		사용자 - ID : vendor01, PW : demo
		사용자 - ID : vendor02, PW : demo

		 
		 
		 
		 * 
		 * 
		 */

	}

}
