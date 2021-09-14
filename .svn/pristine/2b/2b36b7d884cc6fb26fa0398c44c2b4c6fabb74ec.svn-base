package com.app.ildong.common.util;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;



/**
 * 문자열관련 Utils 
 * @author P056583
 *
 */
public class StringUtilEx {

	
	public final static String DEFAULT_DATE_FORMAT = "yyyyMMdd";
    public final static String SLASH_DATE_FORMAT = "yyyy/MM/dd";
    public final static String BAR_DATE_FORMAT = "yyyy-MM-dd";
    
    public final static String JUMIN_FORMAT = "XXXXXX-XXXXXXX";
    public final static String POST_FORMAT  = "XXX-XXX";
    public final static String PHONE_FORMAT = "XXX-XXXX-XXXX"; 

    
    /**
     * 초기 스트링 셋팅 값 설정
     * @param str       비교값
     * @param value     기본값
     * @return
     */
    public static String defaultValue(String str, String value) {
        //if (str == null || "".equals(str) || "null".equals(str) || str == "null") {
        if (str == null || "".equals(str) || "null".equals(str)) {    
            str = value;
        }
        return str;
    }
    
    /**
     * 초기 스트링 셋팅 값 설정 ("")
     * @param str       비교값
     * @param value     기본값
     * @return
     */
    public static String defaultValue(String str) {
        //if (str == null || "".equals(str) || "null".equals(str) || str == "null") {
        if (str == null || "".equals(str) || "null".equals(str)) {
            str = "";
        }
        return str;
    }
    
    /**
     * 초기 Hidden Object 셋팅 값 설정
     * @param str       비교값
     * @param value     기본값
     * @return
     */
    public static String defaultHidden(String str, String name) { 
        //if (str == null || "null".equals(str) || str == "null") {
        if (str == null || "null".equals(str)) {
            str = "";
        } else {
            str = "<input type=\"hidden\" name=\"" + name + "\"   value=\"" + str + "\" />";
        }
        
        return str;
    }
    
    /**
     * 브라우져의 정보저장을 막기위한 파라미터 수단
     * @return
     */
    public static String getDummy(){
        String retVal = "";
        Calendar now = Calendar.getInstance();
        retVal += now.get(Calendar.YEAR);
        retVal += now.get(Calendar.MONTH) + 1;
        retVal += now.get(Calendar.DAY_OF_MONTH);
        retVal += now.get(Calendar.HOUR_OF_DAY);
        retVal += now.get(Calendar.MINUTE);
        retVal += now.get(Calendar.SECOND);
        
        return retVal;
    }
        
    
    //--------------------------------------------------------------------------------
    //----------------------------------날짜관련--------------------------------------
    //--------------------------------------------------------------------------------    
    
    /**
     * 현재 날짜 함수
     * @return
     */       
    public static String getDate(){
        Date toDay = Calendar.getInstance().getTime();        
        SimpleDateFormat formatter = new SimpleDateFormat(DEFAULT_DATE_FORMAT);
        return formatter.format(toDay);
    }
    
    /**
     * 현재 날짜 함수
     * @return
     */       
    public static String getNowDate(){
        Date toDay = Calendar.getInstance().getTime();        
        SimpleDateFormat formatter = new SimpleDateFormat(BAR_DATE_FORMAT);
        return formatter.format(toDay);
    }

    /**
     * 현재일 +Day 함수
     * @return
     */       
    public static String getNowDate(int iCnt){
        Calendar toDay = Calendar.getInstance(); 
        toDay.add(Calendar.DATE, iCnt);        
        SimpleDateFormat formatter = new SimpleDateFormat(BAR_DATE_FORMAT); 
        return formatter.format(toDay.getTime()); 
    }
    
    /**
     * 현재 월의 1일 함수
     * @return
     */       
    public static String getNowDateFirst(){
        return getNowDate().substring(0, 8) + "01";
    }
    
    /**
     * 현재 날짜+시간 함수
     * @return
     */    
    public static String getNowDateTime(){       
        Date now = Calendar.getInstance().getTime();        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        return formatter.format(now);
    }   
    
    /**
     * 현재 날짜+시간(전체) 함수
     * @return
     */    
    public static String getTimeStamp(){       
        Date now = Calendar.getInstance().getTime();        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssS");
        
        String rtnVal = formatter.format(now);
        if(rtnVal.length() < 17){
            String tmpVal = (rtnVal.length() == 15) ? "00" : "0";
            rtnVal = rtnVal.substring(0, 14) + tmpVal + rtnVal.substring(14);
        }
        
        return rtnVal;
    }     
    
    /**
     * yyyymmddhhmmss 타입의 시간 정보가 하루 전인지 체크
     * @param str_date
     * @return
     */
    public static boolean dateDiff(String str_date){
        boolean ret_val = false;
        str_date = defaultValue(str_date);
        
        Calendar tmp_calendar = string2Calendar(str_date);
        Calendar beforeOneDay = Calendar.getInstance();
        beforeOneDay.add(Calendar.DAY_OF_MONTH, -1); 
        
        ret_val = beforeOneDay.getTimeInMillis() > tmp_calendar.getTimeInMillis() ? false : true;
        
        return ret_val;
    }
    
    /**
     * 문자열을 Calendar객체로 변환 반환한다.
     * @param date 입력되는 날짜.
     * @return 변환된 Calendar객체
     */
    private static Calendar string2Calendar(String date)
    {
        date = date.replaceAll("[-,]","");
        
        GregorianCalendar cal = new GregorianCalendar();
        
        if(date.length() >= 4)   cal.set(Calendar.YEAR, Integer.parseInt(date.substring(0, 4)));
        if(date.length() >= 6)   cal.set(Calendar.MONTH, Integer.parseInt(date.substring(4, 6)) - 1);
        if(date.length() >= 8)   cal.set(Calendar.DATE, Integer.parseInt(date.substring(6, 8)));
        if(date.length() >=10)  cal.set(Calendar.HOUR_OF_DAY, Integer.parseInt(date.substring(8, 10)));
        if(date.length() >=12)  cal.set(Calendar.MINUTE, Integer.parseInt(date.substring(10, 12)));
        if(date.length() >=14)  cal.set(Calendar.SECOND, Integer.parseInt(date.substring(12, 14)));
        
        return cal;
    }
    
    /**
     * String 값을 날짜형식으로 변환
     * @param
     * @return
     */    
    public static String string2DateTime(String date){       
        String rtnVal = defaultValue(date); 
        if(!"".equals(rtnVal)){
            if(date.length() >= 4) rtnVal  = date.substring(0, 4); 
            if(date.length() >= 6) rtnVal += "-" + date.substring(4, 6);  
            if(date.length() >= 8) rtnVal += "-" + date.substring(6, 8); 
            if(date.length() >=10) rtnVal += " " + date.substring(8, 10); 
            if(date.length() >=12) rtnVal += ":" + date.substring(10, 12); 
            if(date.length() >=14) rtnVal += ":" + date.substring(12, 14);
            if(date.length() >=17) rtnVal += "." + date.substring(14, 17); 
        }

        return rtnVal;
    }   
    
    /**
     * Describe :: return add day to date strings
     * @param   :: String date string
     *             int 더할 일수
     * @return  :: String 날짜 형식이 맞고, 존재하는 날짜일 때 일수 더하기
     *             형식이 잘못 되었거나 존재하지 않는 날짜: java.text.ParseException 발생
     */
    public static String addDays( String s, int day )  throws ParseException 
    {
        return addDays(s, day, "yyyyMMdd");
    }

    /**
     * Describe :: return add day to date strings with user defined format.
     * @param   :: String date string
     *             String 더할 일수
     *             format string representation of the date format. For example, "yyyy-MM-dd".
     * @return  :: int 날짜 형식이 맞고, 존재하는 날짜일 때 일수 더하기
     *             형식이 잘못 되었거나 존재하지 않는 날짜: java.text.ParseException 발생
     */
    public static String addDays( String s, int day, String format )  throws ParseException 
    {
        java.text.SimpleDateFormat formatter =
            new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
        java.util.Date date = check(s, format);

        date.setTime(date.getTime() + ((long)day * 1000 * 60 * 60 * 24));
        return formatter.format(date);
    }
    
    /**
     * Describe :: check date string validation with the default format "yyyyMMdd".
     * Return   :: date java.util.Date
     * @param   :: s date string you want to check with default format "yyyyMMdd".
     */
    public static java.util.Date check(String s) throws java.text.ParseException 
    {
        return check(s, "yyyyMMdd");
    }

    /**
     * Describe :: check date string validation with an user defined format.
     * Return   :: date java.util.Date
     * @param   :: s date string you want to check.
     *             format string representation of the date format. For example, "yyyy-MM-dd".
     */
    public static java.util.Date check( String s, String format) throws java.text.ParseException 
    {
        if ( s == null )
            throw new java.text.ParseException("date string to check is null", 0);

        if ( format == null )
            throw new java.text.ParseException("format string to check date is null", 0);

        java.text.SimpleDateFormat formatter =
            new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
        
        java.util.Date date = null;

        try {
            date = formatter.parse(s);
        }
        catch(java.text.ParseException e) {
            /*
            throw new java.text.ParseException(
                e.getMessage() + " with format \"" + format + "\"",
                e.getErrorOffset()
            );
            */
            throw new java.text.ParseException(" wrong date:\"" + s +
                "\" with format \"" + format + "\"", 0);
        }

        if ( ! formatter.format(date).equals(s) )
            throw new java.text.ParseException(
                "Out of bound date:\"" + s + "\" with format \"" + format + "\"",
                0
            );
        return date;
    }
    
    
    //--------------------------------------------------------------------------------
    //----------------------------------변환관련--------------------------------------
    //--------------------------------------------------------------------------------

    /**
     * toEncode_8859_1 
     * @param 
     * @return
     */    
    public static String toEncode_8859_1(String str){
        String retVal = "";
        try{
            retVal = new String(str.getBytes("EUC-KR"),"8859_1");
        }catch(UnsupportedEncodingException ex){
            retVal = "";
        }catch(Exception ex){
            retVal = "";
        }
        return retVal;
    }
    
    /**
     * db에서 데이터를 추출시 변환한다
     * @param
     * @return
     */
    public static String e2k(String str) {
        return fromDB(str);
    }
    
    /**
     * db 에 데이터를 저장시 변환한다
     * @param
     * @return
     */
    public static String k2e(String str) {
        return toDB(str);
    }    
    
    /**
     * db에서 문자열을 검색조건 변환한다.
     * @param
     * @return
     */
    public static String searchDB(String str) {  
        String retVal = defaultValue(str);  
        retVal = replace(retVal, "'", ""); 
        retVal = replace(retVal, "%", "");
        
        return retVal;
    }
    
