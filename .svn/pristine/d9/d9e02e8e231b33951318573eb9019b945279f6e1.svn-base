package com.app.ildong.common.util;

import org.apache.commons.lang.StringUtils;

import org.apache.commons.lang3.time.DateFormatUtils;

import com.ibm.icu.util.ChineseCalendar;


import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Date 에 대한 Util 클래스
 * 기능 제공
 */
public abstract class DateUtil {
	/**
     * <p>
     * yyyyMMdd 혹은 yyyy-MM-dd 형식의 날짜 문자열을 입력 받아 년, 월, 일을 증감한다. 년, 월, 일은 가감할 수를
     * 의미하며, 음수를 입력할 경우 감한다.
     * </p>
     *
     * <pre>
     * DateUtil.addYearMonthDay("19810828", 0, 0, 19)  = "19810916"
     * DateUtil.addYearMonthDay("20060228", 0, 0, -10) = "20060218"
     * DateUtil.addYearMonthDay("20060228", 0, 0, 10)  = "20060310"
     * DateUtil.addYearMonthDay("20060228", 0, 0, 32)  = "20060401"
     * DateUtil.addYearMonthDay("20050331", 0, -1, 0)  = "20050228"
     * DateUtil.addYearMonthDay("20050301", 0, 2, 30)  = "20050531"
     * DateUtil.addYearMonthDay("20050301", 1, 2, 30)  = "20060531"
     * DateUtil.addYearMonthDay("20040301", 2, 0, 0)   = "20060301"
     * DateUtil.addYearMonthDay("20040229", 2, 0, 0)   = "20060228"
     * DateUtil.addYearMonthDay("20040229", 2, 0, 1)   = "20060301"
     * </pre>
     *
     * @param sDate
     *            날짜 문자열(yyyyMMdd, yyyy-MM-dd의 형식)
     * @param year
     *            가감할 년. 0이 입력될 경우 가감이 없다
     * @param month
     *            가감할 월. 0이 입력될 경우 가감이 없다
     * @param day
     *            가감할 일. 0이 입력될 경우 가감이 없다
     * @return yyyyMMdd 형식의 날짜 문자열
     * @throws IllegalArgumentException
     *             날짜 포맷이 정해진 바와 다를 경우. 입력 값이 <code>null</code>인 경우.
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

        if (year != 0) {
            cal.add(Calendar.YEAR, year);
        }
        if (month != 0) {
            cal.add(Calendar.MONTH, month);
        }
        if (day != 0) {
            cal.add(Calendar.DATE, day);
        }

        return sdf.format(cal.getTime());
    }

    /**
     * <p>
     * yyyyMMdd 혹은 yyyy-MM-dd 형식의 날짜 문자열을 입력 받아 년을 증감한다. <code>year</code>는 가감할
     * 수를 의미하며, 음수를 입력할 경우 감한다.
     * </p>
     *
     * <pre>
     * DateUtil.addYear("20000201", 62)  = "20620201"
     * DateUtil.addYear("20620201", -62) = "20000201"
     * DateUtil.addYear("20040229", 2)   = "20060228"
     * DateUtil.addYear("20060228", -2)  = "20040228"
     * DateUtil.addYear("19000101", 200) = "21000101"
     * </pre>
     *
     * @param dateStr
     *            날짜 문자열(yyyyMMdd, yyyy-MM-dd의 형식)
     * @param year
     *            가감할 년. 0이 입력될 경우 가감이 없다
     * @return yyyyMMdd 형식의 날짜 문자열
     * @throws IllegalArgumentException
     *             날짜 포맷이 정해진 바와 다를 경우. 입력 값이 <code>null</code>인 경우.
     */
    public static String addYear(String dateStr, int year) {
        return addYearMonthDay(dateStr, year, 0, 0);
    }

    /**
     * <p>
     * yyyyMMdd 혹은 yyyy-MM-dd 형식의 날짜 문자열을 입력 받아 월을 증감한다. <code>month</code>는 가감할
     * 수를 의미하며, 음수를 입력할 경우 감한다.
     * </p>
     *
     * <pre>
     * DateUtil.addMonth("20010201", 12)  = "20020201"
     * DateUtil.addMonth("19800229", 12)  = "19810228"
     * DateUtil.addMonth("20040229", 12)  = "20050228"
     * DateUtil.addMonth("20050228", -12) = "20040228"
     * DateUtil.addMonth("20060131", 1)   = "20060228"
     * DateUtil.addMonth("20060228", -1)  = "20060128"
     * </pre>
     *
     * @param dateStr
     *            날짜 문자열(yyyyMMdd, yyyy-MM-dd의 형식)
     * @param month
     *            가감할 월. 0이 입력될 경우 가감이 없다
     * @return yyyyMMdd 형식의 날짜 문자열
     * @throws IllegalArgumentException
     *             날짜 포맷이 정해진 바와 다를 경우. 입력 값이 <code>null</code>인 경우.
     */
    public static String addMonth(String dateStr, int month) {
        return addYearMonthDay(dateStr, 0, month, 0);
    }

    /**
     * <p>
     * yyyyMMdd 혹은 yyyy-MM-dd 형식의 날짜 문자열을 입력 받아 일(day)를 증감한다. <code>day</code>는
     * 가감할 수를 의미하며, 음수를 입력할 경우 감한다.
     * 
     * 위에 정의된 addDays 메서드는 사용자가 ParseException을 반드시 처리해야 하는 불편함이 있기 때문에 추가된
     * 메서드이다.
     * </p>
     *
     * <pre>
     * DateUtil.addDay("19991201", 62) = "20000201"
     * DateUtil.addDay("20000201", -62) = "19991201"
     * DateUtil.addDay("20050831", 3) = "20050903"
     * DateUtil.addDay("20050831", 3) = "20050903"
     * // 2006년 6월 31일은 실제로 존재하지 않는 날짜이다 - 20060701로 간주된다
     * DateUtil.addDay("20060631", 1) = "20060702"
     * </pre>
     *
     * @param dateStr
     *            날짜 문자열(yyyyMMdd, yyyy-MM-dd의 형식)
     * @param day
     *            가감할 일. 0이 입력될 경우 가감이 없다
     * @return yyyyMMdd 형식의 날짜 문자열
     * @throws IllegalArgumentException
     *             날짜 포맷이 정해진 바와 다를 경우. 입력 값이 <code>null</code>인 경우.
     */
    public static String addDay(String dateStr, int day) {
        return addYearMonthDay(dateStr, 0, 0, day);
    }

