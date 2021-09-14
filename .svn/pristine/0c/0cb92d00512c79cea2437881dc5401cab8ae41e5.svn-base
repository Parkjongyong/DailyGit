package com.app.ildong.common.util;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang3.StringUtils;


/**
 * 문자열관련 Utils 
 * @author P056583
 *
 */
public class StringUtil {

	
	
	/**
	 * 빈문자열 체크
	 */
	public static boolean isEmpty(String value)
	{
		if (value == null || "".equals(value.trim())) {return true;}
		else {return false;}
	}
	
	public static boolean isEmpty(Object value) {
        return isEmpty(toStr(value));
    }
	
    public static String toStr(Object obj) {
        return toStr(obj, null, null);
    }
    
    /**
     * If string is null or empty string, return false. <br>
     * If not, return true.
     * <p>
     * <pre>
     * StringUtil.isNotEmpty('')        = false
     * StringUtil.isNotEmpty(null)      = false
     * StringUtil.isNotEmpty('abc')     = true
     * </pre>
     *
     * @param str original String
     * @return which empty string or not.
     */
    public static boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }

    public static String toStr(Object arg, String fromCharEncoding, String toCharEncoding) {
        if (null == arg) return "";
        else {
            if (arg instanceof String) {
                String str = arg.toString();
                if (null == toCharEncoding) {
                    return str;
                } else {
                    try {
                        if (null == fromCharEncoding) {
                            return new String(str.getBytes(), toCharEncoding);
                        } else {
                            return new String(str.getBytes(fromCharEncoding), toCharEncoding);
                        }
                    } catch (UnsupportedEncodingException e) {
                        return str;
                    }
                }
            } else {
                return arg.toString();
            }
        }
    }
	
	/**
	 * String을 double로 변환(널일때는 0으로 변환한다.)
	 * toDouble("123456789") => 123456789
	 */
	public static double toDouble(String value)
	{
		if (isEmpty(value)) {return 0;}
		else
		{
			value = replace(value.trim(), ",", "");
			return (Double.parseDouble(value));
		}
	}
	
	
	/**
	 * String을 long 변환(널일때는 0으로 변환한다.)
	 * toDouble("123456789") => 123456789
	 */
	public static long toLong(String value)
	{
		if (isEmpty(value)) {return 0;}
		else
		{
			value = replace(value.trim(), ",", "");
			return (Long.parseLong(value));
		}
	}
	
	/**
	 * String을 int 변환(널일때는 0으로 변환한다.)
	 * toInt("123456789") => 123456789
	 */
	public static int toInt(String value)
	{
		if (isEmpty(value)) {return 0;}
		else
		{
			value = replace(value.trim(), ",", "");
			return (Integer.parseInt(value));
		}
	}
	
	
	/**
	 * double형을 String형으로 변환(포맷없음)
	 */
	public static String toString(double val)
	{
		return (new Double(val).toString());
	}
	
	/**
	 * 바이트 배열을 스트링으로 변환한다.
	 * @param b
	 * @param start
	 * @param end
	 * @return
	 */
	public static String toString(byte[] b , int start , int end){	
		
		if(length(b) < start || length(b)==0 )
			return "";
		else if(length(b) < start+end)
			return new String(b,start,length(b));
		else
			return new String(b,start,end);
	}
	
	
	
	
	/**
	 * oldString에서 from 문자열을 to 문자열로 바꾸어 반환
	 */
	public static String replace(String oldString, String from, String to)
	{
		String newString = oldString;
		int offset = 0;

		while((offset = newString.indexOf(from, offset)) > -1)
		{
			StringBuffer temp = new StringBuffer(newString.substring(0, offset));
			temp.append(to);
			temp.append(newString.substring(offset+from.length()));
			newString = temp.toString();
			offset++;
		}

		return newString;
	}
	
	

	
	/**
	 * 바이트 배열 길이를 리턴
	 * 
	 * null 이면 0
	 * 
	 * @param b
	 * @return
	 */
	public static int length(byte[] b){
		if(b == null)
			return 0;
		else
			return b.length;
	}
	
	/**
	 * 문자열 길이를 리턴
	 * null 이면 0 
	 * 
	 * @param s
	 * @return
	 */
	public static int length(String s){
		if(s == null)
			return 0;	
		else
			return s.length();	
	}
	
	
	/**
	 * 시간포맷 적용
	 * getTimeMask("121050", ":") => "12:10:50"
	 */
	public static String getTimeMask(String time, String seperator)
	{
		String result = "";

		if (time == null || (time.trim().length() == 0 ) ) {
			result = "";
		} else {
			if (time != null && time.length() >= 6) {
				result = time.substring(0, 2) + seperator + time.substring(2, 4) + seperator + time.substring(4, 6);
			} else {
				result = time;
			}
		}
		return result;
	}
	
	/**
	 * 날짜시간 포맷 적용(날짜와 시간 사이에 공백 삽입됨)
	 * getDateTimeMask("20110101101010", "-", ":") => "2011-01-01 10:10:10"
	 */
	public static String getDateTimeMask(String dateTime, String seperator, String sTimeFormat)
	{
		String result = "";

		if (dateTime == null || (dateTime.trim().length() == 0) ) {
			result = "";
		} else {
			if (dateTime != null && dateTime.length() >= 14) {
				result = dateTime.substring(0, 4) + seperator + dateTime.substring(4, 6) + seperator + dateTime.substring(6, 8);
				result += " " + dateTime.substring(8, 10) + sTimeFormat + dateTime.substring(10, 12) + sTimeFormat + dateTime.substring(12, 14);
			} else {
				result = dateTime;
			}
		}

		return result;
	}
	
	
	/**
	 * 날짜시간 포맷 적용(날짜와 시간 사이에 공백 삽입됨)
	 * getDateTimeMask("20110101101010", "-", ":") => "2011-01-01 10:10:10"
	 */
	public static String getDateMask(String dateTime, String seperator, String sTimeFormat)
	{
		String result = "";

		if (isEmpty(dateTime.trim())) {result = "";}
		else
		{
			if (dateTime != null && dateTime.length() >= 14)
			{
				result = dateTime.substring(0, 4) + seperator + dateTime.substring(4, 6) + seperator + dateTime.substring(6, 8);
			}
			else {result = dateTime;}
		}

		return result;
	}
		
	
	/**
	 * 두 개의 String값을 비교하여 같을 경우 원하는 값을 반환해 준다
	 * arg1, arg2 : 비교대상 문자열
	 * arg3 : 같을경우 리턴될 문자열
	 * arg4 : 다를경우 리턴될 문자열
	 */
	public static String compareString(String str1, String str2, String rtnSame, String rtnDiff)
	{
		str1 = nvl(str1, "");
		str2 = nvl(str2, "");

		if (str1.equals(str2)) {return rtnSame;}
		else {return rtnDiff;}
	}
	
	/**
	 * null String일 경우 원하는 문자열로 리턴
	 * nvl("null", "A") => "A"
	 */
	public static String nvl(String value, String replacement)
	{
		if (isEmpty(value)) {return replacement;}
		else {return value;}
	}
	
	public static String nvl(Object object, String replacement) 
	{	
		String rtnValue = replacement;
		
		if (null==object) return rtnValue;
		if ("".equals(object)) return rtnValue;
		
		try {
			rtnValue = (String)object;
		} catch (Exception e) {
			rtnValue = replacement;
		}
		
		return rtnValue;
	}
	
	
	/**
	 * 두 날짜 사이의 Gap일수 계산
	 */
	public static double getDateGap(String sStartDate, String sEndDate) throws Exception
	{
		double dStartDate = toDouble(getLongDate(sStartDate));
		double dEndDate = toDouble(getLongDate(sEndDate));

		return (dEndDate - dStartDate) / (24*(60*(60*1000)));

	}
	
	
	/**
	 * 해당날짜를 long 형으로 반환
	 */
	public static String getLongDate(String sDate) throws Exception
	{
		Calendar calendar = Calendar.getInstance();
		if (sDate.length() == 8)
		{
			int y = toInt(sDate.substring(0,4));
			int m = toInt(sDate.substring(4,6));
			int d = toInt(sDate.substring(6,8));
			calendar.set(y, m-1, d);
		}
		else if (sDate.length() > 8)
		{
			int y = toInt(sDate.substring(0,4));
			int m = toInt(sDate.substring(4,6));
			int d = toInt(sDate.substring(6,8));
			int h = toInt(sDate.substring(8,10));
			int mi = toInt(sDate.substring(10,12));
			int s = toInt(sDate.substring(12,14));
			calendar.set(y, m-1, d, h, mi, s);
		}

		return toString(calendar.getTimeInMillis());
	}
	
	
	/**
	 * 넘겨준 Object가 null이거나 Empty이면 대체 문자로 변경 함.
	 * @param source
	 * @param alernative
	 * @return
	 */
	public static String nvlObjectEmpty(Object source, String alernative){
		if (null == source) {
			return alernative;
		}
		else if("".equals(source)){
			return alernative;
		}
		
		return String.valueOf(source);
	}  
	
	/**
	  String 을 byte 길이 만큼 자르기. 
	 
	  @param s 짜르고 싶은 문장
	  @param i 짜르고 싶은 길이
	   @return 일정길이로 짜른 문자열을 반환한다.
	 */
	 public static String strCutKorByte(String str, int byteLength) {
	  
		int length = str.length();
		int retLength = 0;
		int tempSize = 0;
		int asc;
		for (int i = 1; i <= length; i++) {
			asc = (int) str.charAt(i - 1);
			if (asc > 127) {
				if (byteLength >= tempSize + 2) {
					tempSize += 2;
					retLength++;
				} else {
					return str.substring(0, retLength);
				}
			} else {
				if (byteLength > tempSize) {
					tempSize++;
					retLength++;
				}
			}
		}
		return str.substring(0, retLength);
	 }

	 
	 
	 /**
	  * val 가 String 객체이면 String 배열로 return 한다
	  * null 일 경우 null로 return
	  * 
	  * @param val
	  * @return
	  */
	 public static Object toStringArray(Object val){
		 
		 if( val == null) {
			 return val;
		 }
		 
		 if( val instanceof String) {
			 if( isEmpty( (String)val)) {
				 return null;
			 }
			 String[] valArray = new String[]{ (String)val};
			
			 return valArray;
		 } else {
			 return val;
		 }
	 }
	 
	public static String makeFormat(String format, String value) {
		int i = 0;
		int j = 0;
		String retn = "";

		if (format == null)
			return "";
		if (value == null)
			return "";
		if (format.length() == 0)
			return "";
		if (value.length() == 0)
			return "";

		while ((j < format.length()) && (i < value.length())) {
			if (format.charAt(j) == '#') {
				retn = retn + value.charAt(i);
				++i;
				++j;
			}
			retn = retn + format.charAt(j);
			++j;
		}

		return retn;
	}
	
	/**
	 * 지급조건을 만들어서 return해줌.
	 * gubun : ITEM(장비/물품)
	 * 		 , CNST(공사)
	 * 		 , SRVC(용역)
	 *		 , ALL
	 * @param paramMap, gubun
	 * @return
	 */
	public static String makePayTerms(Map<String, Object> paramMap, String gubun){
		StringBuffer sbPayTerms = new StringBuffer();
		
		if(paramMap != null)
		{
			if(paramMap.get("CHARGE_COND_ITEM") != null)
			{
				//장비/물품일 경우
				if("Y".equals(paramMap.get("CHARGE_COND_ITEM")) && ("ITEM".equals(gubun) || "ALL".equals(gubun)))
				{
					sbPayTerms.append("[장비/물품]");
					
					for(int i = 0; i <= 4; i++)
					{
						if(!"0".equals(String.valueOf(ObjectUtils.defaultIfNull(paramMap.get("CHARGE_ITEM_00"+i), "0"))))
						{
							if(i == 0){
								if(!"[장비/물품]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 선급금 : ");
								}
								else
								{
									sbPayTerms.append("선급금 : ");
								}
							}
							if(i == 1){
								if(!"[장비/물품]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 납품시 : ");
								}
								else
								{
									sbPayTerms.append("납품시 : ");
								}
							}
							if(i == 2){
								if(!"[장비/물품]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 개통시 : ");	
								}
								else
								{
									sbPayTerms.append("개통시 : ");
								}
								
							}
							if(i == 3){
								if(!"[장비/물품]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 최종인수시 : ");
								}
								else
								{
									sbPayTerms.append("최종인수시 : ");	
								}
							}
							if(i == 4){
								if(!"[장비/물품]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 유보금 : ");
								}
								else
								{
									sbPayTerms.append("유보금 : ");	
								}
							}
							sbPayTerms.append(paramMap.get("CHARGE_ITEM_00"+i).toString()).append("%");
						}
					}
					//GUBUN값이 ITEM일 경우 ITEM항목의 지급조건만 return.
					if("ITEM".equals(gubun))
					{
						return sbPayTerms.toString();
					}
				}
			}
			if(paramMap.get("CHARGE_COND_CNST") != null)
			{
				//공사일 경우
				if("Y".equals(paramMap.get("CHARGE_COND_CNST")) && ("CNST".equals(gubun) || "ALL".equals(gubun)))
				{
					sbPayTerms.append("[공사]");
					
					for(int i = 1; i <= 5; i++)
					{
						if(!"0".equals(String.valueOf(ObjectUtils.defaultIfNull(paramMap.get("CHARGE_CNST_00"+i), "0"))))
						{
							if(i == 1){
								if(!"[공사]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 선금 : ");
								}
								else
								{
									sbPayTerms.append("선금 : ");
								}
							}
							if(i == 2){
								if(!"[공사]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 중도금확정 : ");	
								}
								else
								{
									sbPayTerms.append("중도금확정 : ");
								}
								
							}
							if(i == 3){
								if(!"[공사]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 중도금기성 : ");
								}
								else
								{
									sbPayTerms.append("중도금기성 : ");	
								}
							}
							if(i == 4){
								if(!"[공사]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 잔금 : ");
								}
								else
								{
									sbPayTerms.append("잔금 : ");	
								}
							}
							if(i == 5){
								if(!"[공사]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 유보금 : ");
								}
								else
								{
									sbPayTerms.append("유보금 : ");	
								}
							}
							sbPayTerms.append(paramMap.get("CHARGE_CNST_00"+i).toString()).append("%");
						}
					}
					
					//GUBUN값이 CNST일 경우 공사항목의 지급조건만 return.
					if("CNST".equals(gubun))
					{
						return sbPayTerms.toString();
					}
				}
			}
			
			if(paramMap.get("CHARGE_COND_SRVC") != null)
			{
				//용역일 경우
				if("Y".equals(paramMap.get("CHARGE_COND_SRVC")) && ("SRVC".equals(gubun) || "ALL".equals(gubun)))
				{
					sbPayTerms.append("[용역]");
					
					for(int i = 1; i <= 5; i++)
					{
						if(!"0".equals(String.valueOf(ObjectUtils.defaultIfNull(paramMap.get("CHARGE_SRVC_00"+i), "0"))))
						{
							if(i == 1){
								if(!"[용역]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 선금 : ");
								}
								else
								{
									sbPayTerms.append("선금 : ");
								}
							}
							if(i == 2){
								if(!"[용역]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 중도금확정 : ");	
								}
								else
								{
									sbPayTerms.append("중도금확정 : ");
								}
								
							}
							if(i == 3){
								if(!"[용역]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 중도금기성 : ");
								}
								else
								{
									sbPayTerms.append("중도금기성 : ");	
								}
							}
							if(i == 4){
								if(!"[용역]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 잔금 : ");
								}
								else
								{
									sbPayTerms.append("잔금 : ");	
								}
							}
							if(i == 5){
								if(!"[용역]".equals(sbPayTerms.toString()))
								{
									sbPayTerms.append(", 유보금 : ");
								}
								else
								{
									sbPayTerms.append("유보금 : ");	
								}
							}
							sbPayTerms.append(paramMap.get("CHARGE_SRVC_00"+i).toString()).append("%");
						}
					}
					
					//GUBUN값이 SRVC일 경우 용역항목의 지급조건만 return.
					if("SRVC".equals(gubun))
					{
						return sbPayTerms.toString();
					}
				}
			}
		}
		return sbPayTerms.toString();
	}
	
	public static String getRandomStr(int size) {
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < size; i++) {
		    int rIndex = rnd.nextInt(3);
		    switch (rIndex) {
		    case 0:
		        // a-z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        // A-Z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
		        break;
		    case 2:
		        // 0-9
		        temp.append((rnd.nextInt(10)));
		        break;
		    }
		}

		return temp.toString();
	}
	
	/**
	 * 문자열이 null일때 ""로 바꾸어준다. NullPointerException
	 */
	static public String getNull(String str){
		return getNull(str, "");
	}	 
		 
	/**
	 * 문자열이 null일때 ""로 바꾸어준다. NullPointerException
	 */	
	static public String getNull(String str, String strDefault){
		if (str == null )
			str = strDefault;
		return str;
	}
	
	static public String getNullOrWhiteSpace(String str, String strRep)
    {
        if(str != null && !str.equals("")) return str;
        else return strRep;
    }
	
	/**
     * <p>오라클의 decode 함수와 동일한 기능을 가진 메서드이다.
     * <code>sourStr</code>과 <code>compareStr</code>의 값이 같으면
     * <code>returStr</code>을 반환하며, 다르면  <code>defaultStr</code>을 반환한다.
     * </p>
     * <p>
     * <pre>
     * StringUtil.decode(null, null, "foo", "bar")= "foo"
     * StringUtil.decode("", null, "foo", "bar") = "bar"
     * StringUtil.decode(null, "", "foo", "bar") = "bar"
     * StringUtil.decode("하이", "하이", null, "bar") = null
     * StringUtil.decode("하이", "하이  ", "foo", null) = null
     * StringUtil.decode("하이", "하이", "foo", "bar") = "foo"
     * StringUtil.decode("하이", "하이  ", "foo", "bar") = "bar"
     * </pre>
     *
     * @param sourceStr  비교할 문자열
     * @param compareStr 비교 대상 문자열
     * @param returnStr  sourceStr와 compareStr의 값이 같을 때 반환할 문자열
     * @param defaultStr sourceStr와 compareStr의 값이 다를 때 반환할 문자열
     * @return sourceStr과 compareStr의 값이 동일(equal)할 때 returnStr을 반환하며,
     * 다르면 defaultStr을 반환한다.
     */
    public static String decode(String sourceStr, String compareStr, String returnStr, String defaultStr) {
        if (sourceStr == null && compareStr == null) {
            return returnStr;
        }

        if (sourceStr == null && compareStr != null) {
            return defaultStr;
        }

        if (sourceStr.trim().equals(compareStr)) {
            return returnStr;
        }

        return defaultStr;
    }
    
    /**
     * 객체가 null인지 확인하고 null인 경우 "" 로 바꾸는 메서드
     *
     * @param object 원본 객체
     * @return resultVal 문자열
     */
    public static String isNullToString(Object object) {
        String string = "";

        if (object != null) {
            string = object.toString().trim();
        }

        return string;
    }


	/**
	 * 문자열값 소수점 이하 절삭
	 */
	public static String trunc(String s)
	{
		if(isEmpty(s)) return "";
		return s.substring(0, s.indexOf(".") == -1 ?  s.length() : s.indexOf("."));
	}	
	
    /**
     * java to html 치환
     *
     * @param String 원본 객체
     * @return resultVal 문자열
     */
    public static String java2html(String s){
        if (s == null)
            return null;
        StringBuffer buf = new StringBuffer();
        char[] c = s.toCharArray();
        int len = c.length;
        for (int i = 0; i < len; i++) {
            if (c[i] == '&')
                buf.append("&amp;");
            else if (c[i] == '<')
                buf.append("&lt;");
            else if (c[i] == '>')
                buf.append("&gt;");
            else if (c[i] == '"')
                buf.append("&quot;");
            else if (c[i] == '\'')
                buf.append("&#039;");
//            else if (c[i] == '“')
//                buf.append("&ldquo;");
//            else if (c[i] == '”')
//                buf.append("&rdquo;");
//            else if (c[i] == '™')   // TM
//                buf.append("&trade;");
            else
                buf.append(c[i]);
        }
        return buf.toString();
    }
    
    
   /**
    * 숫자 한글로 변경 
    * @param money
    * @return
    */
    public static String convertHangul(String money){
    	
    	String[] han1 = {"","일","이","삼","사","오","육","칠","팔","구"}; 
    	String[] han2 = {"","십","백","천"}; 
    	String[] han3 = {"","만","억","조","경"}; 
    	
    	StringBuffer result = new StringBuffer();
    	
    	int len = money.length();
    	
    	for(int i=len-1; i>=0; i--){
    		
    		result.append(han1[Integer.parseInt(money.substring(len-i-1, len-i))]);
    		
    		if(Integer.parseInt(money.substring(len-i-1, len-i)) > 0)
    			result.append(han2[i%4]);
    		if(i%4 == 0)
    				result.append(han3[i/4]);}
    	return result.toString(); 
    }

    
    /**
     * 대상문자열(strTarget)에서 구분문자열(strDelim)을 기준으로 문자열을 분리하여
     * 각 분리된 문자열을 배열에 할당하여 반환한다.
     *
     * @param strTarget 분리 대상 문자열
     * @param strDelim 구분시킬 문자열로서 결과 문자열에는 포함되지 않는다.
     * @param bContainNull 구분되어진 문자열중 공백문자열의 포함여부.
     *                     true : 포함, false : 포함하지 않음.
     * @return 분리된 문자열을 순서대로 배열에 격납하여 반환한다.
     * @exception   Exception
     */
    public static String[] split(String strTarget, String strDelim, boolean bContainNull) throws Exception{
    	
    	
        // StringTokenizer는 구분자가 연속으로 중첩되어 있을 경우 공백 문자열을 반환하지 않음.
        // 따라서 아래와 같이 작성함.
        int index = 0;
        String[] resultStrArray = null;

        try {

            resultStrArray = new String[search(strTarget, strDelim) + 1];
            String strCheck = new String(strTarget);
            while (strCheck.length() != 0) {
                int begin = strCheck.indexOf(strDelim);
                if (begin == -1) {
                    resultStrArray[index] = strCheck;
                    break;
                } else {
                    int end = begin + strDelim.length();
                    if (bContainNull) {
                        resultStrArray[index++] = strCheck.substring(0, begin);
                    }
                    strCheck = strCheck.substring(end);
                    if (strCheck.length() == 0 && bContainNull) {
                        resultStrArray[index] = strCheck;
                        break;
                    }
                }
            }

        } catch (Exception e) {
        	//throw new Exception("[StringUtil][split]" + e.getMessage(), e);
		}
        return resultStrArray;
    	
    }
    
    /**
     * 대상문자열(strTarget)에서 지정문자열(strSearch)이 검색된 횟수를,
     * 지정문자열이 없으면 0 을 반환한다.
     *
     * @param strTarget 대상문자열
     * @param strSearch 검색할 문자열
     * @return 지정문자열이 검색되었으면 검색된 횟수를, 검색되지 않았으면 0 을 반환한다.
     * @exception   Exception
     */
    public static int search(String strTarget, String strSearch) throws Exception{
        int result = 0;
        try {

            String strCheck = new String(strTarget);
            for (int i = 0; i < strTarget.length();) {
                int loc = strCheck.indexOf(strSearch);
                if (loc == -1) {
                    break;
                } else {
                    result++;
                    i = loc + strSearch.length();
                    strCheck = strCheck.substring(i);
                }
            }

        } catch (Exception e) {
            //throw new Exception("[StringUtil][search]" + e.getMessage(), e);
        }
        return result;
    }
    
    public static String[] splitByLegnth(String text, int size) {
    	List<String> parts = new ArrayList<>();
    	
        int length = text.length();
        for (int i = 0; i < length; i += size) {
            parts.add(text.substring(i, Math.min(length, i + size)));
        }
        return parts.toArray(new String[0]);
    }
}