    /**
     * db에서 문자열을 가져올시 변환한다.
     * @param
     * @return
     */
    public static String fromDB(String str) {
        String retVal = str;
        try {
            if (str != null) {
                retVal = new String(str.getBytes("KSC5601"), "8859_1");
            } else {
                retVal = "";
            }
        } catch (UnsupportedEncodingException e1) {
            retVal = "";
        }
        
        return retVal;
    }

    /**
     * db에 데이터를 저장시 변환한다.
     * @param
     * @return
     */
    public static String toDB(String str) {
        String retVal = str;        
        try {
            if (str != null) {
                retVal = new String(str.getBytes("8859_1"), "KSC5601");
            } else {
                retVal = "";
            }
        } catch (UnsupportedEncodingException e1) {
            retVal = "";
        }
        
        return retVal;
    }

    /**
     * 싱클쿼터를 올바르게 표현한다(client->db)
     * @param 
     * @return
     */
    public static String useSinglequot(String text) {
        int pos = 0;
        while ((pos = text.indexOf("\'", pos)) != -1) {
            String left = text.substring(0, pos);
            String rigth = text.substring(pos, text.length());
            text = left + "\'" + rigth;
            pos += 2;
        }
        return text;
    }

    /**
     * 싱클쿼터를 올바르게 표현한다(db->client)
     * @param 
     * @return
     */
    public static String convQuoto(String cstr) {
        StringBuffer sb = new StringBuffer(cstr);
        for (int i = 0; i < sb.length(); i++) {
            if (sb.charAt(i) == '\'') {
                sb.insert(++i, '\'');
            }
        }
        cstr = sb.toString();

        StringBuffer sb2 = new StringBuffer(cstr);
        for (int i = 0; i < sb2.length(); i++) {
            if (sb2.charAt(i) == '\"') {
                sb2.insert(++i, '\"');
            }
        }
        return sb2.toString();
    }
    
    /**
     * 숫자를 10자리 숫자로 보정한
     * @param
     * @return
     */
    public static String num2zero(int num) {
        String formatStr = "";
        formatStr = ((num < 10) ? "0" + num : "" + num);

        return formatStr;
    }

    /**
     * int 을 String으로 바꾼고, 
     * String의 크기가 주어진 크기보다 작으면 나머지는 "0"로 채운다.
     * @param
     * @return  
     */
    public static String cardString(int param, int size) {
        String ret = Integer.toString(param);
        int length = ret.length();

        for (int i = 0; i < size - length; i++) {
            ret = "0" + ret;
        }

        return ret;
    }

    /**
     * String의 크기가 주어진 크기보다 작으면 나머지는 "0"로 채운다.
     * @param
     * @return
     */
    public static String fillString(String str, int size) {
        String resutStr = "";
        for (int inx = 0; inx < size; inx++) {
            resutStr += str;
        }

        return resutStr;
    }  

    //--------------------------------------------------------------------------------
    //----------------------------------문자관련--------------------------------------
    //--------------------------------------------------------------------------------
    
    /**
     * 발생적 칼라를 얻는다
     * @param
     * @return
     */
    /*
    public static synchronized String getRandomColor() {
        String s = Integer.toHexString((int) (Math.random() * 256D));
        String s1 = Integer.toHexString((int) (Math.random() * 256D));
        String s2 = Integer.toHexString((int) (Math.random() * 256D));
        return "#" + s + s1 + s2;
    }
    */
    
    /**
     * 게시판등 검색어로 검색시 검색결과를 칼라로 표현시 사용한다.
     * @param
     * @return
     */
    public static String searchWord(String strSubject, String strKeyword) {
        String alterKey = "<font color=red>" + strKeyword + "</font>";
        alterKey = replace(strSubject, strKeyword, alterKey);
        return alterKey;
    }   
    
    /**
     * 두개의 문자열이 같은지를 비교한 결과를 반환합니다 비교시, 대소 문자를 따집니다
     * @param str1 비교할 첫번째 문자열
     * @param str2 비교할 두번째 문자열
     * @return boolean 비교결과
     */
    public static boolean equals(String str1, String str2) {
        return (str1 == null || str2 == null) ? false : str1.trim().equals(
                str2.trim());
    }

    /**
     * 두개의 문자열이 같은지를 비교한 결과를 반환합니다 비교시, 대소문자를 따지지 않습니다 
     * @param str1 비교할 첫번째 문자열
     * @param str2 비교할 두번째 문자열
     * @return boolean 비교결과 
     */
    public static boolean equalsIgnoreCase(String str1, String str2) {
        return (str1 == null || str2 == null) ? false : str1.trim()
                .equalsIgnoreCase(str2.trim());
    }    

    /**
     * 문자열 내의 특정한 문자열을 모두 지정한 다른 문자열로 바꾼다. 원본 String 이 null 일 경우에는 null 을 반환한다.
     * StringBuffer 를 이용하였으므로 이전의 String 을 이용한 것 보다 월등히 속도가 빠르다. (약 50 ~ 60 배)
     *
     * 사용 예:<BR>
     *
     * 1. 게시판에서 HTML 태그가 안 먹히게 할려면
     *
     * String str = "
     * <TD>HTML Tag Free Test</TD>"; str = replace(str, "&", "&amp;"); str =
     * replace(str, " <", "&lt;");
     *
     * 2. ' 가 포한된 글을 DB 에 넣을려면
     *
     * String str2 = "I don't know."; str2 = replace(str2, "'", "''");
     *
     * @param String
     *            src 원본 String
     * @param String
     *            oldstr 원본 String 내의 바꾸기 전 문자열
     * @param String
     *            newstr 바꾼 후 문자열
     * @return String 치환이 끝난 문자열
     *
     */
    public static String replace(String src, String oldstr, String newstr) {
        if (src == null) {
            return null;
        }

        StringBuffer dest = new StringBuffer("");
        int len = oldstr.length();
        int srclen = src.length();
        int pos = 0;
        int oldpos = 0;

        while ((pos = src.indexOf(oldstr, oldpos)) >= 0) {
            dest.append(src.substring(oldpos, pos));
            dest.append(newstr);
            oldpos = pos + len;
        }

        if (oldpos < srclen) {
            dest.append(src.substring(oldpos, srclen));

        }
        return dest.toString();
    }
    

    /**
     * 문자열 추출
     * @param
     * @return
     */
    public static String substr(String str, int start, int end) {
        String result = "";
        if (str.length() > 0 && start <= str.length() && end <= str.length()
                && start <= end)
            result = str.substring(start, end);

        return result;
    }    
    
    /**
     * 대상문자열(strTarget)에서 구분문자열(strDelim)을 기준으로 문자열을 분리하여 각 분리된 문자열을
     * 배열에 할당하여 반환한다. 
     * @param ::  strTarget 분리 대상 문자열
     * @param ::  strDelim 구분시킬 문자열로서 결과 문자열에는 포함되지 않는다.
     * @param ::  bContainNull 구분되어진 문자열중 공백문자열의 포함여부. true : 포함, false : 포함하지 않음.
     * @return :: 분리된 문자열을 순서대로 배열에 격납하여 반환한다.
     * @exception LException
     */
    public static String[] split(String strTarget, String strDelim,
            boolean bContainNull) {
        // StringTokenizer는 구분자가 연속으로 중첩되어 있을 경우 공백 문자열을 반환하지 않음.
        // 따라서 아래와 같이 작성함.
        int index = 0;
        String[] resultStrArray = null;

        resultStrArray = new String[search(strTarget, strDelim) + 1];
        String strCheck = new String(strTarget);
        while (strCheck.length() != 0) {
            int begin = strCheck.indexOf(strDelim);
            if (begin > -1) {
                int end = begin + strDelim.length();
                if (bContainNull) {
                    resultStrArray[index++] = strCheck.substring(0, begin);
                }
                strCheck = strCheck.substring(end);
                if (strCheck.length() == 0 && bContainNull) {
                    resultStrArray[index] = strCheck;
                    break;
                }
            } else {
                resultStrArray[index] = strCheck;
                break;                
            }
        }
        return resultStrArray;
    }

    /**
     * 대상문자열(strTarget)에서 지정문자열(strSearch)이 검색된 횟수를, 지정문자열이 없으면 0 을
     * 반환한다. 
     * @param ::  strTarget 대상문자열
     * @param ::  strSearch 검색할 문자열
     * @return :: 지정문자열이 검색되었으면 검색된 횟수를, 검색되지 않았으면 0 을 반환한다.
     * @exception LException
     */
    public static int search(String strTarget, String strSearch) {
        int result = 0;
        String strCheck = new String(strTarget);

        for (int i = 0; i < strTarget.length();) {
            int loc = strCheck.indexOf(strSearch);
            if (loc > -1) {
                result++;
                i = loc + strSearch.length();
                strCheck = strCheck.substring(i);
            } else {
                break;
            }
        }

        return result;
    }    
    
    /**
     * 넘겨온 String을 Space 문자로 right padding한다.  len보다 String이 길면 잘라버린다. 
     * @param s 문자열
     * @param len 문자열 길이 
     * @return String
     */
    public static String rpad(String s, int len) {
            if (s.length() > len)
                return s.substring(0, len);
            while (s.length() < len)
                s += " ";
            return s.substring(0, len);
     }
    
    /**
     * String을 Space 문자로 left padding한다.  len보다 String이 길면 잘라버린다. 
     *  @param s 문자열
     * @param len 문자열 길이 
     * @return String
     */
    public static String lpad(String s, int len) {
            if (s.length() > len)
                return s.substring(s.length() - len);
            while (s.length() < len)
                s = " " + s;
            return s.substring(s.length() - len);
    }  
    
    /**
     * 넘겨온 String을 문자로 right padding한다.  len보다 String이 길면 잘라버린다. 
     * @param s 문자열
     * @param len 문자열 길이 
     * @return String
     */
    public static String rpad(String s, int len, String p) {
            if (s.length() > len)
                return s.substring(0, len);
            while (s.length() < len)
                s += p;
            return s.substring(0, len);
     }
    
    /**
     * String을 문자로 left padding한다.  len보다 String이 길면 잘라버린다. 
     *  @param s 문자열
     * @param len 문자열 길이 
     * @return String
     */
    public static String lpad(String s, int len, String p) {
            if (s.length() > len)
                return s.substring(s.length() - len);
            while (s.length() < len)
                s = p + s;
            return s.substring(s.length() - len);
    }      
    
    /**
     * 해당 문자열이 null인지 여부를 논리값으로 리턴한다.
     * @param str 
     * @return  
     */
    public static boolean isNull(String str) {
        boolean resultBool = false;
        if (str == null || str.length() == 0 || "".equals(str))
            resultBool = true;

        return resultBool;
    }

    /**
     * 해당 문자열이 null 이면 공백문자로 리턴한다.
     * @param cstr 
     * @return  
     */
    public static String NVL(String cstr) {
        if (isEmpty(cstr)) cstr = ""; 
        return cstr;
    }