    /**
     * <p>
     * yyyyMMdd 혹은 yyyy-MM-dd 형식의 날짜 문자열 <code>dateStr1</code>과 <code>
     * dateStr2</code> 사이의 일 수를 구한다.<br>
     * <code>dateStr2</code>가 <code>dateStr1</code> 보다 과거 날짜일 경우에는 음수를 반환한다. 동일한
     * 경우에는 0을 반환한다.
     * </p>
     *
     * <pre>
     * DateUtil.getDaysDiff("20060228","20060310") = 10
     * DateUtil.getDaysDiff("20060101","20070101") = 365
     * DateUtil.getDaysDiff("19990228","19990131") = -28
     * DateUtil.getDaysDiff("20060801","20060802") = 1
     * DateUtil.getDaysDiff("20060801","20060801") = 0
     * </pre>
     *
     * @param sDate1
     *            날짜 문자열(yyyyMMdd, yyyy-MM-dd의 형식)
     * @param sDate2
     *            날짜 문자열(yyyyMMdd, yyyy-MM-dd의 형식)
     * @return 일 수 차이.
     * @throws IllegalArgumentException
     *             날짜 포맷이 정해진 바와 다를 경우. 입력 값이 <code>null</code>인 경우.
     */
    public static int getDaysDiff(String sDate1, String sDate2) {
        String dateStr1 = validChkDate(sDate1);
        String dateStr2 = validChkDate(sDate2);

        if (!checkDate(sDate1) || !checkDate(sDate2)) {
            throw new IllegalArgumentException("Invalid date format: args[0]=" + sDate1 + " args[1]=" + sDate2);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

        Date date1;
        Date date2;
        try {
            date1 = sdf.parse(dateStr1);
            date2 = sdf.parse(dateStr2);
        } catch (ParseException e) {
            throw new IllegalArgumentException("Invalid date format: args[0]=" + dateStr1 + " args[1]=" + dateStr2);
        }

        return getDaysDiff(date1, date2);
    }

    public static int getDaysDiff(Date date1, Date date2) {
        if (null != date1 && null != date2) {
            int days1 = (int) ((date1.getTime() / 3600000) / 24);
            int days2 = (int) ((date2.getTime() / 3600000) / 24);
            return days2 - days1;
        } else {
            return 0;
        }
    }

    /**
     * <p>
     * yyyyMMdd 혹은 yyyy-MM-dd 형식의 날짜 문자열을 입력 받아 유효한 날짜인지 검사.
     * </p>
     *
     * <pre>
     * DateUtil.checkDate("1999-02-35") = false
     * DateUtil.checkDate("2000-13-31") = false
     * DateUtil.checkDate("2006-11-31") = false
     * DateUtil.checkDate("2006-2-28")  = false
     * DateUtil.checkDate("2006-2-8")   = false
     * DateUtil.checkDate("20060228")   = true
     * DateUtil.checkDate("2006-02-28") = true
     * </pre>
     *
     * @param sDate
     *            날짜 문자열(yyyyMMdd, yyyy-MM-dd의 형식)
     * @return 유효한 날짜인지 여부
     */
    public static boolean checkDate(String sDate) {
        String dateStr = validChkDate(sDate);

        String year = dateStr.substring(0, 4);
        String month = dateStr.substring(4, 6);
        String day = dateStr.substring(6);

        return checkDate(year, month, day);
    }

    /**
     * <p>
     * 입력한 년, 월, 일이 유효한지 검사.
     * </p>
     *
     * @param year
     *            연도
     * @param month
     *            월
     * @param day
     *            일
     * @return 유효한 날짜인지 여부
     */
    public static boolean checkDate(String year, String month, String day) {
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.getDefault());

            Date result = formatter.parse(year + "." + month + "." + day);
            String resultStr = formatter.format(result);
            if (resultStr.equalsIgnoreCase(year + "." + month + "." + day))
                return true;
            else
                return false;
        } catch (ParseException e) {
            return false;
        }
    }

    /**
     * 날짜형태의 String의 날짜 포맷 및 TimeZone을 변경해 주는 메서드
     *
     * @param strSource
     *            바꿀 날짜 String
     * @param fromDateFormat
     *            기존의 날짜 형태
     * @param toDateFormat
     *            원하는 날짜 형태
     * @param strTimeZone
     *            변경할 TimeZone(""이면 변경 안함)
     * @return 소스 String의 날짜 포맷을 변경한 String
     */
    public static String convertDate(String strSource, String fromDateFormat, String toDateFormat, String strTimeZone) {
        SimpleDateFormat simpledateformat = null;
        Date date = null;
        String fromFormat = "";
        String toFormat = "";

        if ("".equals(StringUtils.trimToEmpty(strSource))) {
            return "";
        }
        if ("".equals(StringUtils.trimToEmpty(fromDateFormat)))
            fromFormat = "yyyyMMddHHmmss"; // default값
        if ("".equals(StringUtils.trimToEmpty(toDateFormat)))
            toFormat = "yyyy-MM-dd HH:mm:ss"; // default값

        try {
            simpledateformat = new SimpleDateFormat(fromFormat, Locale.getDefault());
            date = simpledateformat.parse(strSource);
            if (! "".equals(StringUtils.trimToEmpty(strTimeZone))) {
                simpledateformat.setTimeZone(TimeZone.getTimeZone(strTimeZone));
            }
            simpledateformat = new SimpleDateFormat(toFormat, Locale.getDefault());
        } catch (ParseException exception) {
            throw new RuntimeException(exception);
        }

        return simpledateformat.format(date);

    }

    /**
     * yyyyMMdd 형식의 날짜문자열을 원하는 캐릭터(ch)로 쪼개 돌려준다
     * 
     * <pre>
     * ex) 20030405, ch(.) - 2003.04.05
     * ex) 200304, ch(.) - 2003.04
     * ex) 20040101,ch(/) -- 2004/01/01 로 리턴
     * </pre>
     *
     * @param sDate
     *            yyyyMMdd 형식의 날짜문자열
     * @param ch
     *            구분자
     * @return 변환된 문자열
     */
    public static String formatDate(String sDate, String ch) {
        String dateStr = validChkDate(sDate);

        String str = dateStr.trim();
        String yyyy = "";
        String mm = "";
        String dd = "";

        if (str.length() == 8) {
            yyyy = str.substring(0, 4);
            if (yyyy.equals("0000")) {
                return "";
            }

            mm = str.substring(4, 6);
            if (mm.equals("00")) {
                return yyyy;
            }

            dd = str.substring(6, 8);
            if (dd.equals("00")) {
                return yyyy + ch + mm;
            }

            return yyyy + ch + mm + ch + dd;

        } else if (str.length() == 6) {
            yyyy = str.substring(0, 4);
            if (yyyy.equals("0000")) {
                return "";
            }

            mm = str.substring(4, 6);
            if (mm.equals("00")) {
                return yyyy;
            }

            return yyyy + ch + mm;

        } else if (str.length() == 4) {
            yyyy = str.substring(0, 4);
            if (yyyy.equals("0000")) {
                return "";
            } else {
                return yyyy;
            }
        } else {
            return "";
        }
    }

    /**
     * HH24MISS 형식의 시간문자열을 원하는 캐릭터(ch)로 쪼개 돌려준다 <br>
     * 
     * <pre>
     *     ex) 151241, ch(/) - 15/12/31
     * </pre>
     *
     * @param sTime
     *            HH24MISS 형식의 시간문자열
     * @param ch
     *            구분자
     * @return 변환된 문자열
     */
    public static String formatTime(String sTime, String ch) {
        String timeStr = validChkTime(sTime);
        return timeStr.substring(0, 2) + ch + timeStr.substring(2, 4) + ch + timeStr.substring(4, 6);
    }

    /**
     * 연도를 입력 받아 해당 연도 2월의 말일(일수)를 문자열로 반환한다.
     *
     * @param year
     *            년도
     * @return 해당 연도 2월의 말일(일수)
     */
    public String leapYear(int year) {
        if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
            return "29";
        }

        return "28";
    }

    /**
     * <p>
     * 입력받은 연도가 윤년인지 아닌지 검사한다.
     * </p>
     *
     * <pre>
     * DateUtil.isLeapYear(2004) = false
     * DateUtil.isLeapYear(2005) = true
     * DateUtil.isLeapYear(2006) = true
     * </pre>
     *
     * @param year
     *            연도
     * @return 윤년 여부
     */
    public static boolean isLeapYear(int year) {
        if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
            return false;
        }
        return true;
    }

    /**
     * 현재(한국기준) 날짜정보를 얻는다. <BR>
     * 표기법은 yyyy-mm-dd <BR>
     * 
     * @return String yyyymmdd형태의 현재 한국시간. <BR>
     */
    public static String getToday() {
        return getCurrentDate("");
    }

    /**
     * 현재(한국기준) 날짜정보를 얻는다. 표기법은 yyyy-mm-dd
     * 
     * @param dateType
     *            날짜타입
     * @return String yyyymmdd형태의 현재 한국시간.
     */
    public static String getCurrentDate(String dateType) {
        Calendar aCalendar = Calendar.getInstance();

        int year = aCalendar.get(Calendar.YEAR);
        int month = aCalendar.get(Calendar.MONTH) + 1;
        int date = aCalendar.get(Calendar.DATE);
        String strDate = Integer.toString(year) + ((month < 10) ? "0" + Integer.toString(month) : Integer.toString(month)) + ((date < 10) ? "0" + Integer.toString(date) : Integer.toString(date));
        
        if (!"".equals(dateType)) {
            strDate = getCurrentDateTimeWithFormat(dateType);
        }

        return strDate;
    }
    
    /**
     * 현재(한국기준) 날짜정보를 얻는다. 표기법은 yyyy
     * 
     * @return String yyyymmdd형태의 현재 한국시간.
     */
    public static String getYear() {
        Calendar aCalendar = Calendar.getInstance();
        int year = aCalendar.get(Calendar.YEAR);
        return String.valueOf(year);
    }
    
    /**
     * 현재(한국기준) 날짜정보를 얻는다. 표기법은 mm
     * 
     * @return String yyyymmdd형태의 현재 한국시간.
     */
    public static String getMonth() {
        Calendar aCalendar = Calendar.getInstance();
        return StringUtils.leftPad(Integer.toString(aCalendar.get(Calendar.MONTH) + 1), 2, '0');
    }
    
    /**
     * 현재(한국기준) 날짜정보를 얻는다. 표기법은 dd
     * 
     * @return String yyyymmdd형태의 현재 한국시간.
     */
    public static String getDay() {
        Calendar aCalendar = Calendar.getInstance();
        return StringUtils.leftPad(Integer.toString(aCalendar.get(Calendar.DAY_OF_MONTH)), 2, '0');
    }

    /**
     * 날짜형태의 String의 날짜 포맷만을 변경해 주는 메서드
     * 
     * @param sDate
     *            날짜
     * @param sTime
     *            시간
     * @param sFormatStr
     *            포멧 스트링 문자열
     * @return 지정한 날짜/시간을 지정한 포맷으로 출력 Letter Date or Tim e Component
     *         Presentation Examples G Era designator Text AD y Year Year 1996;
     *         96 M Month in year Month July; Jul; 07 w Week in year Number 27 W
     *         Week in month Number 2 D Day in year Number 189 d Day in month
     *         Number 10 F Day of week in month Number 2 E Day in week Text
     *         Tuesday; Tue a Am/pm marker Text PM H Hour in day (0-23) Number 0
     *         k Hour in day (1-24) Number 24 K Hour in am/pm (0-11) Number 0 h
     *         Hour in am/pm (1-12) Number 12 m Minute in hour Number 30 s
     *         Second in minute Number 55 S Millisecond Number 978 z Time zone
     *         General time zone Pacific Standard Time; PST; GMT-08:00 Z Time
     *         zone RFC 822 time zone -0800 Date and Time Pattern Result
     *         "yyyy.MM.dd G 'at' HH:mm:ss z" 2001.07.04 AD at 12:08:56 PDT
     *         "EEE, MMM d, ''yy" Wed, Jul 4, '01 "h:mm a" 12:08 PM
     *         "hh 'o''clock' a, zzzz" 12 o'clock PM, Pacific Daylight Time
     *         "K:mm a, z" 0:08 PM, PDT "yyyyy.MMMMM.dd GGG hh:mm aaa"
     *         02001.July.04 AD 12:08 PM "EEE, d MMM yyyy HH:mm:ss Z" Wed, 4 Jul
     *         2001 12:08:56 -0700 "yyMMddHHmmssZ" 010704120856-0700
     */
    public static String convertDate(String sDate, String sTime, String sFormatStr) {
        String dateStr = validChkDate(sDate);
        String timeStr = validChkTime(sTime);

        Calendar cal = null;
        cal = Calendar.getInstance();

        cal.set(Calendar.YEAR, Integer.parseInt(dateStr.substring(0, 4)));
        cal.set(Calendar.MONTH, Integer.parseInt(dateStr.substring(4, 6)) - 1);
        cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(dateStr.substring(6, 8)));
        cal.set(Calendar.HOUR_OF_DAY, Integer.parseInt(timeStr.substring(0, 2)));
        cal.set(Calendar.MINUTE, Integer.parseInt(timeStr.substring(2, 4)));

        SimpleDateFormat sdf = new SimpleDateFormat(sFormatStr, Locale.ENGLISH);

        return sdf.format(cal.getTime());
    }

    /**
     * 입력받은 일자 사이의 임의의 일자를 반환
     * 
     * @param sDate1
     *            시작일자
     * @param sDate2
     *            종료일자
     * @return 임의일자
     */
    public static String getRandomDate(String sDate1, String sDate2) {
        String dateStr1 = validChkDate(sDate1);
        String dateStr2 = validChkDate(sDate2);

        String randomDate = null;

        int sYear, sMonth, sDay;
        int eYear, eMonth, eDay;

        sYear = Integer.parseInt(dateStr1.substring(0, 4));
        sMonth = Integer.parseInt(dateStr1.substring(4, 6));
        sDay = Integer.parseInt(dateStr1.substring(6, 8));

        eYear = Integer.parseInt(dateStr2.substring(0, 4));
        eMonth = Integer.parseInt(dateStr2.substring(4, 6));
        eDay = Integer.parseInt(dateStr2.substring(6, 8));

        GregorianCalendar beginDate = new GregorianCalendar(sYear, sMonth - 1, sDay, 0, 0);
        GregorianCalendar endDate = new GregorianCalendar(eYear, eMonth - 1, eDay, 23, 59);

        if (endDate.getTimeInMillis() < beginDate.getTimeInMillis()) {
            throw new IllegalArgumentException("Invalid input date : " + sDate1 + "~" + sDate2);
        }

        SecureRandom r = new SecureRandom();

        r.setSeed(new Date().getTime());

        long rand = ((r.nextLong() >>> 1) % (endDate.getTimeInMillis() - beginDate.getTimeInMillis() + 1)) + beginDate.getTimeInMillis();

        GregorianCalendar cal = new GregorianCalendar();
        // SimpleDateFormat calformat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat calformat = new SimpleDateFormat("yyyyMMdd", Locale.ENGLISH);
        cal.setTimeInMillis(rand);
        randomDate = calformat.format(cal.getTime());

        // 랜덤문자열를 리턴
        return randomDate;
    }

    /**
     * 입력받은 양력일자를 변환하여 음력일자로 반환
     * 
     * @param sDate
     *            양력일자
     * @return 음력일자
     */
    public static Map<String, String> toLunar(String sDate) {
        String dateStr = validChkDate(sDate);

        Map<String, String> hm = new HashMap<>();
        hm.put("day", "");
        hm.put("leap", "0");

        if (dateStr.length() != 8) {
            return hm;
        }

        Calendar cal;
        ChineseCalendar lcal;

        cal = Calendar.getInstance();
        lcal = new ChineseCalendar();

        cal.set(Calendar.YEAR, Integer.parseInt(dateStr.substring(0, 4)));
        cal.set(Calendar.MONTH, Integer.parseInt(dateStr.substring(4, 6)) - 1);
        cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(dateStr.substring(6, 8)));

        lcal.setTimeInMillis(cal.getTimeInMillis());

        String year = String.valueOf(lcal.get(ChineseCalendar.EXTENDED_YEAR) - 2637);
        String month = String.valueOf(lcal.get(ChineseCalendar.MONTH) + 1);
        String day = String.valueOf(lcal.get(ChineseCalendar.DAY_OF_MONTH));
        String leap = String.valueOf(lcal.get(ChineseCalendar.IS_LEAP_MONTH));

        String pad4Str = "0000";
        String pad2Str = "00";

        String retYear = (pad4Str + year).substring(year.length());
        String retMonth = (pad2Str + month).substring(month.length());
        String retDay = (pad2Str + day).substring(day.length());

        String SDay = retYear + retMonth + retDay;

        hm.put("day", SDay);
        hm.put("leap", leap);

        return hm;
    }

    /**
     * 입력받은 음력일자를 변환하여 양력일자로 반환
     * 
     * @param sDate
     *            음력일자
     * @param iLeapMonth
     *            음력윤달여부(IS_LEAP_MONTH)
     * @return 양력일자
     */
    public static String toSolar(String sDate, int iLeapMonth) {
        String dateStr = validChkDate(sDate);

        Calendar cal;
        ChineseCalendar lcal;

        cal = Calendar.getInstance();
        lcal = new ChineseCalendar();

        lcal.set(ChineseCalendar.EXTENDED_YEAR, Integer.parseInt(dateStr.substring(0, 4)) + 2637);
        lcal.set(ChineseCalendar.MONTH, Integer.parseInt(dateStr.substring(4, 6)) - 1);
        lcal.set(ChineseCalendar.DAY_OF_MONTH, Integer.parseInt(dateStr.substring(6, 8)));
        lcal.set(ChineseCalendar.IS_LEAP_MONTH, iLeapMonth);

        cal.setTimeInMillis(lcal.getTimeInMillis());

        String year = String.valueOf(cal.get(Calendar.YEAR));
        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        String pad4Str = "0000";
        String pad2Str = "00";

        String retYear = (pad4Str + year).substring(year.length());
        String retMonth = (pad2Str + month).substring(month.length());
        String retDay = (pad2Str + day).substring(day.length());

        return retYear + retMonth + retDay;
    }

    /**
     * 입력받은 요일의 영문명을 국문명의 요일로 반환
     * 
     * @param sWeek
     *            영문 요일명
     * @return 국문 요일명
     */
    public static String convertWeek(String sWeek) {
        String retStr = null;

        if (sWeek.equals("SUN")) {
            retStr = "일요일";
        } else if (sWeek.equals("MON")) {
            retStr = "월요일";
        } else if (sWeek.equals("TUE")) {
            retStr = "화요일";
        } else if (sWeek.equals("WED")) {
            retStr = "수요일";
        } else if (sWeek.equals("THR")) {
            retStr = "목요일";
        } else if (sWeek.equals("FRI")) {
            retStr = "금요일";
        } else if (sWeek.equals("SAT")) {
            retStr = "토요일";
        }

        return retStr;
    }

    /**
     * 입력일자의 유효 여부를 확인
     * 
     * @param sDate
     *            일자
     * @return 유효 여부
     */
    public static boolean validDate(String sDate) {
        String dateStr = validChkDate(sDate);

        Calendar cal;
        boolean ret = false;

        cal = Calendar.getInstance();

        cal.set(Calendar.YEAR, Integer.parseInt(dateStr.substring(0, 4)));
        cal.set(Calendar.MONTH, Integer.parseInt(dateStr.substring(4, 6)) - 1);
        cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(dateStr.substring(6, 8)));

        String year = String.valueOf(cal.get(Calendar.YEAR));
        String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        String pad4Str = "0000";
        String pad2Str = "00";

        String retYear = (pad4Str + year).substring(year.length());
        String retMonth = (pad2Str + month).substring(month.length());
        String retDay = (pad2Str + day).substring(day.length());

        String retYMD = retYear + retMonth + retDay;

        if (sDate.equals(retYMD)) {
            ret = true;
        }

        return ret;
    }

    /**
     * 입력일자, 요일의 유효 여부를 확인
     * 
     * @param sDate
     *            일자
     * @param sWeek
     *            요일 (DAY_OF_WEEK)
     * @return 유효 여부
     */
    public static boolean validDate(String sDate, int sWeek) {
        String dateStr = validChkDate(sDate);

        Calendar cal;
        boolean ret = false;

        cal = Calendar.getInstance();

        cal.set(Calendar.YEAR, Integer.parseInt(dateStr.substring(0, 4)));
        cal.set(Calendar.MONTH, Integer.parseInt(dateStr.substring(4, 6)) - 1);
        cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(dateStr.substring(6, 8)));

        int Week = cal.get(Calendar.DAY_OF_WEEK);

        if (validDate(sDate)) {
            if (sWeek == Week) {
                ret = true;
            }
        }

        return ret;
    }

    /**
     * 입력시간의 유효 여부를 확인
     * 
     * @param sTime
     *            입력시간
     * @return 유효 여부
     */
    public static boolean validTime(String sTime) {
        String timeStr = validChkTime(sTime);

        Calendar cal;
        boolean ret = false;

        cal = Calendar.getInstance();

        cal.set(Calendar.HOUR_OF_DAY, Integer.parseInt(timeStr.substring(0, 2)));
        cal.set(Calendar.MINUTE, Integer.parseInt(timeStr.substring(2, 4)));

        String HH = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
        String MM = String.valueOf(cal.get(Calendar.MINUTE));

        String pad2Str = "00";

        String retHH = (pad2Str + HH).substring(HH.length());
        String retMM = (pad2Str + MM).substring(MM.length());

        String retTime = retHH + retMM;

        if (sTime.equals(retTime)) {
            ret = true;
        }

        return ret;
    }

    /**
     * 입력된 일자에 연, 월, 일을 가감한 날짜의 요일을 반환
     * 
     * @param sDate
     *            날짜
     * @param year
     *            연
     * @param month
     *            월
     * @param day
     *            일
     * @return 계산된 일자의 요일(DAY_OF_WEEK)
     */
    public static String addYMDtoWeek(String sDate, int year, int month, int day) {
        String dateStr = validChkDate(sDate);

        dateStr = addYearMonthDay(dateStr, year, month, day);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.ENGLISH);
        try {
            cal.setTime(sdf.parse(dateStr));
        } catch (ParseException e) {
            throw new IllegalArgumentException("Invalid date format: " + dateStr);
        }

        SimpleDateFormat rsdf = new SimpleDateFormat("E", Locale.ENGLISH);

        return rsdf.format(cal.getTime());
    }

    /**
     * 입력된 일자에 연, 월, 일, 시간, 분을 가감한 날짜, 시간을 포멧스트링 형식으로 반환
     * 
     * @param sDate
     *            날짜
     * @param sTime
     *            시간
     * @param year
     *            연
     * @param month
     *            월
     * @param day
     *            일
     * @param hour
     *            시간
     * @param minute
     *            분
     * @param formatStr
     *            포멧스트링
     * @return 년월일시
     */
    public static String addYMDtoDayTime(String sDate, String sTime, int year, int month, int day, int hour, int minute, String formatStr) {
        String dateStr = validChkDate(sDate);
        String timeStr = validChkTime(sTime);

        dateStr = addYearMonthDay(dateStr, year, month, day);

        dateStr = convertDate(dateStr, timeStr, "yyyyMMddHHmm");

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm", Locale.ENGLISH);

        try {
            cal.setTime(sdf.parse(dateStr));
        } catch (ParseException e) {
            throw new IllegalArgumentException("Invalid date format: " + dateStr);
        }

        if (hour != 0) {
            cal.add(Calendar.HOUR, hour);
        }

        if (minute != 0) {
            cal.add(Calendar.MINUTE, minute);
        }

        SimpleDateFormat rsdf = new SimpleDateFormat(formatStr, Locale.ENGLISH);

        return rsdf.format(cal.getTime());
    }

    /**
     * 입력된 일자를 int 형으로 반환
     * 
     * @param sDate
     *            일자
     * @return int(일자)
     */
    public static int datetoInt(String sDate) {
        return Integer.parseInt(convertDate(sDate, "0000", "yyyyMMdd"));
    }

    /**
     * 입력된 시간을 int 형으로 반환
     * 
     * @param sTime
     *            시간
     * @return int(시간)
     */
    public static int timetoInt(String sTime) {
        return Integer.parseInt(convertDate("00000101", sTime, "HHmm"));
    }

    /**
     * 입력된 일자 문자열을 확인하고 8자리로 리턴
     * 
     * @param dateStr
     *            문자열
     * @return 문자열
     */
    public static String validChkDate(String dateStr) {
    	
    	if (dateStr.trim().equals("")) {
    		return dateStr;
    	}
    	
        if (dateStr == null || !(dateStr.trim().length() == 8 || dateStr.trim().length() == 10)) {
            throw new IllegalArgumentException("Invalid date format: " + dateStr);
        }

        if (dateStr.length() == 10) {
            return StringUtils.remove(dateStr, "-");
        }

        return dateStr;
    }

    /**
     * 입력된 일자 문자열을 확인하고 8자리로 리턴
     * 
     * @param timeStr
     *            시간문자열
     * @return 시간문자열
     */
    public static String validChkTime(String timeStr) {
        if (timeStr == null || !(timeStr.trim().length() == 6)) {
            throw new IllegalArgumentException("Invalid time format: " + timeStr);
        }

        if (timeStr.length() == 6) {
            timeStr = StringUtils.remove(timeStr, ':');
        }

        return timeStr;
    }

    /**
     * <p>
     * 특정 날짜를 인자로 받아 그 일자로부터 주어진 기간만큼 추가한 날을 계산하여 문자열로 리턴한다.
     * </p>
     * 
     * <pre>
     * String result = DateHelper.getCalcDateAsString(&quot;2004&quot;, &quot;10&quot;, &quot;30&quot;, 2, &quot;day&quot;);
     * </pre>
     * <p>
     * <code>result</code>는 "20041101"의 값을 갖는다.
     * </p>
     *
     * @param sYearPara
     *            년도
     * @param sMonthPara
     *            월
     * @param sDayPara
     *            일
     * @param iTerm
     *            기간
     * @param sGuBun
     *            구분("day":일에 기간을 더함,"month":월에 기간을 더함,"year":년에 기간을 더함.)
     * @return "년+월+일"
     */
    public static String getCalcDateAsString(String sYearPara, String sMonthPara, String sDayPara, int iTerm, String sGuBun) {
        Calendar cd = new GregorianCalendar(Integer.parseInt(sYearPara), Integer.parseInt(sMonthPara) - 1, Integer.parseInt(sDayPara));
        if ("day".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.DATE, iTerm);
        } else if ("month".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.MONTH, iTerm);
        } else if ("year".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.YEAR, iTerm);
        }

        return getFormalYear(cd) + getFormalMonth(cd) + getFormalDay(cd);
    }

    /**
     * 특정 날짜를 인자로 받아 그 일자로부터 주어진 기간만큼 추가한 날을 계산하여 문자열로 리턴한다.
     *
     * @param sDate
     * @param iTerm
     * @param sGuBun
     * @return
     */
    public static String getCalcDateAsString(String sDate, int iTerm, String sGuBun) {
        if (sDate == null || sDate.length() != 8)
            return null;
        return getCalcDateAsString(sDate.substring(0, 4), sDate.substring(4, 6), sDate.substring(6, 8), iTerm, sGuBun);

    }

    /**
     * <p>
     * 특정 날짜를 인자로 받아 그 일자로부터 주어진 기간만큼 추가한 날을 계산하여 년을 리턴한다.
     * </p>
     * 
     * <pre>
     * String result = DateHelper.getCalcYearAsString(&quot;2004&quot;, &quot;12&quot;, &quot;30&quot;, 2, &quot;day&quot;);
     * </pre>
     *
     * &lt;p&gt; &lt;code&gt;result&lt;/code&gt;는 &quot;2005&quot;의 값을 갖는다.
     * &lt;/p&gt;
     *
     * &#064;param sYearPara 년도 &#064;param sMonthPara 월 &#064;param sDayPara 일
     * &#064;param iTerm 기간 &#064;param sGuBun 구분(&quot;day&quot;:일에 기간을
     * 더함,&quot;month&quot;:월에 기간을 더함,&quot;year&quot;:년에 기간을 더함.)
     *
     * @return 년(年)
     */
    public static String getCalcYearAsString(String sYearPara, String sMonthPara, String sDayPara, int iTerm, String sGuBun) {
        Calendar cd = new GregorianCalendar(Integer.parseInt(sYearPara), Integer.parseInt(sMonthPara) - 1, Integer.parseInt(sDayPara));
        if ("day".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.DATE, iTerm);
        } else if ("month".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.MONTH, iTerm);
        } else if ("year".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.YEAR, iTerm);
        }

        return getFormalYear(cd);
    }

    /**
     * <p>
     * 특정 날짜를 인자로 받아 그 일자로부터 주어진 기간만큼 추가한 날을 계산하여 월을 리턴한다.
     * </p>
     * 
     * <pre>
     * String result = DateHelper.getCalcMonthAsString(&quot;2004&quot;, &quot;12&quot;, &quot;30&quot;, 2, &quot;day&quot;);
     * </pre>
     * <p>
     * <code>result</code>는 "01"의 값을 갖는다.
     * </p>
     *
     * @param sYearPara
     *            년도
     * @param sMonthPara
     *            월
     * @param sDayPara
     *            일
     * @param iTerm
     *            기간
     * @param sGuBun
     *            구분("day":일에 기간을 더함,"month":월에 기간을 더함,"year":년에 기간을 더함.)
     * @return 월(月)
     */
    public static String getCalcMonthAsString(String sYearPara, String sMonthPara, String sDayPara, int iTerm, String sGuBun) {
        Calendar cd = new GregorianCalendar(Integer.parseInt(sYearPara), Integer.parseInt(sMonthPara) - 1, Integer.parseInt(sDayPara));
        if ("day".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.DATE, iTerm);
        } else if ("month".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.MONTH, iTerm);
        } else if ("year".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.YEAR, iTerm);
        }
        return getFormalMonth(cd);
    }

    /**
     * <p>
     * 특정 날짜를 인자로 받아 그 일자로부터 주어진 기간만큼 추가한 날을 계산하여 일을 리턴한다.
     * </p>
     * 
     * <pre>
     * String result = DateHelper.getCalcDayAsString(&quot;2004&quot;, &quot;12&quot;, &quot;30&quot;, 3, &quot;day&quot;);
     * </pre>
     * <p>
     * <code>result</code>는 "02"의 값을 갖는다.
     * </p>
     *
     * @param sYearPara
     *            년도
     * @param sMonthPara
     *            월
     * @param sDayPara
     *            일
     * @param iTerm
     *            기간
     * @param sGuBun
     *            구분("day":일에 기간을 더함,"month":월에 기간을 더함,"year":년에 기간을 더함.)
     * @return 일(日)
     */
    public static String getCalcDayAsString(String sYearPara, String sMonthPara, String sDayPara, int iTerm, String sGuBun) {
        Calendar cd = new GregorianCalendar(Integer.parseInt(sYearPara), Integer.parseInt(sMonthPara) - 1, Integer.parseInt(sDayPara));
        if ("day".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.DATE, iTerm);
        } else if ("month".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.MONTH, iTerm);
        } else if ("year".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.YEAR, iTerm);
        }

        return getFormalDay(cd);
    }

    /**
     * <p>
     * 특정 날짜를 인자로 받아 그 일자로부터 주어진 기간만큼 추가한 날을 계산하여 년을 리턴한다.
     * </p>
     * 
     * <pre>
     * int result = DateHelper.getCalcYearAsInt(&quot;2004&quot;, &quot;12&quot;, &quot;30&quot;, 3, &quot;day&quot;);
     * </pre>
     * <p>
     * <code>result</code>는 2005의 값을 갖는다.
     * </p>
     *
     * @param sYearPara
     *            년도
     * @param sMonthPara
     *            월
     * @param sDayPara
     *            일
     * @param iTerm
     *            기간
     * @param sGuBun
     *            구분("day":일에 기간을 더함,"month":월에 기간을 더함,"year":년에 기간을 더함.)
     * @return 년(年)
     */
    public static int getCalcYearAsInt(String sYearPara, String sMonthPara, String sDayPara, int iTerm, String sGuBun) {

        Calendar cd = new GregorianCalendar(Integer.parseInt(sYearPara), Integer.parseInt(sMonthPara) - 1, Integer.parseInt(sDayPara));

        if ("day".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.DATE, iTerm);
        } else if ("month".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.MONTH, iTerm);
        } else if ("year".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.YEAR, iTerm);
        }

        return cd.get(Calendar.YEAR);
    }

    /**
     * <p>
     * 특정 날짜를 인자로 받아 그 일자로부터 주어일 기간만큼 추가한 날을 계산하여 월을 리턴한다.
     * </p>
     *
     * <pre>
     *
     *
     *
     *
     * int result = DateHelper.getCalcMonthAsInt(&quot;2004&quot;, &quot;12&quot;, &quot;30&quot;, 3, &quot;day&quot;);
     * </pre>
     * <p>
     * <code>result</code>는 1의 값을 갖는다.
     * </p>
     *
     * @param sYearPara
     *            년도
     * @param sMonthPara
     *            월
     * @param sDayPara
     *            일
     * @param iTerm
     *            기간
     * @param sGuBun
     *            구분("day":일에 기간을 더함,"month":월에 기간을 더함,"year":년에 기간을 더함.)
     * @return 월(月)
     */
    public static int getCalcMonthAsInt(String sYearPara, String sMonthPara, String sDayPara, int iTerm, String sGuBun) {

        Calendar cd = new GregorianCalendar(Integer.parseInt(sYearPara), Integer.parseInt(sMonthPara) - 1, Integer.parseInt(sDayPara));

        if ("day".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.DATE, iTerm);
        } else if ("month".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.MONTH, iTerm);
        } else if ("year".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.YEAR, iTerm);
        }

        return cd.get(Calendar.MONTH) + 1;
    }

    /**
     * <p>
     * 특정 날짜를 인자로 받아 그 일자로부터 주어일 기간만큼 추가한 날을 계산하여 일을 리턴한다.
     * </p>
     *
     * <pre>
     *
     *
     *
     *
     * int result = DateHelper.getCalcDayAsInt(&quot;2004&quot;, &quot;12&quot;, &quot;30&quot;, 3, &quot;day&quot;);
     * </pre>
     * <p>
     * <code>result</code>는 2의 값을 갖는다.
     * <p>
     *
     * @param sYearPara
     *            년도
     * @param sMonthPara
     *            월
     * @param sDayPara
     *            일
     * @param iTerm
     *            기간
     * @param sGuBun
     *            구분("day":일에 기간을 더함,"month":월에 기간을 더함,"year":년에 기간을 더함.)
     * @return 일(日)
     */
    public static int getCalcDayAsInt(String sYearPara, String sMonthPara, String sDayPara, int iTerm, String sGuBun) {

        Calendar cd = new GregorianCalendar(Integer.parseInt(sYearPara), Integer.parseInt(sMonthPara) - 1, Integer.parseInt(sDayPara));

        if ("day".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.DATE, iTerm);
        } else if ("month".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.MONTH, iTerm);
        } else if ("year".equals(StringUtils.defaultString(sGuBun))) {
            cd.add(Calendar.YEAR, iTerm);
        }

        return cd.get(Calendar.DAY_OF_MONTH);
    }

    /**
     * <p>
     * 현재 연도값을 리턴
     * </p>
     *
     * @return 년(年)
     */
    public static int getCurrentYearAsInt() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return cd.get(Calendar.YEAR);
    }

    /**
     * <p>
     * 현재 월을 리턴
     * </p>
     *
     * @return 월(月)
     */
    public static int getCurrentMonthAsInt() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return cd.get(Calendar.MONTH) + 1;
    }

    /**
     * <p>
     * 현재 일을 리턴
     * </p>
     *
     * @return 일(日)
     */
    public static int getCurrentDayAsInt() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return cd.get(Calendar.DAY_OF_MONTH);
    }

    /**
     * <p>
     * 현재 시간을 리턴
     * </p>
     *
     * @return 시(時)
     */
    public static int getCurrentHourAsInt() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return cd.get(Calendar.HOUR_OF_DAY);
    }

    /**
     * <p>
     * 현재 분을 리턴
     * </p>
     *
     * @return 분(分)
     */
    public static int getCurrentMinuteAsInt() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return cd.get(Calendar.MINUTE);
    }

    /**
     * <p>
     * 현재 초를 리턴
     * </p>
     *
     * @return 밀리초
     */
    public static int getCurrentMilliSecondAsInt() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return cd.get(Calendar.MILLISECOND);
    }

    /**
     * <p>
     * 현재 년도를 YYYY 형태로 리턴
     * </p>
     *
     * @return 년도(YYYY)
     */
    public static String getCurrentYearAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalYear(cd);
    }

    /**
     * <P>
     * 현재 월을 MM 형태로 리턴
     * </p>
     *
     * @return 월(MM)
     */
    public static String getCurrentMonthAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalMonth(cd);
    }

    /**
     * <p>
     * 현재 일을 DD 형태로 리턴
     * </p>
     *
     * @return 일(DD)
     */
    public static String getCurrentDayAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalDay(cd);
    }

    /**
     * <p>
     * 현재 시간을 HH 형태로 리턴
     * </p>
     *
     * @return 시간(HH)
     */
    public static String getCurrentHourAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalHour(cd);
    }

    /**
     * <p>
     * 현재 분을 mm 형태로 리턴
     * </p>
     *
     * @return 분(mm)
     */
    public static String getCurrentMinuteAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalMin(cd);
    }

    /**
     * <p>
     * 현재 초를 ss 형태로 리턴
     * </p>
     *
     * @return 초(ss)
     */
    public static String getCurrentSecondAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalSec(cd);
    }

    /**
     * <p>
     * 현재 밀리초를 sss 형태로 리턴
     * </p>
     *
     * @return 밀리초(sss)
     */
    public static String getCurrentMilliSecondAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalMSec(cd);
    }

    /**
     * <p>
     * 현재 날짜를 년월일을 합쳐서 String으로 리턴하는 메소드
     * </p>
     *
     * @return 년+월+일 값
     */
    public static String getCurrentDateAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalYear(cd) + getFormalMonth(cd) + getFormalDay(cd);
    }

    /**
     * <p>
     * 현재 시간을 시분초를 합쳐서 String으로 리턴하는 메소드
     * </p>
     *
     * @return 시+분+초 값
     */
    public static String getCurrentTimeAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalHour(cd) + getFormalMin(cd) + getFormalSec(cd);
    }

    public static String getCurrentDateTimeWithFormat(String format) {
        Calendar cd = new GregorianCalendar(Locale.KOREA);
        return DateFormatUtils.format(cd.getTime(), format);
    }

    /**
     * <p>
     * 현재 날짜와 시간을 년월일시분초를 합쳐서 String으로 리턴하는 메소드
     * </p>
     *
     * @return 년+월+일+시+분+초 값
     */
    public static String getCurrentDateTimeAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalYear(cd) + getFormalMonth(cd) + getFormalDay(cd) + getFormalHour(cd) + getFormalMin(cd) + getFormalSec(cd);
    }
    
    /**
     * <p>
     * 현재 날짜와 시간을 년월일시분초 millis 를 합쳐서 String으로 리턴하는 메소드
     * </p>
     *
     * @return 년+월+일+시+분+초 값
     */
    public static String getCurrentDateTimeMillisAsString() {

        Calendar cd = new GregorianCalendar(Locale.KOREA);

        return getFormalYear(cd) + "/" + getFormalMonth(cd) + "/" + getFormalDay(cd) + " " + getFormalHour(cd) + ":" + getFormalMin(cd) + ":" + getFormalSec(cd) + " " + getFormalMSec(cd) +"(MIPS)";
    }

    /**
     * <p>
     * 해당 년,월,일을 받아 요일을 리턴하는 메소드
     * </p>
     *
     * @param sYear
     *            년도
     * @param sMonth
     *            월
     * @param sDay
     *            일
     * @return 요일(한글)
     */
    public static String getDayOfWeekAsString(String sYear, String sMonth, String sDay) {

        Calendar cd = new GregorianCalendar(Integer.parseInt(sYear), Integer.parseInt(sMonth) - 1, Integer.parseInt(sDay));

        SimpleDateFormat sdf = new SimpleDateFormat("EEE", Locale.KOREA); // "EEE"
        // -
        // Day
        // in
        // Week

        Date d1 = cd.getTime();

        return sdf.format(d1);
    }

    /**
     * <p>
     * 해당 대상자에 대해 기준일자에서의 만 나이를 구한다.
     * </p>
     *
     * <pre>
     *
     *
     *
     *
     * int age = DateHelper.getFullAge(&quot;7701011234567&quot;, &quot;20041021&quot;);
     * </pre>
     * <p>
     * <code>age</code>는 27의 값을 갖는다.
     * </p>
     *
     * @param socialNo
     *            주민번호 13자리
     * @param keyDate
     *            기준일자 8자리
     * @return 만 나이
     */
    public static int getFullAge(String socialNo, String keyDate) {

        String birthDate = null;

        // 주민번호 7번째 자리가 0 또는 9 라면 1800년도 출생이다.
        if (StringUtils.equals(StringUtils.substring(socialNo, 6, 7), "0") || StringUtils.equals(StringUtils.substring(socialNo, 6, 7), "9")) {
            birthDate = "18" + socialNo.substring(0, 6);
        }

        // 주민번호 7번째 자리가 1 또는 2 라면 1900년도 출생이다.
        else if (StringUtils.equals(StringUtils.substring(socialNo, 6, 7), "1") || StringUtils.equals(StringUtils.substring(socialNo, 6, 7), "2")) {
            birthDate = "19" + socialNo.substring(0, 6);
        }

        // 주민번호 7번째 자리가 3 또는 4 라면 2000년도 출생이다.
        else if (StringUtils.equals(StringUtils.substring(socialNo, 6, 7), "3") || StringUtils.equals(StringUtils.substring(socialNo, 6, 7), "4")) {
            birthDate = "20" + socialNo.substring(0, 6);
        }

        // 생일이 안지났을때 기준일자 년에서 생일년을 빼고 1년을 더뺀다.
        if (Integer.parseInt(keyDate.substring(4, 8)) < Integer.parseInt(birthDate.substring(4, 8))) {

            return Integer.parseInt(keyDate.substring(0, 4)) - Integer.parseInt(birthDate.substring(0, 4)) - 1;
        }

        // 생일이 지났을때 기준일자 년에서 생일년을 뺀다.
        else {

            return Integer.parseInt(keyDate.substring(0, 4)) - Integer.parseInt(birthDate.substring(0, 4));
        }
    }

    /**
     * <p>
     * 주민번호를 넘겨 현재 시점의 만 나이를 구한다.
     * </p>
     *
     * @param socialNo
     *            주민번호 6자리
     * @return 만 나이
     */
    public static int getCurrentFullAge(String socialNo) {

        // 현재일자를 구한다.
        String sCurrentDate = getCurrentYearAsString() + getCurrentMonthAsString() + getCurrentDayAsString();

        return getFullAge(socialNo, sCurrentDate);
    }

    /**
     * <p>
     * 해당 년의 특정월의 일자를 구한다.
     * </p>
     *
     * @param year
     *            년도4자리
     * @param month
     *            월 1자리 또는 2자리
     * @return 특정월의 일자
     */
    public static int getDayCountForMonth(int year, int month) {

        int[] DOMonth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }; // 평년
        int[] lDOMonth = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }; // 윤년

        if ((year % 4) == 0) {

            if ((year % 100) == 0 && (year % 400) != 0) {
                return DOMonth[month - 1];
            }

            return lDOMonth[month - 1];

        } else {
            return DOMonth[month - 1];
        }
    }

    // ****** 시작일자와 종료일자 사이의 일자를 구하는 메소드군 *******//

    /**
     * <p>
     * 8자리로된(yyyyMMdd) 시작일자와 종료일자 사이의 일수를 구함.
     * </p>
     *
     * @param from
     *            8자리로된(yyyyMMdd)시작일자
     * @param to
     *            8자리로된(yyyyMMdd)종료일자
     * @return 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 일수 리턴
     * @throws ParseException
     *             형식이 잘못 되었거나 존재하지 않는 날짜인 경우 발생함
     */
    public static int getDayCount(String from, String to) throws ParseException {

        return getDayCountWithFormatter(from, to, "yyyyMMdd");
    }

    /**
     * <p>
     * 해당 문자열이 "yyyyMMdd" 형식에 합당한지 여부를 판단하여 합당하면 Date 객체를 리턴한다.
     * </p>
     *
     * @param source
     *            대상 문자열
     * @return "yyyyMMdd" 형식에 맞는 Date 객체를 리턴한다.
     * @throws ParseException
     *             형식이 잘못 되었거나 존재하지 않는 날짜인 경우 발생함
     */
    public static Date dateFormatCheck(String source) throws ParseException {

        return dateFormatCheck(source, "yyyyMMdd");
    }

    /**
     * <p>
     * 해당 문자열이 주어진 일자 형식을 준수하는지 여부를 검사한다.
     * </p>
     *
     * @param source
     *            검사할 대상 문자열
     * @param format
     *            Date 형식의 표현. 예) "yyyy-MM-dd".
     * @return 형식에 합당하는 경우 Date 객체를 리턴한다.
     * @throws ParseException
     *             형식이 잘못 되었거나 존재하지 않는 날짜인 경우 발생함
     */
    public static Date dateFormatCheck(String source, String format) throws ParseException {

        if (source == null) {
            throw new ParseException("date string to check is null", 0);
        }

        if (format == null) {
            throw new ParseException("format string to check date is null", 0);
        }

        SimpleDateFormat formatter = new SimpleDateFormat(format, Locale.KOREA);

        Date date = null;

        try {
            date = formatter.parse(source);
        } catch (ParseException e) {
            throw new ParseException(" wrong date:\"" + source + "\" with format \"" + format + "\"", 0);
        }

        if (!formatter.format(date).equals(source)) {
            throw new ParseException("Out of bound date:\"" + source + "\" with format \"" + format + "\"", 0);
        }

        return date;
    }

    /**
     * <p>
     * 정해진 일자 형식을 기반으로 시작일자와 종료일자 사이의 일자를 구한다.
     * </p>
     *
     * @param from
     *            시작 일자
     * @param to
     *            종료 일자
     * @return 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 일수를 리턴
     * @throws ParseException
     *             형식이 잘못 되었거나 존재하지 않는 날짜인 경우 발생함
     * @see #getTimeCount(String, String, String)
     */
    public static int getDayCountWithFormatter(String from, String to, String format) throws ParseException {

        long duration = getTimeCount(from, to, format);

        return (int) (duration / (1000 * 60 * 60 * 24));
    }

    /**
     * <p>
     * DATE 문자열을 이용한 format string을 생성
     * </p>
     *
     * @param date
     *            Date 문자열
     * @return Java.text.DateFormat 부분의 정규 표현 문자열
     * @throws ParseException
     *             형식이 잘못 되었거나 존재하지 않는 날짜인 경우 발생함
     */
    protected static String getFormatStringWithDate(String date) throws ParseException {
        String format = null;

        if (date.length() == 4) {
            format = "HHmm";
        } else if (date.length() == 8) {
            format = "yyyyMMdd";
        } else if (date.length() == 12) {
            format = "yyyyMMddHHmm";
        } else if (date.length() == 14) {
            format = "yyyyMMddHHmmss";
        } else if (date.length() == 17) {
            format = "yyyyMMddHHmmssSSS";
        } else {
            throw new ParseException(" wrong date format!:\"" + format + "\"", 0);
        }

        return format;
    }

    /**
     * <p>
     * <code>yyyyMMddHHmmssSSS</code> 와 같은 Format 문자열 없이 시작 일자 시간, 끝 일자 시간을
     * </p>
     *
     * @param from
     *            시작일자
     * @param to
     *            끝일자
     * @return 두 일자 간의 차의 밀리초(long)값
     * @throws ParseException
     *             형식이 잘못 되었거나 존재하지 않는 날짜인 경우 발생함
     * @see #getFormatStringWithDate(String)
     */
    public static long getTimeCount(String from, String to) throws ParseException {

        String format = getFormatStringWithDate(from);

        return getTimeCount(from, to, format);
    }

    /**
     * <p>
     * 정해진 일자 형식을 기반으로 시작일자와 종료일자 사이의 일자를 구한다.
     * </p>
     *
     * <pre>
     * Symbol   Meaning                 Presentation        Example
     * ------   -------                 ------------        -------
     * G        era designator          (Text)              AD
     * y        year                    (Number)            1996
     * M        month in year           (Text &amp; Number)     July &amp; 07
     * d        day in month            (Number)            10
     * h        hour in am/pm (1&tilde;12)    w(Number)            12
     * H        hour in day (0&tilde;23)      (Number)            0
     * m        minute in hour          (Number)            30
     * s        second in minute        (Number)            55
     * S        millisecond             (Number)            978
     * E        day in week             (Text)              Tuesday
     * D        day in year             (Number)            189
     * F        day of week in month    (Number)            2 (2nd Wed in July)
     * w        week in year            (Number)            27
     * W        week in month           (Number)            2
     * a        am/pm marker            (Text)              PM
     * k        hour in day (1&tilde;24)      (Number)            24
     * K        hour in am/pm (0&tilde;11)    (Number)            0
     * z        time zone               (Text)              Pacific Standard Time
     * '        escape for text         (Delimiter)
     * ''       single quote            (Literal)           '
     * </pre>
     *
     * @param from
     *            시작 일자
     * @param to
     *            종료 일자
     * @param format
     * @return 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 일수를 리턴
     * @throws ParseException
     *             형식이 잘못 되었거나 존재하지 않는 날짜인 경우 발생함
     */
    public static long getTimeCount(String from, String to, String format) throws ParseException {

        Date d1 = dateFormatCheck(from, format);
        Date d2 = dateFormatCheck(to, format);

        long duration = d2.getTime() - d1.getTime();

        return duration;
    }

    /**
     * <p>
     * 시작일자와 종료일자 사이의 해당 요일이 몇번 있는지 계산한다.
     * </p>
     *
     * @param from
     *            시작 일자
     * @param to
     *            종료 일자
     * @param yoil
     *            요일
     * @return 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 일자 리턴
     * @throws ParseException
     *             발생. 형식이 잘못 되었거나 존재하지 않는 날짜
     */
    public static int getDayOfWeekCount(String from, String to, String yoil) throws ParseException {

        int first = 0; // from 날짜로 부터 며칠 후에 해당 요일인지에 대한
        // 변수
        int count = 0; // 해당 요일이 반복된 횟수
        String[] sYoil = { "일", "월", "화", "수", "목", "금", "토" };

        // 두 일자 사이의 날 수
        int betweenDays = getDayCount(from, to);

        // 첫번째 일자에 대한 요일
        Calendar cd = new GregorianCalendar(Integer.parseInt(from.substring(0, 4)), Integer.parseInt(from.substring(4, 6)) - 1, Integer.parseInt(from.substring(6, 8)));
        int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);

        // 요일이 3자리이면 첫자리만 취한다.
        if (yoil.length() == 3) {
            yoil = yoil.substring(0, 1);

            // 첫번째 해당 요일을 찾는다.
        }

        // bug fixed 2009.03.23
        // while (!sYoil[dayOfWeek - 1].equals(yoil)) {
        while (!sYoil[(dayOfWeek - 1) % 7].equals(yoil)) {
            dayOfWeek += 1;
            first++;
        }

        if ((betweenDays - first) < 0) {

            return 0;

        } else {

            count++;

        }
        count += (betweenDays - first) / 7;

        return count;
    }

    /**
     * <p>
     * 년도 표시를 네자리로 형식화 한다.
     * </p>
     *
     * @param cd
     *            년도를 포함하는 <strong>Calendar</strong> 오브젝트
     * @return 네자리로 형식화된 년도
     */
    private static String getFormalYear(Calendar cd) {
        return StringUtils.leftPad(Integer.toString(cd.get(Calendar.YEAR)), 4, '0');
    }

    /**
     * <p>
     * 월(Month) 표시를 두자리로 형식화 한다.
     * </p>
     *
     * @param cd
     *            월을 포함하는 <strong>Calendar</strong> 오브젝트
     * @return 두자리로 형식화된 월
     */
    private static String getFormalMonth(Calendar cd) {
        return StringUtils.leftPad(Integer.toString(cd.get(Calendar.MONTH) + 1), 2, '0');
    }

    /**
     * <p>
     * 일(Day) 표시를 두자리로 형식화 한다.
     * </p>
     *
     * @param cd
     *            일자를 포함하는 <strong>Calendar</strong> 오브젝트
     * @return 두자리로 형식화된 일
     */
    private static String getFormalDay(Calendar cd) {
        return StringUtils.leftPad(Integer.toString(cd.get(Calendar.DAY_OF_MONTH)), 2, '0');
    }

    /**
     * <p>
     * 시간(Hour) 표시를 두자리로 형식화 한다.
     * </p>
     *
     * @param cd
     *            시간을 포함하는 <strong>Calendar</strong> 오브젝트
     * @return 두자리로 형식화된 시간
     */
    private static String getFormalHour(Calendar cd) {
        return StringUtils.leftPad(Integer.toString(cd.get(Calendar.HOUR_OF_DAY)), 2, '0');

    }

    /**
     * <p>
     * 분(Minute) 표시를 두자리로 형식화 한다.
     * </p>
     *
     * @param cd
     *            분을 포함하는 <strong>Calendar</strong> 오브젝트
     * @return 두자리로 형식화된 분
     */
    private static String getFormalMin(Calendar cd) {
        return StringUtils.leftPad(Integer.toString(cd.get(Calendar.MINUTE)), 2, '0');

    }

    /**
     * <p>
     * 초(sec) 표시를 두자리로 형식화 한다.
     * </p>
     *
     * @param cd
     *            초를 포함하는 <strong>Calendar</strong> 오브젝트
     * @return 두자리로 형식화된 초
     */
    private static String getFormalSec(Calendar cd) {
        return StringUtils.leftPad(Integer.toString(cd.get(Calendar.SECOND)), 2, '0');

    }

    /**
     * <p>
     * 밀리초(millisec) 표시를 세자리로 형식화 한다.
     * </p>
     *
     * @param cd
     *            밀리초를 포함하는 <strong>Calendar</strong> 오브젝트
     * @return 세자리로 형식화된 밀리초
     */
    private static String getFormalMSec(Calendar cd) {
        return StringUtils.leftPad(Integer.toString(cd.get(Calendar.MILLISECOND)), 3, '0');

    }

    /**
     * <p>
     * Date -&gt; String
     * </p>
     *
     * @param date
     *            Date which you want to change.
     * @return String The Date string. Type, yyyyMMdd HH:mm:ss.
     */
    public static String toString(Date date, String format, Locale locale) {

        if (StringUtils.isEmpty(format)) {
            format = "yyyy-MM-dd HH:mm:ss";
        }

        if (locale == null) {
            locale = java.util.Locale.KOREA;
        }

        SimpleDateFormat sdf = new SimpleDateFormat(format, locale);

        String tmp = sdf.format(date);

        return tmp;
    }

    /*
     * 기존 꺼 가져옴
     */
    public static String getFormatHanString(String s) {
        if (s == null || "".equals(s)) {
            return "";
        } else {
            String yyyy = s.substring(0, 4);
            String mm = s.substring(4, 6);
            String dd = s.substring(6, 8);
            String s1 = yyyy + "년  " + mm + "월 " + dd + "일";
            return s1;
        }
    }

    /*
     * 기존 꺼 가져옴
     */
    public static String getFormatHanString(String s, String type) {
        String s1 = "";
        if (type.toUpperCase().equals("YYYYMMDD")) {
            s1 = s.substring(0, 4) + "년  " + s.substring(4, 6) + "월 " + s.substring(6, 8) + "일";
        } else if (type.toUpperCase().equals("YYYYMMDDHH")) {
            s1 = s.substring(0, 4) + "년  " + s.substring(4, 6) + "월 " + s.substring(6, 8) + "일 " + s.substring(8, 10) + "시";
        } else if (type.toUpperCase().equals("YYYYMMDDHHMI")) {
            s1 = s.substring(0, 4) + "년  " + s.substring(4, 6) + "월 " + s.substring(6, 8) + "일 " + s.substring(8, 10) + "시 " + s.substring(10, 12) + "분";
        } else if (type.toUpperCase().equals("YYYYMMDDHHMISS")) {
            s1 = s.substring(0, 4) + "년  " + s.substring(4, 6) + "월 " + s.substring(6, 8) + "일 " + s.substring(8, 10) + "시 " + s.substring(10, 12) + "분 " + s.substring(12, 14) + "초";
        }
        return s1;
    }

    /*
     * 기존 꺼 가져옴
     */
    public static String getFormatHanString14(String s) {
        String yyyy = s.substring(0, 4);
        String MM = s.substring(4, 6);
        String dd = s.substring(6, 8);
        String hh = s.substring(8, 10);
        String mm = s.substring(10, 12);
        String ss = s.substring(12, 14);
        String s1 = yyyy + "-" + MM + "-" + dd + "/" + hh + ":" + mm + ":" + ss + "";
        return s1;
    }

    /**
     * YYYYMMDD 형식의 날짜를 YY/MM/DD 형식의 날짜로 리턴
     */
    public static String getSlConvertDate(String date) {

        if (date == null || "".equals(date)) {
            return "";
        } else {
            date = date.replaceAll("-", "");
            return date.substring(2, 4) + "/" + date.substring(4, 6) + "/" + date.substring(6, 8);
        }

    }

    /**
     * YYYYMMDD 형식의 날짜를 YYYY-MM-DD 형식의 날짜로 리턴
     */
    public static String getDashConvertDate(String date) {

        if (date == null || "".equals(date)) {
            return "";
        } else {
            return date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8);
        }

    }

    public static String getDateString() {
        SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);

        return simpledateformat.format(new Date());
    }

    
    public static String getCurrentFirstMonthday(){

        String firstMonthDay=DateUtil.getCurrentYearAsString() + DateUtil.getCurrentMonthAsString() + "01";

        return firstMonthDay;
    }
    
    public static String getCurrentLastMonthday(){
        Calendar now = Calendar.getInstance();
        String month="";
        String lastMonthDay="";
        if (DateUtil.getCurrentMonthAsInt() < 10) {
            month ="0"+DateUtil.getCurrentMonthAsInt()+"";
        }else{
            month= DateUtil.getCurrentMonthAsInt()+"";
        }

        if (now.getActualMaximum(Calendar.DAY_OF_MONTH) < 10) {
            lastMonthDay ="0"+now.getActualMaximum(Calendar.DAY_OF_MONTH)+"";
        }else{
            lastMonthDay = now.getActualMaximum(Calendar.DAY_OF_MONTH)+"";
        }
        lastMonthDay = DateUtil.getCurrentYearAsString()+""+month+""+lastMonthDay;
        return lastMonthDay;
    }
    
    
    public static String getLastMonthday(String dateStr){
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

        Calendar cal = Calendar.getInstance();
        try {
            cal.setTime(sdf.parse(dateStr));
        } catch (ParseException e) {
            throw new IllegalArgumentException("Invalid date format: " + dateStr);
        }
        
        int year = cal.get(cal.YEAR);
        int month = cal.get(cal.MONTH) + 1;;
        int endDay = cal.getActualMaximum(cal.DAY_OF_MONTH);

        String lastMonthDay = sdf.format(cal.getTime()).substring(0, 6) + endDay;
        
       
        return lastMonthDay;
    }
    
    
    public static Date addDateMonth(int i) {
        Calendar calendar = Calendar.getInstance();
        Date date = new Date();
        try {
            calendar.setTime(date);
            calendar.add(2, i);
            date = calendar.getTime();

        } catch (Exception parseexception) {

        }

        return date;
    }

    public static String addDateMonth(String s, int i) {
        String s1 = null;
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyyMMdd");

        try {
            Date date = simpledateformat.parse(s);
            calendar.setTime(date);
            calendar.add(2, i);
            date = calendar.getTime();
            s1 = simpledateformat.format(date);
        } catch (ParseException parseexception) {
            s1 = s;
        }

        return s1;
    }

    /**
     * fromFormat 의 문자열을 toFormat 날짜 문자열로 변환
     */
    public static String getFormatString(String s) {
        SimpleDateFormat simpledateformat = new SimpleDateFormat(s, Locale.KOREA);
        String s1 = simpledateformat.format(new Date());

        return s1;
    }

    public static String getFormatString(String source, String toFormat) {

        return getFormatString(source, "yyyyMMdd", toFormat);
    }

    public static String getFormatString(String source, String fromFormat, String toFormat) {
        if (source == null || source.equals(""))
            return source;

        Date date = parse(source, fromFormat);

        SimpleDateFormat simpledateformat = new SimpleDateFormat(toFormat, Locale.KOREA);
        String s2 = simpledateformat.format(date);

        return s2;
    }

    /**
     * 주어진 패턴 형식의 날짜 문자열을 파싱하여 Date객체를 얻는다.
     * 
     * @param source
     * @param pattern
     * @return
     */
    public static java.util.Date parse(String source, String pattern) {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern, java.util.Locale.KOREA);

        java.util.Date result = null;

        try {
            result = sdf.parse(source);
        } catch (Exception e) {
            // logger.error(e);
        }
        return result;
    }

    
    
    /**
     * 해당 일자의 주 월요일 구하기 
     * 
     * @param source
     * @param pattern
     * @return
     */
    public static String getWeekMonday(String strDate ) {
    	String dateStr = validChkDate(strDate);

        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
        try {
            cal.setTime(sdf.parse(dateStr));
        } catch (ParseException e) {
            throw new IllegalArgumentException("Invalid date format: " + dateStr);
        }
    	
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
    	
        return sdf.format(cal.getTime());
    }
    
    /**
     * 현재일자의 주 월요일 구하기 
     * 
     * @param source
     * @param pattern
     * @return
     */
    public static String getMondayForCurrWeek( ) {
    	
    	return getWeekMonday(getToday());
    }    

    /**
     * 전월 1일 가져온다.
     */
    public static String getPrevMonthFirstDay() {
    	return addMonth(getToday(), -1).substring(0, 6) + "01";
    }
    
    /**
     * 현재월 1일 
     */
    public static String getMonthFirstDay() {
    	return getToday().substring(0, 6) + "01";
    }
    
    public static String getYearFirstDay() {
    	return getToday().substring(0, 4) + "0101";
    }
    
    /**
     * 날짜 형식의 문자열의 패턴을 바꾼다.
     * @param source
     * @param sourcePattern
     * @param targetPattern
     * @return
     */
    public static String changeFormat(String source, String sourcePattern, String targetPattern) {
    	SimpleDateFormat sdf1 = new SimpleDateFormat(sourcePattern, java.util.Locale.KOREA);
        SimpleDateFormat sdf2 = new SimpleDateFormat(targetPattern, java.util.Locale.KOREA);

        String result = "";

        try {
            java.util.Date date = sdf1.parse(source);
            result = sdf2.format(date);
        }
        catch (Exception e) {
           // logger.error(e);
        }
        return result;
    }    
    
    /**
     * 오늘 일자를 원하는 패턴으로 포맷한다.
     * @param pattern
     * @return
     */
    public static String format(String pattern) {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern, java.util.Locale.KOREA);
        return sdf.format(new java.util.Date());
    }    
    
    /**
     * 일자의 형식을 보이기 위한 형식으로 변환한다. "20001020" -> "2000년 10월 20일 "
     */
    static public String getDisplayYmd(String date){
        String str = "";
        date = StringUtil.getNull(date).trim();
        if (date.length() != 8)
        {
            return " ";
        }
        try
        {
            str = date.substring(0, 4) + "년 " + date.substring(4, 6) + "월 " + date.substring(6, 8) + "일 ";
        }
        catch (Exception e)
        {//Debug.trace("Lib200.getDisplayDate(" + date + ") Exception Return \"\"" + e);
        }
        return str;
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
