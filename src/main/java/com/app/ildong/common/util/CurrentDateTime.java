package com.app.ildong.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public final class CurrentDateTime{

	public CurrentDateTime(){

		super();
	}

	public static String getDate(){

		Calendar cal = Calendar.getInstance();
		int yy = cal.get(Calendar.YEAR);
		int mo = cal.get(Calendar.MONTH) + 1;
		int dd = cal.get(Calendar.DAY_OF_MONTH);

		String yyy = null;
		String mmo = null;
		String ddd = null;

		yyy = "" + yy;
		if(mo < 10){
			mmo = "0" + mo;
		}else{
			mmo = "" + mo;
		}
		if(dd < 10){
			ddd = "0" + dd;
		}else{
			ddd = "" + dd;
		}

		String addDate = "" + yyy + mmo + ddd;
		return addDate;
	}

	public static String getTime(){

		Calendar cal = Calendar.getInstance();
		int hh = cal.get(Calendar.HOUR_OF_DAY);
		int mm = cal.get(Calendar.MINUTE);
		int ss = cal.get(Calendar.SECOND);

		String hhh = null;
		String mmm = null;
		String sss = null;

		if(hh < 10){
			hhh = "0" + hh;
		}else{
			hhh = "" + hh;
		}
		if(mm < 10){
			mmm = "0" + mm;
		}else{
			mmm = "" + mm;
		}
		if(ss < 10){
			sss = "0" + ss;
		}else{
			sss = "" + ss;
		}

		String addTime = "" + hhh + mmm + sss;
		return addTime;
	}

	public static String getDatetime(){

		String temp = getDate() + ":" + getTime();
		return temp;
	}

	public static String getGtmTimeZoneToLocalTimeZone(String gmtTimeStamp){

		String localTimeStamp = "";
		Calendar cal = null;
		Date gmtDateTime = null;

		try{

			gmtTimeStamp = gmtTimeStamp.replaceAll("[^0-9]", "");
			cal = Calendar.getInstance();
			gmtDateTime = new SimpleDateFormat("yyMMddHHmmss").parse(gmtTimeStamp);
			cal.setTime(gmtDateTime);
			cal.add(Calendar.HOUR, 9);
			localTimeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(cal.getTime());

		}catch(ParseException e){
			e.printStackTrace();
		}

		return localTimeStamp;

	}

}