    /**
     * 해당 문자열이 null 이면 디폴트 문자로 리턴한다.
     * @param cstr, ndef 
     * @return 널이면 파라메터로 넘어온 디폴트 문자열을 리턴한다.
     */
    public static String NVL(String cstr, String ndef) {
        if (isEmpty(cstr)) cstr = ndef; 
        return cstr;
    }
    
    /**
     * BR 태그를 라인피드로 변환한다
     * @param
     * @return
     */
    public static synchronized String Br2N(String s) {
        return replace(s, "<BR>", "\n" );
    }

    /**
     * 라인피드를 BR 태그로 변환한다
     * @param
     * @return
     */
    public static synchronized String N2Br(String s) {
        return replace(s, "\n", "<BR>");
    }

    /**
     * 캐리지리턴을공백으로치환한다
     * @param
     * @return
     */
    public static String nSp(String s) {
        String Br;
        Br = replace(s, "\n", "");
        Br = replace(s, "\t", "");
        return Br;
    }

    /**
     * 태그 변경(JSP 본문출력)
     * @param
     * @return
     */
    public static String HTML(String str, boolean flg) {
        String html = defaultValue(str);
        html = replace(html, "&", "&amp;"); 
        html = replace(html, "<", "&lt;");
        html = replace(html, ">", "&gt;"); 
        html = replace(html, "\"", "&quot;");
        if(flg){
            html = replace(html, " ", "&nbsp;"); 
            html = replace(html, "\t", "&nbsp;&nbsp;");
            html = replace(html, "\n", "<BR>");
        }
        
        return html;
    }
    
    public static String getParameter(HttpServletRequest req,String strName)
    {
        String strTemp = req.getParameter(strName);
                strTemp = strTemp==null ? "" : strTemp;
                strTemp = replace(strTemp,"\'","");
                strTemp = replace(strTemp,"\"","");
                strTemp = replace(strTemp,"|","");
                strTemp = replace(strTemp,")","");
//              strTemp = replace(strTemp,"%","");
                strTemp = replace(strTemp,"--","");
                strTemp = checkAllTag(strTemp);
        return strTemp;
    } 
    
    public static String getParameter(String strName)
    {
        String strTemp = strName;
                strTemp = strTemp==null ? "" : strTemp;
                strTemp = replace(strTemp,"\'","");
                strTemp = replace(strTemp,"\"","");
                strTemp = replace(strTemp,"|","");
                strTemp = replace(strTemp,")","");
//              strTemp = replace(strTemp,"%","");
                strTemp = replace(strTemp,"--","");
                strTemp = checkAllTag(strTemp);
        return strTemp;
    } 
    
	public static String getAllCheck(String strTemp)
	{
				strTemp = strTemp==null ? "" : strTemp;
				strTemp = replace(strTemp,"\'","");
				strTemp = replace(strTemp,"\"","");
				//strTemp = replace(strTemp,")","");
//				strTemp = replace(strTemp,"%","");
				strTemp = replace(strTemp,"--","");
				strTemp = checkAllTag(strTemp);
		return strTemp;
	}    
    
    /**
    * 사용자 테그 사용 불가
    * @param String str
    * @return String
    */
    public static String checkAllTag(String str)
    {
        String strSource = "<>\"'";

        String convStr = null;

        if(str==null)
            return null;

        for(int i=0; i<str.length(); i++)
        {
            if(strSource.indexOf(str.charAt(i)) > -1)
            {
                char ch = str.charAt(i);
                String strPrev = str.substring(0, i);
                String strNext = str.substring(i+1);

                if(ch=='<')
                {
                    str = strPrev + "&lt;" + strNext;
                }
                else if(ch=='>')
                {
                    str = strPrev + "&gt;" + strNext;
                }
                else if(ch=='"' || ch=='\'')
                {
                    str = strPrev + "&quot;" + strNext;
                }
            }
        }

        convStr = str;

        return convStr;
    }    
    
    /**
     * 태그 제거
     * @param
     * @return
     */
    public static String removeTag(String str) {
        int lt = str.indexOf("<");
        if (lt != -1) {
            int gt = str.indexOf(">", lt);
            if ((gt != -1)) {
                str = str.substring(0, lt) + str.substring(gt + 1);
                str = removeTag(str);
            }
        }
        return str;
    }    
    
    /**
     * CRUD 에 맞게 데이터를 변환한다
     * @param 
     * @return
     */
    public static String encodeHTMLSpecialChar(String str, int n) {
        switch (n) {
        case 1: // text mode db 입력
            str = replace(str, "<", "&lt;");
            str = replace(str, "\"", "&quot;");
            break;
        case 2: // html mode db 입력
            str = replace(str, "<sc", "<x-sc");
            str = replace(str, "<title", "<x-title");
            str = replace(str, "<xmp", "<x-xmp");
            break;
        case 11: // text 일때 CONENT 처리
            str = replace(str, " ", "&nbsp;");
            str = replace(str, "\n", "<br>");
            break;
        case 13: // comment 저장 일때
            str = replace(str, "<sc", "<x-sc");
            str = replace(str, "<title", "<x-title");
            str = replace(str, "<xmp", "<x-xmp");
            str = replace(str, "\n", "<br>");
            break;
        case 14: // text mode db 입력
            str = replace(str, "&quot;", "\"");
            break;
        case 15: // text mode db 입력
            str = replace(str, "<", "&lt;");
            str = replace(str, ">", "&gt;");
            str = replace(str, "&", "&amp;");
            break;
        }
        return str;
    }

    /**
     * 전달받은 String값에서 ','값을 제거한다음 변경된 문자열을 반환한다. 금액형태의 DATA처리시 유용하다.
     * @param 
     * @return
     */
    protected static String removeComma(String s) {
        if (s == null) {
            return null;
        }
        if (s.indexOf(",") != -1) {
            StringBuffer buf = new StringBuffer();
            for (int i = 0; i < s.length(); i++) {
                char c = s.charAt(i);
                if (c != ',') {
                    buf.append(c);
                } 
            }

            return buf.toString();
        } 

        return s;
    }
 
    /**
     * Y / N 을 예/아니오로 바꾸어 준다
     * @param
     * @return
     */
    public static String convertYn(String ynStr) {
        if (ynStr == null)
            return "";
        if ("Y".equals(ynStr.trim().toUpperCase()))
            return "예";
        if ("N".equals(ynStr.trim().toUpperCase()))
            return "아니오";

        return "";
    }

    /**
     * 문자열을 줄여주는 함수 
     * @param ori_str
     * @param sep 문자열이 일정길이 이상일 경우 대체하는 문자열 (예 : "...")
     * @param str_len 
     * @return
     */
    public static String getResizeTitle(String ori_str, String sep, int str_len ){
        String ret_val = "";
        int ori_str_length = ori_str.length();
         
        if(ori_str_length <= str_len){
            ret_val = ori_str;
        }else{
            ret_val = shortCutString(ori_str, str_len) + sep;
        }
        
        return ret_val;
    }
    
    /**
     * 문자열을 줄여주는 함수 ( 문자열의 길이가 길경우는 ".." 으로 대처 )  
     * @param ori_str
     * @param str_len
     * @return
     */
    public static String getResizeTitle(String ori_str, int str_len ){
        ori_str = defaultValue(ori_str);
        String ret_val = "";
        int ori_str_length = ori_str.length();
        
        if(ori_str_length <= str_len){
            ret_val = ori_str;
        }else{
            ret_val = shortCutString(ori_str, str_len) + "...";
        }
        
        return HTML(ret_val, false);
    }
    
    /**
     * limit 자리수 만큼 글자를 잘라준다.
     * @param ::  str 대상문자열
     * @param ::  limit 자를 자릿수
     * @return :: 잘라진 문자열
     * @exception :: LException
     */
    public static String shortCutString(String str, int limit) {
        if (str == null || limit < 4)
            return str;

        int len = str.length();
        int cnt = 0, index = 0;

        while (index < len && cnt < limit) {
            if (str.charAt(index++) < 256) // 1바이트 문자라면...
                cnt++; // 길이 1 증가
            else
                // 2바이트 문자라면...
                cnt += 2; // 길이 2 증가
        }

        if (index < len)
            str = str.substring(0, index) + "...";

        return str;
    }

    
    //--------------------------------------------------------------------------------
    //----------------------------------숫자관련--------------------------------------
    //--------------------------------------------------------------------------------
    
    /**
     * 숫자를 정규 표현식으로 출력한다.
     * @param
     * @return
     */
    public static String getDecimalFormat(double doubleNumber, int fraction) {
        String result = "";

        java.text.DecimalFormat numberFormat = new java.text.DecimalFormat();

        if (fraction > 4)
            fraction = 0;

        switch (fraction) {
        case 0:
            numberFormat.applyPattern("#,##0");
            break;
        case 1:
            numberFormat.applyPattern("#,##0.0");
            break;
        case 2:
            numberFormat.applyPattern("#,##0.00");
            break;
        case 3:
            numberFormat.applyPattern("#,##0.000");
            break;
        case 4:
            numberFormat.applyPattern("#,##0.0000");
            break;
        case 5:
            numberFormat.applyPattern("#0");
            break;
        default:
            numberFormat.applyPattern("#,##0.00");
            break;
        }

        try {
            result = numberFormat.format(doubleNumber);
        } catch (IllegalArgumentException e) {
            throw e;
        }

        return result;
    }

    /**
     * 숫자를 정규 표현식으로 출력한다. (문자)
     * @param
     * @return
     */
    public static String getDecimalFormat(String str, int fraction) {
        String stringNumber = str;
        double doubleNumber = 0;

        if ("".equals(stringNumber))
            stringNumber = "0";

        try {
            doubleNumber = Double.parseDouble(stringNumber);
        } catch (NumberFormatException e) {
            throw e;
        }

        return getDecimalFormat(doubleNumber, fraction);
    }
    
    /**
     * parameter i의 자릿수 round down.
     *  Usage :    StringUtil.round(20.20, 2);
     *  예 )
     *  StringUtil.cut(44.44,-1) =&gt; 44.4
     *  StringUtil.cut(55.55,-1) =&gt; 55.5
     *  StringUtil.cut(44.44, 0) =&gt; 44.0
     *  StringUtil.cut(55.55, 0) =&gt; 55.0
     *  StringUtil.cut(44.44, 1) =&gt; 40.0
     *  StringUtil.cut(55.55, 1) =&gt; 50.0
     *  StringUtil.cut(44.44, 2) =&gt; 0.0
     *  StringUtil.cut(55.55, 2) =&gt; 0.0     *
     * @param dAmount
     *            적용하려는 double 형의 숫자
     * @param i
     *            자릿수
     * @return double return value
     *
     */
    public static double cut(double dAmount, int i) {
        double result = 0;
        long rest = 1;
        for (int x = 0; x < Math.abs(i); x++) {
            rest *= 10;
        }
        if (i > 0) {
            result = (double) ((long) (dAmount / rest)) * rest;
        } else {
            result = (double) ((long) (dAmount * rest)) / rest;
        }
        
        return result;
    }

    /**
     * parameter i의 자릿수 round up.     *
     *  usage :    StringUtil.round(20.20, 2);
     *  예)
     *  StringUtil.round(44.44,-2) =&gt; 44.44
     *  StringUtil.round(55.55,-2) =&gt; 55.55
     *  StringUtil.round(44.44,-1) =&gt; 44.4
     *  StringUtil.round(55.55,-1) =&gt; 55.6
     *  StringUtil.round(44.44, 0) =&gt; 44.0
     *  StringUtil.round(55.55, 0) =&gt; 56.0
     *  StringUtil.round(44.44, 1) =&gt; 40.0
     *  StringUtil.round(55.55, 1) =&gt; 60.0
     *  StringUtil.round(44.44, 2) =&gt; 0.0
     *  StringUtil.round(55.55, 2) =&gt; 100.0
     * @param dAmount
     *            적용하려는 double 형의 숫자
     * @param i
     *            자릿수
     * @return double return value
     *
     */
    public static double round(double dAmount, int i) {
        double result = 0;
        long rest = 1;
        for (int x = 0; x < Math.abs(i); x++) {
            rest *= 10; 
        }
        if (i > 0) {
            result = Math.round(dAmount / rest) * rest;
        } else {
            result = (double) Math.round(dAmount * rest) / rest;
        }
        
        return result;
    }

    
    //----------------------------------------------------------------------------------
    //----------------------------------게시판관련--------------------------------------
    //----------------------------------------------------------------------------------
    
    /**
     * NVL처리와 HTML처리를 한다.
     * @param str
     * @return
     */
    public static String nvlHtml(String str) {
        String result = "";
        result = encodeHTMLSpecialChar(NVL(str), 1);
        return result;
    }

    /**
     * NVL처리(널일경우 대체문자열)와 HTML처리를 한다.
     * @param str
     * @return
     */
    public static String nvlHtml(String str, String alter_str) {
        String result = "";
        result = encodeHTMLSpecialChar(NVL(str, alter_str), 1);
        return result;
    }

    /**
     * NVL처리(널일경우 대체문자열)와 HTML처리를 한다.
     * @param str
     * @return
     */
    public static String nvlHtml(String str, String alter_str, int actionType) {
        String result = "";
        result = encodeHTMLSpecialChar(NVL(str, alter_str), actionType);
        return result;
    }
    
    /**
     * 제한 글자 이상의 글은 자르고 풍선도움말을 보여주는 문자열을 반환하는 함수이다. '...' 와 같은 구분자를 넣는 것이
     * 선택가능하다.
     *
     *  Usage :    StringUtil.cutStringForBalloon(&quot;한글사용가능한지&quot;, 1, 3);
     *  예 )
     *  StringUtil.cutStringForBalloon(&quot;한글사용가능한지&quot;, 1, 3); =&gt; 한글은...
     *
     * @param orgStr
     *            체크하려는 String
     * @param gubun
     *            '...' 를 추가할려면 1 아닐시 0등 다른 값
     * @param cutlength
     *            글자 제한 length, 짝수만 가능
     * @return String return String
     *
     */
    public static String cutStringForBalloon(String orgStr, int gubun, int cutlength) {
        int strLength = orgStr.length();
        if (strLength < cutlength) {
            return orgStr;
        }

        String cutStr = "";
        String strTemp = replace(orgStr, "\"", "");
        if (gubun == 1) {
            cutStr = getResizeTitle(strTemp, cutlength);
        } else {
            cutStr = shortCutString(strTemp, cutlength);
        } 
        
        return "<font title=\"" + strTemp + "\">" + cutStr + "</font>";
    }
    
    //----------------------------------------------------------------------------------
    //----------------------------------기타함수----------------------------------------
    //----------------------------------------------------------------------------------    
    
    /**
     * 지정한 나이 미만(미성년자) 여부 확인. 단, 법인(10자리)은 성인으로 인정.
     *  Usage :    StringUtil.isValidAge(&quot;7707071234567&quot;, 19);
     *  기준일( 2002/08/07)
     *  예 1) StringUtil.isValidAge(&quot;0012123537868&quot;, &quot;20&quot;) =&gt; false
     *  예 2) StringUtil.isValidAge(&quot;8208012537869&quot;, &quot;20&quot;) =&gt; true
     *  예 3) StringUtil.isValidAge(&quot;8209012537869&quot;, &quot;20&quot;) =&gt; false
     * @param personalId
     *            주민 등록 번호
     * @param limitAge
     *            기준 (만)나이
     * @return boolean true 기준 나이 이상, false 기준 나이 미만
     *
     */
    public static boolean isValidAge(String personalId, int limitAge) {

        boolean retr = true;
        //법인
        if (personalId.length() == 10) {
            return true;
        }

        String birthday = "";
        if (personalId.charAt(6) == '1' || personalId.charAt(6) == '2') {
            birthday = "19" + personalId.substring(0, 6);
        } else if (personalId.charAt(6) == '3' || personalId.charAt(6) == '4') {
            birthday = "20" + personalId.substring(0, 6);
        }

        Calendar today = Calendar.getInstance();
        //LLog.debug.println("isValidAge today. : "+today.getTime());

        today.add(Calendar.YEAR, -limitAge);
        //LLog.debug.println("isValidAge today. : "+today.getTime());
        SimpleDateFormat formatter = new SimpleDateFormat(
                StringUtilEx.DEFAULT_DATE_FORMAT);

        try {
            if( today.getTime().compareTo(formatter.parse(birthday)) > 0){
                retr = false;
            }
        } catch (ParseException pe) {
            retr = false;
        }
        //LLog.debug.println("isValidAge retr : "+retr);
        return retr;
    }

    /**
     * 지정한 나이 미만(미성년자) 여부 확인. 단, 법인(10자리)은 성인으로 인정.
     *  Usage :    StringUtil.isValidAge(&quot;7707071234567&quot;, 19);
     *  기준일( 2002/08/07)
     *  예 1) StringUtil.isValidAge(&quot;0012123537868&quot;, &quot;20&quot;) =&gt; false
     *  예 2) StringUtil.isValidAge(&quot;8208012537869&quot;, &quot;20&quot;) =&gt; true
     *  예 3) StringUtil.isValidAge(&quot;8209012537869&quot;, &quot;20&quot;) =&gt; false
     * @param personalId
     *            주민 등록 번호
     * @param limitAge
     *            기준 (만)나이
     * @return boolean true 기준 나이 이상, false 기준 나이 미만
     *
     */
    public static boolean isValidAge_reserve(String personalId, int limitAge,
            String reserve_date) {
        //LLog.debug.println("isValidAge_reserve personalId : "+personalId);
        //LLog.debug.println("isValidAge_reserve limitAge : "+limitAge);
        //LLog.debug.println("isValidAge_reserve reserve_date : "+reserve_date);
        boolean retr = true;

        //법인
        if (personalId.length() == 10) {
            return true;
        }

        String birthday = "";
        if (personalId.charAt(6) == '1' || personalId.charAt(6) == '2') {
            birthday = "19" + personalId.substring(0, 6);
        } else if (personalId.charAt(6) == '3' || personalId.charAt(6) == '4') {
            birthday = "20" + personalId.substring(0, 6);
        }

        Calendar reserve = Calendar.getInstance();
        if(reserve_date.length() < 8){
            //LLog.debug.println(" reserve_date fommat is wrong! : "+reserve_date);
            return false;
        }
        reserve.set( Integer.parseInt(reserve_date.substring(0,4)) , Integer.parseInt(reserve_date.substring(4,6)) , Integer.parseInt(reserve_date.substring(6,8)) );
        reserve.set(Calendar.YEAR, -limitAge);

        SimpleDateFormat formatter = new SimpleDateFormat(
                StringUtilEx.DEFAULT_DATE_FORMAT);

        try {
            //LLog.debug.println("isValidAge_reserve reserve.getTime().getTime() : "+reserve.getTime().getTime());
            //LLog.debug.println("isValidAge_reserve formatter.parse(birthday).getTime() : "+formatter.parse(birthday).getTime());
            if (reserve.getTime().getTime() < formatter.parse(birthday).getTime()) {
                retr = false;
            }
        } catch (ParseException pe) {
            retr = false;
        }
        //LLog.debug.println("isValidAge_reserve retr : "+retr);
        return retr;
    }

    /**
     * 주민등록 번호의 유효성 여부 check.
     *  Usage :    StringUtil.isValidPersonalId(&quot;7707071234567&quot;);
     *  예 1) StringUtil.isValidPersonalId(&quot;1008062537868&quot;) =&gt; true
     *  예 2) StringUtil.isValidPersonalId(&quot;1008062537870&quot;) =&gt; false
     * @param personalId
     *            주민 등록 번호
     * @return boolean true 유효 주민등록 번호, false 잘못된 주민 등록번호
     *
     */
    public static boolean isValidPersonalId(String personalId) {

        if (personalId.length() != 13) {
            return false;
        }

        int total = 0;

        int iarray[] = new int[14];
        for (int i = 1; i <= 13; i++) {
            iarray[i] = Character.digit(personalId.charAt(i - 1), 10);
        }
        for (int i = 1; i <= 12; i++) {
            int k = i + 1;
            if (k >= 10) {
                k = (k % 10) + 2;
            }
            total += iarray[i] * k;
        }

        int chd = 11 - (total % 11);
        if (chd == 10 || chd == 11) {
            chd = 0;

        }
        int mm = (iarray[3] * 10) + iarray[4];
        int dd = (iarray[5] * 10) + iarray[6];

        if (chd == iarray[13] && mm < 13 && dd < 32 && 1 <= iarray[7]
                && iarray[7] <= 4) {
            return true;
        }

        return false;
    }
    
    /**
     * String 포멧(-)
     * @param str, format
     * @return
     */
    public static String setFormatHyphen(String str, String format) { 
        String   retStr = "";
        String   tmpStr = "";
        String[] frmStr = format.split("-");
        int idxSta, idxEnd; 
        
        for(int i = 0; i < frmStr.length; i++){
            idxSta = (i == 0) ? 0 : frmStr[i-1].length();
            idxEnd = idxSta + frmStr[i].length(); 
            tmpStr = (i == 0) ? "" : "-"; 
            retStr += tmpStr + str.substring(idxSta, idxEnd);
        }
        
        return retStr;
    }    
    
    /**
     * 주민번호를 입력 받아 사이에 -를 추가한다.
     * @param str 주민번호
     * @return 사이에 -가 추가된 주민번호
     */
    public static String setJuminNo(String str) {
        String retStr = "";
        str = defaultValue(str); 
        if (str.length() == 13) {
            retStr = setFormatHyphen(str, JUMIN_FORMAT); 
        } 
        return retStr;
    }    

    /**
     * 우편번호를 입력 받아 사이에 -를 추가한다.
     * @param zip
     * @return 사이에 -가 추가된 우편번호
     */
    public static String setZipCode(String zip){
        String retStr = "";
        zip = defaultValue(zip);
        if(zip.length() > 3){
        	/* 우편번호 5자리시행 15년 8월 1일부터. 2015/07/28 ok84j */
        	if(zip.length() == 6 ){ 
        		retStr = setFormatHyphen(zip, POST_FORMAT);
        	} else if (zip.length() == 5 ){ 
        		retStr = setFormatHyphen(zip, "XXX-XX");
        	}
        } 
        return retStr;
    }

    /**
     * 유선역락처 포멧을 만든다.(000 XXX YYYY) 
     * @param sTelNo1 국번
     * @param sTelNo2 전화번호
     * @return String
     */
    public static String setTelNoFormat(String ddd, String number) {
        String retStr = "";
        ddd    = defaultValue(ddd);
        number = defaultValue(number);
        if(number.length() > 6){
            if(ddd.length() == 2) ddd = " " + ddd;
            if(number.length() == 7){
                number = number.substring(0, 3) + " " + number.substring(3);
            }   
            retStr = setFormatHyphen(ddd + number, PHONE_FORMAT);
        } 
        return retStr;
    }

    /**
     * 핸드폰번호를 입력된 포멧으로 반환함
     * @param number
     * @param sep
     * @return
     */
    public static String getPhoneNumber(String number){
        String retStr = "";
        number = defaultValue(number);
        if(number.length() > 6){
            if(number.length() == 10){
                number = number.substring(0, 3) + " " + number.substring(3);
            }   
            retStr = setFormatHyphen(number, PHONE_FORMAT);
        } 
        return retStr;
    }
    
    /**
     * 핸드폰번호를 입력된 포멧으로 반환함
     * @param number
     * @param sep
     * @return
     */
    public static String getPhoneNumberByProdNo(String number){
        String retStr = "";
        number = NVL(number); 
        String reNum = StringUtil.replace(number, "-", ""); 
        
        if(reNum.length() > 6){
           if(reNum.substring(3, 4).equals("0")&&!reNum.substring(4, 5).equals("0")){  
                retStr += reNum.substring(0, 3) + "-"+ reNum.substring(4, 8) + "-" +reNum.substring(8, reNum.length());
            } else if(reNum.substring(3, 4).equals("0")&&reNum.substring(4, 5).equals("0")){ 
                retStr += reNum.substring(0, 3) + "-"+ reNum.substring(5, 8) + "-" +reNum.substring(8, reNum.length());
            } else if(!reNum.substring(3, 4).equals("0")){
            	 retStr += reNum.substring(0, 3) + "-" + reNum.substring(3, 7) + "-" +reNum.substring(7, reNum.length());
            }
        }
        return retStr;
    }
     
    /**
     * 파일 확장자 추출
     * @param
     * @return
     */
    public static String extacFileExt(String cVar) {
        int pathLen = cVar.indexOf(".");
        String strExt = cVar.substring(pathLen + 1);
        return strExt;
    }    

    /**
     * SelectBox 선택체크
     * @param value
     * @param target
     * @return
     */
    public static String[] getSelectBoxCheck(String value, String target){
        String[] tarVal = target.split("/");
        String[] retVal = new String[tarVal.length];
        
        for (int i = 0; i < tarVal.length; i++){
            retVal[i] = (tarVal[i].equals(value)) ? "selected" : "";
        }
         
        return retVal;
    }
    
    /**
     * 파일 업로드 주소
     * @param value
     * @param target
     * @return
     */
    public static String getUploadUrl(HttpServletRequest req, String folder){
        String retVal = "http://" + req.getServerName();
        retVal += ("".equals(folder)) ? "/upload/images/" : folder; 
        return retVal;
    }    

    
    /**
     * 페이지 상에 사용하는 인덱스를 표시하는 함수이다.
     * @return String 화면에 인덱스를 구성하는 문자열
     */
    public static String getPageIndex(int currentPage, int cntPages) {
        
        final int cntIndexs = 10;
        final int startPage = (currentPage - 1) / cntIndexs * cntIndexs + 1;
        final int endPage   = (cntPages > (startPage + cntIndexs)) ? startPage + cntIndexs : cntPages + 1; 
        
        String className = " class=\"td-page1\"";

        StringBuffer retStr = new StringBuffer(); 
        
        for (int targetPage = startPage; targetPage < endPage; targetPage++) { 
            if (currentPage == targetPage) {
                retStr.append("<span" + className + "><b>" + targetPage + "</b></span>");  
            } else {
                int goPage = (targetPage - 1) * cntIndexs + 1;
                retStr.append("<span" + className + "><a href=\"javascript:goPage('" + goPage + "')\">" + targetPage + "</a></span>");
            }
            className = " class=\"td-page2\""; 
        }
        
        return retStr.toString();
    }
    
    /**
     * 페이지 상에 사용하는 합계를 표시하는 함수이다.
     * @return String 화면에 합계열을 구성하는 문자열
     */
    public static String getRowTotal(String type, int cols, double[] total) {
        String retStr = "";
        String titStr = ("1".equals(type)) ? "소&nbsp;&nbsp;계" : "합&nbsp;&nbsp;계";
        String subStr = ("1".equals(type)) ? "<td class=\"td-total-textC1\">&nbsp;</td>"  : "";
        
        retStr = "\t\t\t\t<tr>\n\t\t\t\t\t" + subStr + "<td class=\"td-total-textC" + type + "\">" + titStr + "</td>\n"; 
        if(cols > 0) retStr += "\t\t\t\t\t<td colspan=\"" + cols + "\" class=\"td-total-textR" + type + "\">&nbsp;</td>\n";
        
        for(int i=1; i<total.length; i++){ 
            retStr += "\t\t\t\t\t<td class=\"td-total-textR" + type + "\">" + getDecimalFormat(total[i], 0) +"</td>\n";
        }
        retStr += "\t\t\t\t</tr>\n";
        
        return retStr;
    }
    
    
    /**
     * 문자열이 숫자로 되어 있는지 확인하는 함수이다.
     * @param str - String
     * @return result - boolean
     */
    public static boolean isNumber(String str) {

    	if (str.length() > 0 ) {
    		char ch;
    		for (int i = 0; i < str.length(); i++) {
    			ch = str.charAt(i);
    			if(!('0' <= ch && ch <= '9')) {
    				return false;
    			}
    		}
    	}
    	
    	return true;
    }
    
    public static String changeCtnFormat(String ctn) {
    	
    	//추가
    	ctn.trim();
		
		if(ctn.indexOf("-") > -1){
			ctn = ctn.replaceAll("-","");
		}
		//추가끝

		if (ctn == null) {
			ctn = "";
		} else if (ctn.length() == 10) {
        	ctn = ctn.substring(0, 3)+"00"+ctn.substring(3);
		} else if (ctn.length() == 11) { 	
        	ctn = ctn.substring(0, 3)+"0"+ctn.substring(3);
		}
			
		return ctn;
	}
    
    public static String converToTelNo(String src) {
        if (src == null || "".equals(src)) {
            return "";
        }
        
        if (src.indexOf("-") == -1) {
            return src;
        }

        String[] tokens = src.split("-");

        if (tokens.length != 3) {
            return "";
        }

        for (int i = 0; i < tokens.length; i++) {
            tokens[i] = rpadByte(tokens[i], 4, (byte)' ');
        }

        return tokens[0] + tokens[1] + tokens[2];
    }

    public static String rpadByte(String str, int len, byte pad) {
        if (str == null) {
            str = "";
        }
        if (str.length() > len) {
            str = str.substring(0, len);
        }

        byte[] src;
        byte[] result = new byte[len];

        Arrays.fill(result, pad);
        try {
            src = str.getBytes("euc-kr");
            System.arraycopy(src, 0, result, 0, src.length);

        } catch (UnsupportedEncodingException e) {
        }

        return new String(result);
    }

    public static String change01toYN(String src) {
        if (src == null || "".equals(src.trim())) {
            return "N";
        }

        if ("0".equals(src.trim())) {
            return "Y";

        } else {
            return "N";
        }
    }    
    
    /**
     * 실행 중인 메소드 명 출력
     * @param obj 실행 중인 클래스 객체
     * @param flag	S:시작, E:종료 를 의미하는 플래그
     * @param e	Stack 정보
     */
     public static void traceMethodName(Object obj, String flag, StackTraceElement e[]) {
     	String str = "START";
     	if("E".equals(flag)) {
     		str = "END";
     	}
     	//LLog.debug.println("▶▶▶["+getCurrentMethodName(obj,e)+"]◀◀◀ " +str);
 	}

     /**
      * 실행 중인 메소드 명 출력
      * @param obj 실행 중인 클래스 객체
      * @param flag	S:시작, E:종료 를 의미하는 플래그
      * @param e	Stack 정보
      */
      public static void printMethodName(String methodName) {
     	 printMethodName(methodName,"S");
  	}

      /**
       * 실행 중인 메소드 명 출력
       * @param obj 실행 중인 클래스 객체
       * @param flag	S:시작, E:종료 를 의미하는 플래그
       * @param e	Stack 정보
       */
       public static void printMethodName(String methodName, String flag) {
       	String str = "START";
       	if("E".equals(flag)) {
       		str = "END";
       	}
       	//LLog.debug.println("▶▶▶["+methodName+"]◀◀◀ " +str);
   	}

     /**
      * 실행 중인 메소드 명
      * @param obj
      * @param e
      * @return
      */
     public static String getCurrentMethodName(Object obj, StackTraceElement e[]) {
     	String methodName = "";
     	boolean doNext = false;
     	for (StackTraceElement s : e) {
     		if (doNext) {
     			methodName = obj.getClass().getName()+"."+s.getMethodName();
     			break;
     		}
     		doNext = s.getMethodName().equals("getStackTrace");
     	}
     	return methodName;
 	}
     /**
      * Injection 문자 제거
      * @param str
      * @return
      */
     public static String removeInjection (String str) {  
         String retVal = defaultValue(str);  

         retVal = replace(retVal,"&","&amp;");                                                                                               
         retVal = replace(retVal,"#", "&#35");                                                                                        
         retVal = replace(retVal,"(", "&#40");                                                                                         
         retVal = replace(retVal,")", "&#41");                                                                                         
         retVal = replace(retVal,"/", "&#47");                                                                                         
         retVal = replace(retVal,"<","&lt;");                                                                                           
         retVal = replace(retVal,">","&gt;");                                                                                          
         retVal = replace(retVal,"'","");                                                                                      
         retVal = replace(retVal,"--","");                                                                                                
         retVal = replace(retVal,":","&#59");    
         
         return retVal;
     }
     
     
     
    
     /*
      * 주소값에 쿼리인입체크 20140414
      * */
     public static boolean checkValidParam(String paramValue) throws Exception {
         
         if(paramValue !=null){
         	paramValue = paramValue.toLowerCase();
         }
         
         List al = new ArrayList();
         
         //SELECT, AND, OR, UNION, DECLARE, CAST, TO_CHAR, HAVING, GROUP BY, FROM, WHERE, xp_cmdshell, UPDATE, INTO, INSERT
         
         al.add("select");
         al.add("from");
         al.add("update");
         al.add("union");
         al.add("declare");
         al.add("cast");
         al.add("having");
         al.add("group by");
         al.add("into");
         al.add("insert");
         al.add("xp_cmdshell");
         al.add("where");
         al.add("'");
                  
         
         for(int i=0;i<al.size();i++){
         	String tmepStr = (String)al.get(i);
         	//LLog.debug.println("---paramValue.S1"+paramValue+"-------paramValue.E1------------");
   //      	LLog.debug.println("---al.S1-----------"+al+"-------al.E1------------");
         	//LLog.debug.println("---tmepStr.S1-----------"+tmepStr+"-------tmepStr.E1------------");
         	
         	if(paramValue.indexOf(tmepStr) > -1){
         		//LLog.debug.println(paramValue+"-------->>>>>>>>> false END ");
         		return false;
         	}
         }
         //LLog.debug.println(paramValue+"-------->>>>>>>>> true END ");
         return true;
         
     }
     
     
     
     
 	
 	
 	/**
     * 미성년자 체크  2014/12/16 ok84j 
     * 
     * @param setHashMap
     * @return
     */
	public static boolean underAge(String personalId, int limitAge){
		
		 boolean isUnder = false;
		 
		 String birthDay = "";
		 
		 if(personalId.charAt(6)  == '1' || personalId.charAt(6)  == '2'){
			 birthDay = "19" + personalId.substring(0, 6); 
		 } else if(personalId.charAt(6)  == '3' || personalId.charAt(6)  == '4'){
			 birthDay = "20" + personalId.substring(0, 6); 
		 }
			
		 Calendar today = Calendar.getInstance();
		 
		 today.add(Calendar.YEAR, -limitAge);
		 SimpleDateFormat format = new SimpleDateFormat("yyyymmdd");
		 try {
			 if(today.getTime().compareTo(format.parse(birthDay)) < 0){
				 isUnder = true;
			 } 
		 } catch (ParseException pe ) {  
			 isUnder = false; 
		 }
		 
		 return isUnder;
 
	}
	
	
	/**
	 * Vitual start IDX
	 * @param totCnt
	 * @param currentPage
	 * @param rowsPerPage
	 * @return
	 */
	public static int startIdx(int totCnt, int currentPage, int rowsPerPage) {
		
		int startRow = totCnt - ( currentPage - 1 ) * rowsPerPage;
		int offSet   = 1;	//using Jstl idx start 1....
		
		return startRow + offSet;
	}
	
	/**
	*  Desc : 전화번호 형식의 문자열 내부에 하이픈(-)를 추가한다.
	*  CmmnUtil.getFormatStr("01012345678") = "010-1234-5678"
	*  @Mehtod Name : getFormatStr
	*  @param text
	*  @return
	*/	
	public static String getFormatStr(String text) {
		if (text.length() == 11) {
			return text.substring(0, 3).concat("-").concat(text.substring(3, 7)).concat("-").concat(text.substring(7, 11));
		} else if (text.length() == 10) {
			return text.substring(0, 3).concat("-").concat(text.substring(3, 6)).concat("-").concat(text.substring(6, 10));
		} else if (text.length() == 12) {  //추가 2014/11/25 ok84j 
			return text.substring(0, 4).concat("-").concat(text.substring(4, 8)).concat("-").concat(text.substring(8, 12));
		} else {
			return text;
		}
	}		
	
	/**
	 *  Desc : yyyyMMdd 혹은 yyyy-MM-dd 형식의 날짜 문자열을 입력 받아 년, 월, 일을 증감한다.
	 *  @Mehtod Name : addYearMonthDay
	 *  @param sDate
	 *  @param year
	 *  @param month
	 *  @param day
	 *  @return
	 */
	public static String addYearMonthDay(String sDate, int year, int month, int day) {
		String dateStr = validChkDate(sDate);
	
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		try {
			cal.setTime(sdf.parse(dateStr));
		} catch (ParseException e) {
			throw new IllegalArgumentException("Invalid date format: " + dateStr);
		}
	
		if (year != 0)
			cal.add(Calendar.YEAR, year);
		if (month != 0)
			cal.add(Calendar.MONTH, month);
		if (day != 0)
			cal.add(Calendar.DATE, day);
		return sdf.format(cal.getTime());
	}	

	/**
	 *  Desc : 입력된 일자 문자열을 확인하고 8자리로 리턴
	 *  @Mehtod Name : validChkDate
	 *  @param dateStr
	 *  @return
	 */
	public static String validChkDate(String dateStr) {
		String _dateStr = dateStr;
		
		if (dateStr == null || !(dateStr.trim().length() == 8 || dateStr.trim().length() == 10)) {
			throw new IllegalArgumentException("Invalid date format: " + dateStr);
		}
		if (dateStr.length() == 10) {
			_dateStr = removeChar(dateStr, '.');
		}
		return _dateStr;
	}

	/**
	 *  Desc : 기준 문자열에 포함된 모든 대상 문자(char)를 제거한다.
	 *  @Mehtod Name : removeChar
	 *  @param str
	 *  @param remove
	 *  @return
	 */
	public static String removeChar(String str, char remove) {
		if (isEmpty(str) || str.indexOf(remove) == -1) {
			return str;
		}
		char[] chars = str.toCharArray();
		int pos = 0;
		for (int i = 0; i < chars.length; i++) {
			if (chars[i] != remove) {
				chars[pos++] = chars[i];
			}
		}
		return new String(chars, 0, pos);
	}

	/**
	 *  Desc : String이 비었거나("") 혹은 null 인지 검증한다.
	 *  @Mehtod Name : isEmpty
	 *  @param str
	 *  @return
	 */
	public static boolean isEmpty(String str) {
		return str == null || str.trim().length() == 0;
	}
	
	/**
	 *  Desc : yyyyMMdd 형식의 날짜문자열을 원하는 캐릭터(ch)로 쪼개 돌려준다
	 *  @Mehtod Name : formatDate
	 *  @param sDate
	 *  @param ch
	 *  @return
	 */
	public static String formatDate(String sDate, String ch) {
		if (StringUtils.isEmpty(sDate)) {
			return "";
		}
		String dateStr = validChkDate(sDate);
	
		String str = dateStr.trim();
		String yyyy = "";
		String mm = "";
		String dd = "";
	
		if (str.length() == 8) {
			yyyy = str.substring(0, 4);
			if (yyyy.equals("0000"))
			return "";
		
			mm = str.substring(4, 6);
			if (mm.equals("00"))
			return yyyy;
		
			dd = str.substring(6, 8);
			if (dd.equals("00"))
			return yyyy + ch + mm;
		
			return yyyy + ch + mm + ch + dd;
		} else if (str.length() == 6) {
			yyyy = str.substring(0, 4);
			if (yyyy.equals("0000"))
			return "";
		
			mm = str.substring(4, 6);
			if (mm.equals("00"))
			return yyyy;
		
			return yyyy + ch + mm;
		} else if (str.length() == 4) {
			yyyy = str.substring(0, 4);
			if (yyyy.equals("0000"))
				return "";
			else
				return yyyy;
		} else
			return "";
	}	
	
	/**
	*  Desc : 11자리인 핸드폰번호를 ucube 요청 parameter인 prodNo(12자리)로 변환
	* @param prodNo
	* @return 
	*/
	public static String convertCtnToProdNo(String ctn) {
		StringBuffer sbProdNo = new StringBuffer();
		ctn.trim();
		
		if(ctn.indexOf("-") > -1){
			ctn = ctn.replaceAll("-","");
		}
		
		sbProdNo.append(ctn);
		sbProdNo.insert(3, '0');
			
		return sbProdNo.toString();		
	}

	/**
	*  Desc : ucube 응답 parameter인 prodNo(12자리)를 화면출력용 핸드폰번호 형태로 변환 (ex : 010-1234-5678)
	* @param prodNo
	* @return 
	*/
	public static String convertProdNoToCtn(String prodNo) {
		String ctn = new String();
		ctn = prodNo.substring(0, 3)+"-"+prodNo.substring(4, 8)+"-"+prodNo.substring(8, 12); // xxx0xxxxxxxx -> xxx-xxxx-xxxx 포맷으로 변환
		
		return ctn;
	}

	/**
	*  Desc : 텍스트 파일 읽기
	* @param filePath
	* @return 
	*/
	public static String readTextFile(String filePath) throws IOException 
	{
		String sHtml = "";
		StringBuffer sbContent = new StringBuffer();
		BufferedReader in = null;

		try
		{
		    URL url = new URL(filePath);
		    URLConnection urlconn = url.openConnection();
		    in = new BufferedReader(new InputStreamReader(urlconn.getInputStream()));

		    while((sHtml = in.readLine()) != null)
		    {
		    	sbContent.append(sHtml+"\r\n");
		    }
		}
		catch(IOException e)
		{
			throw e;
		}
		finally
		{
		    in.close();
		}
		
		return sbContent.toString(); 
	}
	
	/**
	 *  Desc : 객체가 null인지 확인하고 null인 경우 defaultValue 로 바꾸는 메서드
	 *  @Mehtod Name : getDefaultValue
	 *  @param value
	 *  @param defaultValue
	 *  @return
	 */
	public static String getDefaultValue( String value, String defaultValue ){
		return ( value == null || "".equals(value) ) ? defaultValue : value;
	}	
	
	/**
	 *  Desc : client ip 조회 2014/11/14 ok84j
	 *  @Mehtod Name : getDefaultValue
	 *  @param value
	 *  @param defaultValue
	 *  @return
	 */
	public static String getClientIp(HttpServletRequest request){  
		
		String ipAddr = request.getHeader("X-Forwarded-For");
		
		if(ipAddr == null || ipAddr.length() ==0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = 	request.getHeader("Proxy-Clent-IP");		 
		}
		if(ipAddr == null || ipAddr.length() ==0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = 	request.getHeader("WL-Proxy-Client-IP");		 
		}
		if(ipAddr == null || ipAddr.length() ==0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = 	request.getHeader("HTTP_CLIENT_IP");			 
		}
		if(ipAddr == null || ipAddr.length() ==0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = 	request.getHeader("HTTP_X_FORWARDED_FOR");			 
		}
		if(ipAddr == null || ipAddr.length() ==0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = 	request.getRemoteAddr();	 
		}
		
		return ipAddr;
	}
	
	
	/**
	 * 주민번호 앞자리를 생년월일형식으로 변경
	 * @param sDate
	 * @return
	 * @throws ParseException
	 */
	public static String formatDateBday(String sDate) throws ParseException {
		sDate = sDate.substring(0, sDate.length()-1);
		SimpleDateFormat originalFormat = new SimpleDateFormat("yymmdd");
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.mm.dd");
		
		Date originalDate = originalFormat.parse(sDate);
		String newDate = newFormat.format(originalDate);
		
		return newDate;
	}
	
	/**
	*  Desc : 전화번호 형식의 문자열 하이픈(-) 제거한다.
	*  CmmnUtil.convertCtn("010-1234-5678") = "01012345678" 
	*  @Mehtod Name : convertCtn
	*  @param text
	*  @return
	*/	
	public static String convertCtn(String text) {
		return text.replace("-", "");
	}
	
	/**
	 * 날짜를 yyyy.mm.dd 형식으로 변환
	 * @param sDate
	 * @return
	 * @throws ParseException
	 */
	public static String convertDateBday(String sDate) throws ParseException {
		SimpleDateFormat originalFormat = new SimpleDateFormat("yyyymmdd");
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.mm.dd");
		
		Date originalDate = originalFormat.parse(sDate);
		String newDate = newFormat.format(originalDate);
		
		return newDate;
	}
	
	/**
	 * 구분자로 구성된 문자열을 구분자로 분리된 문자열 배열로 반환
	 *
	 * @param   src     source 문자열
	 * @param   token   구분자
	 *
	 * @return  String[] 생성된 문자열 배열
	 */
	public static String[] stringToTokens(String src, String token)
	{
		Vector vector = new Vector();
		StringTokenizer st = new StringTokenizer(src,token);
		while(st.hasMoreTokens()){
			vector.addElement(st.nextToken());
		}
		String[] result = new String[vector.size()];
		vector.copyInto(result);
		return result;
	}
	
	/**
	 * val 정수를 문자열로 반환하며 size 크기에 따라 앞부분에 '0'를 붙인 문자열로 반환
	 *
	 * @param   val     문자열로 반환할 정수
	 * @param   size    반환될 문자열의 크기
	 *
	 * @return  String  생성된 문자열
	 */
	public static String resize(int val, int size){
		return resize(val, size, "0");
	}
	
	
	/**
	 * val 정수를 문자열로 반환하며 size 크기에 따라 앞부분에 append를 붙인 문자열로 반환
	 *
	 * @param   val     문자열로 반환할 정수
	 * @param   size    반환될 문자열의 크기
	 * @param   append  붙여넣을 문자열 : 한자짜리 문자열
	 *
	 * @return  String  생성된 문자열
	 */
	public static String resize(int val, int size, String append){
		String result = Integer.toString(val);
		if(result.length() < size){
			StringBuffer buf = new StringBuffer(size);
			int resize = size - result.length();
			for(int i = 0 ; i < resize ; i++)
				buf.append(append);
			buf.append(result);
			result = buf.toString();
		}
		return result;
	}
	
	/**
	 * size 크기에 따라 앞부분에 append를 붙인 문자열로 반환
	 *
	 * @param   val     원본 문자열
	 * @param   size    반환될 문자열의 크기
	 * @param   append  붙여넣을 문자열 : 한자짜리 문자열
	 *
	 * @return  String  생성된 문자열
	 */
	public static String resize(String val, int size, String append){
		String result = val;
		if(result.length() < size){
			StringBuffer buf = new StringBuffer(size);
			int resize = size - result.length();
			for(int i = 0 ; i < resize ; i++)
				buf.append(append);
			buf.append(result);
			result = buf.toString();
		}
		return result;
	}
	
	/**
	 * 문자열 자르기
	 * src.substring 보다 에러방지 효과가 있음. null pointer exception 방지 등
	 * src 문자열을 size만큼 잘라서 반환
	 *
	 * @param   src     문자열로 반환할 정수
	 * @param   size    잘라낼 크기(좌측으로 부터 잘라냄)
	 *
	 * @return  String  잘려진 문자열
	 */
	public static String substring(String src, int size){
		if(src == null) return src;
		if(src.length() < size) return src;
		if(size <= 0) return "";
		return substring(src, 0, size);
	}
	
	/**
	 * 문자열 자르기
	 * src.substring 보다 에러방지 효과가 있음. null pointer exception 방지 등
	 * src 문자열을 start 지점에서 end지점까지 잘라서 반환
	 *
	 * @param   src     문자열로 반환할 정수
	 * @param   start   잘라낼 크기(좌측으로 부터 잘라냄)
	 * @param   end     잘라낼 크기(좌측으로 부터 잘라냄)
	 *
	 * @return  String  잘려진 문자열
	 */
	public static String substring(String src, int start, int end){
		if(src == null) return src;
		int st = start, en = end;
		int len = src.length();
		if(len <= start) return "";
		if(start < 0) st = 0;
		if(len < end) en = len;
		return src.substring(st, en);
	}
	
	
	/**
	 * 문자열을 치환한다.
	 * 바꿀내역을 배열로 만들어서 일괄로 치환 처리함
	 *
	 * @param   src			기존 문자열
	 * @param   oldStrs		바꿀 문자열 배열
	 * @param   newStrs		바뀔 문자열 배열
	 * 
	 * @return  String		변경된 문자열
	 */
	public static String replace(String src, String[] oldStrs, String[] newStrs) {
		String rslt = src;
		for(int i = 0 ; i < oldStrs.length ; i++) {
			rslt = replace(rslt, oldStrs[i], newStrs[i]);
		}
		return rslt;
	}
	

	/**
	 * 문자열이 ""일 경우, "0"문자열을 반환한다.
	 *
	 * @param   src			기존 문자열
	 * 
	 * @return  String		기존 문자열 또는 "" 문자열
	 * 
	 * @author 허승우
	 */
	public static String EmptyToZero(String src) {
    	if( "".equals(src) )
    	{
    		src = "0";
    	}
    	return src;
	}
	
	/**
	 * 문자열이 NULL일 경우, "" 문자열을 반환한다.
	 *
	 * @param   src			기존 문자열
	 * 
	 * @return  String		기존 문자열 또는 "" 문자열
	 */
	public static String avoidNull(String src) {
		if(src == null) {
			return "";
		}
		return src;
	}
	
	
	/**
	 * 문자열이 NULL일 경우, " " 문자열을 반환한다.
	 *
	 * @param   src			기존 문자열
	 * 
	 * @return  String		기존 문자열 또는 " " 문자열
	 */
	public static String avoidNull2(String src) {
		if(src == "" || src.equals("")) {
			return " ";
		}
		return src;
	}
	
	/**
	 * 문자열에서 필요없는 문자를 제거
	 *
	 * @param	src			기존 문자열
	 * @param	del			제거할 문자열
	 * 
	 * @return	String		제거된 문자열
	 */
	public static String delStr(String src, String del)
	{
		String[] temp = src.split(del);
		StringBuffer temp2 = new StringBuffer();
		for(int i=0; i < temp.length; i++)
		{
			temp2.append(temp[i]);
		}
		
		return temp2.toString();
	}
	
	/**
	 * 문자열 채우기
	 * 
	 * @param	src			채울 문자열
	 * @param	count		반복 횟수
	 * 
	 * @return	String		채운 문자열
	 */
	public static String fillStr(String src, int count) {
		StringBuffer rt = new StringBuffer();
		for (int i = 0; i < count; i++) rt.append(src);
		return rt.toString();
	}
	
	/**
	 * 구분자로 연결된 문자열 채우기
	 * 
	 * @param	src			채울 문자열
	 * @param	seper		구분자
	 * @param	count		반복 횟수
	 * 
	 * @return	String		채운 문자열
	 */
	public static String fillStr(String src, String seper, int count) {
		StringBuffer rt = new StringBuffer();
		
		for (int i = 0; i < count; i++) {
			if (i != 0) rt.append(seper);
			rt.append(src);
		}
		
		return rt.toString();
	}
	
	/**
	 * 한글인지 아닌지 검사 하는 함수.
	 * 
	 * @param	uni20		원본 문자열
	 * 
	 * @return	boolean		한글일 경우 true
	 */
	public static boolean checkHan(String uni20)
	{
		boolean result = false;
		
		if (uni20 == null)
		{
			return result;
		}
		
		int len = uni20.length();
		char c;
		for (int i = 0; i < len; i++)
		{
			c = uni20.charAt(i);
			if (c < 0xac00 || 0xd7a3 < c)
			{
				
			}
			else
			{
				result = true;
				break;
			}
		}
		return result;
	}
	
	/**
	 * 문자열이 지정한 길이를 초과했을때 지정한길이에다가 해당 문자열을 붙여주는것
	 * 
	 * <pre>
	 *  String rst = StringUtil.cutString(request.getParameterValues("aaaaaaabbbbbbb","..",5);
	 *  ---------------
	 *  rst is aaaaa..
	 *  ---------------
	 * </pre>
	 * 
	 * @param	source		원본 문자열 배열
	 * @param	append		더할문자열
	 * @param	length		지정길이
	 * 
	 * @return	String		지정길이로 잘라서 더할분자열 합친 문자열
	 */
	public static String cutString(String str, int size)
	{
		int cnt = 0;
		StringBuffer sb = new StringBuffer(str.length());

		for (int i = 0; i < str.length(); i++){
			cnt++;
			if (str.charAt(i) >= 256) cnt ++;
			if (cnt > size){
				sb.append("...");
				break;
			}
			sb.append(str.charAt(i));
		}
		
		return sb.toString();
	}
	
	/**
	 * 헥사문자열을 문자로 바꿈.
	 * 
	 * @param	hexaString	haxa code로 된 문자열
	 * 
	 * @return	String		파싱한 문자열
	 */
	public static String hexStr2Str(String hexaString)
	{
		// 16진수로 바꿈..
		byte[] digest = hexaString.trim().getBytes();
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < digest.length; i++)
		{
			buf.append(Integer.toHexString((int) digest[i] & 0x00ff));
		}
		hexaString = buf.toString();// .toUpperCase();
		
		StringBuffer sb = new StringBuffer();
		int index = 0;
		for (int i = 0; i < hexaString.length() / 2; i++, index = index + 2)
		{
			sb.append("%");
			sb.append(hexaString.substring(index, index + 2));
		}
		String deStr = null;
		try
		{
			deStr = URLDecoder.decode(sb.toString());
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return deStr;
		/*
		 * int byteLength = hexaString.length() / 2;
		 * 
		 * byte[] result = new byte[ byteLength ];
		 * 
		 * for(int i = 0; i < byteLength; i++){ // 두 글자씩 잘라 byte값으로 변환 String
		 * flag = hexaString.substring(i*2, i*2+2); result[i] =
		 * (byte)Integer.parseInt(flag, 16); } try{ byte[] temp4 = new
		 * byte[result.length + 2]; System.arraycopy(result, 0, temp4, 1,
		 * result.length);
		 *  // 양옆에 SO/SI 붙이기 temp4[0] = 0x0E; temp4[temp4.length - 1] = 0x0F; //
		 * byte[]을 java String 으로 변환 String ori = new String(temp4, "Cp933"); //
		 * debug 프린트(ori.trim()); return ori.trim();
		 * 
		 * }catch(Exception _ex){ _ex.printStackTrace(); }
		 * 
		 * return null;
		 */
	}
	
    public static String isNull(String source, String value)
    {
        String retVal;

        if (source == null || source.trim().equals("") || source.trim().equals("null"))
        {
            retVal = value;
        }
        else
        {
            retVal = source.trim();
        }
        return retVal;
    }
    
    public static String replaceBlock(String element, Object strOjbType) throws Exception
    {
        String keyString = "";
        String replaceStirng = "";
        if (strOjbType == null) strOjbType = "";

        HashMap replaceMap = (java.util.HashMap) strOjbType;
        if (!replaceMap.containsKey("BLOCK"))
        {
            throw new Exception("BLOCK 키워드가 없습니다");
        }

        HashMap blockmap = (HashMap) replaceMap.get("BLOCK");
        Set keyset = blockmap.keySet();

        java.util.Iterator _iterator = keyset.iterator();

        while (_iterator.hasNext())
        {
            keyString = (String) _iterator.next();

            replaceStirng = (String) blockmap.get(keyString);

            element = element.replaceAll("@" + keyString + "@", isNull(replaceStirng, ""));

            // elementStringUtil.replace(element,keyString,replaceStirng);
        }
        return element;

        // return StringUtil.replace(element,"@BLOCK@",strOjbType);
    }

    public static String replaceBlockMap(String element, HashMap blockmap)
    {
        String keyString = "";
        String replaceStirng = "";

        Set keyset = blockmap.keySet();

        java.util.Iterator _iterator = keyset.iterator();

        while (_iterator.hasNext())
        {
            keyString = (String) _iterator.next();

            replaceStirng = (String) blockmap.get(keyString);

            element = element.replaceAll("@" + keyString + "@", isNull(replaceStirng, ""));
        }
        return element;
    }

    public static String replaceBlock(String element, String strOjbType)
    {

        if (strOjbType == null) strOjbType = "";
        strOjbType = strOjbType.trim();

        return StringUtil.replace(element, "@BLOCK@", strOjbType);
    }

    public static String replaceBlock(String element, String blockName, String strOjbType)
    {

        if (strOjbType == null) strOjbType = "";
        strOjbType = strOjbType.trim();

        return StringUtil.replace(element, "@"+blockName+"@", strOjbType);
    }
    
    /**
     * 숫자를 금액(천단위) 형태로 변환
     * @param nPrice
     * @return
     */
    public static String toPrice(int nPrice){
    	NumberFormat numFormat=NumberFormat.getIntegerInstance();
    	numFormat.setMinimumIntegerDigits(3);
    	return numFormat.format(nPrice);
    }
    
        
    /**
     * exception 의 상세 메세지를 가져온다.
     * @param throwable
     * @return
     */
    public static String getStackTrace(Throwable throwable) {
        ByteArrayOutputStream bytearrayoutputstream = new ByteArrayOutputStream();
        PrintWriter printwriter = new PrintWriter(bytearrayoutputstream);
        throwable.printStackTrace(printwriter);
        printwriter.flush();
        return bytearrayoutputstream.toString();
    }
    
    /**
	 * 문자열에서 일정 부분을 다른 부분의 폰트 색 변경
	 * @param str
	 * @param keyword
	 * @return
	 */
	public static String MarkKeyword(String str, String keyword) {
        keyword =
            replaceAt(
            		replaceAt(replaceAt(keyword, "[", "\\["), ")", "\\)"),
                "(", "\\(");

        Pattern p = Pattern.compile( keyword , Pattern.CASE_INSENSITIVE );
        Matcher m = p.matcher( str );
        int start = 0;
        int lastEnd = 0;
        StringBuffer sbuf = new StringBuffer();
        while( m.find() ) {
            start = m.start();
            sbuf.append( str.substring(lastEnd, start) )
                .append("<span style='background-color:YELLOW; color:RED;'>"+m.group()+"</span>" );
            lastEnd = m.end();
        } 
        return sbuf.append(str.substring(lastEnd)).toString() ;
    }

    /**
     * Method replace 문자열에서 일정 부분을 다른 부분으로 대치하는 메소드 
     * author 심민우 mailto:minwoo1975@hanmail.net
     * from; http://javaservice.net
     * @param str
     * @param oldString
     * @param newString
     * @return String
     */
    public static String replaceAt(String str, String oldStr, String newStr) {

        if (str == null) {
            return null;
        }
        if (oldStr == null || newStr == null || oldStr.length() == 0) {
            return str;
        }

        int i = str.lastIndexOf(oldStr);
        if (i < 0)
            return str;

        StringBuffer sbuf = new StringBuffer(str);

        while (i >= 0) {
            sbuf.replace(i, (i + oldStr.length()), newStr);
            i = str.lastIndexOf(oldStr, i - 1);
        }
        return sbuf.toString();
    }
    
    /**
     *'/n'을 '<br>'로 변경
     * @param first
     * @param brTag
     * @param comment
     * @return
     */
    public static String changeBr(String first, String brTag, String comment){
        StringBuffer buffer = new StringBuffer();
        //"\n"줄바꿈 기호를 기준으로 각 줄을 분리합니다.
        StringTokenizer st = new StringTokenizer(comment, "\n");

        //줄수를 가져옵니다.         
        int count = st.countTokens();
        
        //버퍼에 첫번째 문자를 추가합니다.
        buffer.append(first);
        
        int i = 1;
        while(st.hasMoreTokens()){ 
            if(i==count){ //마지막 라인인지 검사
                buffer.append(st.nextToken());
            }else{ 
                buffer.append(st.nextToken()+ brTag);
            }
            i++;
        }
        return buffer.toString(); 
    }
    
    /**
     * html 태그 제거
     * @param val
     * @return
     */
    public static String delHtmlTag(String val){
    	String result="";
    	result=val.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","").replaceAll("\r|\n|&nbsp;","");
    	return result;
    }
    
    /**
     * 해당 int 에서 format을 적용하여 리턴
     * @param piValue
     * @return
     */
    public static String digitFormat(int piValue) {
        String str = new DecimalFormat("###,###,###").format( piValue );
        return str;
    }
    
    public static String digitFormat(long piValue) {
        String str = new DecimalFormat("###,###,###").format( piValue );
        return str;
    }
    
    public static String digitFormat(double piValue) {
        String str = new DecimalFormat("###,###,###.00").format( piValue );
        return str;
    }
    
    public static String digitFormat(double piValue, String format) {
        String str = new DecimalFormat(format).format( piValue );
        return str;
    }
    
    /**
     * 랜덤 패스워드 생성
     */
    public static String makeRandomPassword(){
    	
    	String newPassword = "";
    	
    	StringBuffer temp = new StringBuffer();
    	Random rnd = new Random();
    	for (int i = 0; i < 10; i++) {
    	    int rIndex = rnd.nextInt(3);
    	    switch (rIndex) {
    	    case 0:
    	    	// 0-9 숫자 0-9 출력하기
    	        temp.append((rnd.nextInt(10)));
    	        break;
    	        
    	    case 1:
    	    	// a-z  영소문자 a-z 출력하기 (아스키코드 97~122)
    	        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
    	        break;
    	    case 2:
    	    	// A-Z 영대문자 A-Z 출력하기 (아스키코드 65~122)
    	        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
    	        break;
    	    }
    	}
    	
    	newPassword = temp.toString();

    	return newPassword;
    	
    }
	
    /**
     * 사업자번호 - 포맷
     * @param bizNo
     * @return
     */
    public static String formatBizNo(String bizNo) {
    	return    StringUtils.isNotEmpty(bizNo)
    			? bizNo.replaceAll("(\\d{3})(\\d{2})(\\d{5})","$1-$2-$3")
    			: bizNo;
    }
    
    /*
     * SAP 전송을 위한 지역 코드 설정
     */
    public static String formatRegion(String str){
        
        if(str.matches(".*제주.*")){
            str = "01";
        }else if(str.matches(".*전북.*") || str.matches(".*전라북도.*")){
            str = "02";
        }
        else if(str.matches(".*전남.*") || str.matches(".*전라남도.*")){
            str = "03";
        }
        else if(str.matches(".*충북.*") || str.matches(".*충청북도.*")){
            str = "04";
        }
        else if(str.matches(".*충남.*") || str.matches(".*충청남도.*")){
            str = "05";
        }
        else if(str.matches(".*인천.*")){
            str = "06";
        }
        else if(str.matches(".*강원.*")){
            str = "07";
        }
        else if(str.matches(".*광주.*")){
            str = "08";
        }
        else if(str.matches(".*경기.*")){
            str = "09";
        }
        else if(str.matches(".*경북.*") || str.matches(".*경상북도.*")){
            str = "10";
        }
        else if(str.matches(".*경남.*") || str.matches(".*경상남도.*")){
            str = "11";
        }
        else if(str.matches(".*부산.*")){
            str = "12";
        }
        else if(str.matches(".*서울.*")){
            str = "13";
        }
        else if(str.matches(".*대구.*")){
            str = "14";
        }
        else if(str.matches(".*대전.*")){
            str = "15";
        }
        else if(str.matches(".*울산.*")){
            str = "16";
        }
        else if(str.matches(".*세종.*")){
            str = "17";
        }
        
        return str;
    }
    
    /**
     * 바이트 단위로 substring 한글 깨짐 방지.
     * @param str
     * @param cutlen
     * @param enc 인코딩
     * @return
     */
    public static String substringByte(String str, int cutlen, String enc) throws Exception{
    	if (str != null && !"".equals(str)) {
    		str = str.trim();
    		if (str.getBytes().length <= cutlen) {
    			return str;
    		}else {
    			StringBuffer sbStr = new StringBuffer(cutlen);
    			int nCnt = 0;
    			for(char ch : str.toCharArray()) {
    				nCnt += String.valueOf(ch).getBytes(StringUtils.defaultIfEmpty(enc, "MS949")).length;
    				if (nCnt > cutlen) break;
    				sbStr.append(ch);
    			}
    			return sbStr.toString();
    		}
    	}else {
    		return "";
    	}
    }
}
