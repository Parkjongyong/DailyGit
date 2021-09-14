package com.app.ildong.common.util;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ecbank.framework.constants.EcbankConstants;
import com.app.ildong.common.pagenation.PaginationInfo;
import com.app.ildong.common.vo.PageVO;


@Service("pageUtil")
public class PageUtil{
	/** 기본 페이지당 조회건수, client에서 rowPerPage 를 전송하지 않을 경우 사용함  */
	private static int defaultRowPerPage = 10;
	/** 기본 페이지 개수, 없으면  */
	private static int defaultPageSize = 10;
	
    /**
     * getPageInfo
     * <pre>
     * 조회된 총건수, VO를 바탕으로 
     *   PageNo(EcbankConstants.PAGE_NO), PageSize(EcbankConstants.PAGE_SIZE)
     * , TotalCnt(EcbankConstants.TOTAL_CNT),TotalPage(EcbankConstants.TOTAL_PAGE)를 구성하여 Map 을 Return 하며 
     * PageVO 에 ,firstRow,lastRow,totalCnt,totalPage 를 세팅한다 .
     * </pre>
     * @param totalCnt
     * @param vo
     * @return Map<String,Integer> (firstRow,lastRow,totalCnt,totalPage)
     */
    public static Map<String, Integer> getPageInfo(int totalCnt, PageVO vo) {
    	// Page 정보 구성
        Map<String, Integer> pageInfo = new HashMap<String, Integer>();
        if(vo.getRowPerPage() < 1){// 0 또는 음수라면
        	vo.setRowPerPage(defaultRowPerPage);
        }
        if(vo.getPageSize() < 1){
        	vo.setPageSize(defaultPageSize);
        }
        
        // 총 페이지 수
    	int totalPage = (int)Math.ceil((double)totalCnt / (double)vo.getRowPerPage());
    	/* 첫번째 row번호*/
    	int firstRow = (vo.getPageNo() - 1) * vo.getRowPerPage() + 1;
    	/* 마지막 row번호*/
    	int lastRow = 	vo.getPageNo() * vo.getRowPerPage();
    	 /* 한 화면의 시작 페이지 번호 */
    	int startPageNo = ((vo.getPageNo()) / vo.getPageSize())  * vo.getPageSize() + 1;
    	/* 한 화면의 끝 페이지 번호 */
    	int endPageNo = ((startPageNo + vo.getPageSize()-1) > totalPage) ? totalPage :  (firstRow + vo.getPageSize()-1);
    	
    	pageInfo.put(EcbankConstants.FIRST_ROW_INDEX, firstRow);
    	pageInfo.put(EcbankConstants.LAST_ROW_INDEX, lastRow);
    	pageInfo.put(EcbankConstants.TOTAL_CNT, totalCnt);
    	pageInfo.put(EcbankConstants.TOTAL_PAGE, totalPage);
    	pageInfo.put(EcbankConstants.PAGE_NO, vo.getPageNo());
    	pageInfo.put(EcbankConstants.PAGE_SIZE, vo.getPageSize());
    	pageInfo.put(EcbankConstants.START_PAGE_NO, startPageNo);
    	pageInfo.put(EcbankConstants.END_PAGE_NO, endPageNo);
    	pageInfo.put(EcbankConstants.ROW_PER_PAGE, vo.getRowPerPage());
    	
        vo.setFirstRowIndex(firstRow);
        vo.setLastRowIndex(lastRow);
        vo.setTotalCnt(totalCnt);
        vo.setTotalPage(totalPage);
        vo.setEndPageNo(endPageNo);
        return pageInfo;
    }
    
    /**
     * getPageInfo  
     * <pre>
     * Vo 미사용시 사용 
     * 조회된 총건수, RequestMap을 바탕으로 
     *   PageNo(EcbankConstants.PAGE_NO), PageSize(EcbankConstants.PAGE_SIZE)
     * , TotalCnt(EcbankConstants.TOTAL_CNT),TotalPage(EcbankConstants.TOTAL_PAGE)를 구성하여 Map 을 Return 하며 
     * Map 에 ,firstRow,lastRow,totalCnt,totalPage 를 세팅한다 .
     * </pre>
     * @param totalCnt
     * @param requestMap<String, Integer>
     * @return Map<String,Integer> (firstRow,lastRow,totalCnt,totalPage)
     */
 
    public static Map<String, Integer> getPageInfo(int totalCnt, Map<String, Integer> requestMap) {
    	int pageNo=1;
    	if(requestMap.containsKey(EcbankConstants.PAGE_NO)){
    		pageNo=(Integer)requestMap.get(EcbankConstants.PAGE_NO);
    	}
    	int rowPerPage=defaultRowPerPage;
    	if(requestMap.containsKey(EcbankConstants.ROW_PER_PAGE)){
    		rowPerPage=(Integer)requestMap.get(EcbankConstants.ROW_PER_PAGE);
    	}
    	int pageSize = defaultPageSize;
    	if(requestMap.containsKey(EcbankConstants.PAGE_SIZE)){
    		pageSize=(Integer)requestMap.get(EcbankConstants.PAGE_SIZE);
    	}
    	
        // 총 페이지 수
    	int totalPage = (int)Math.ceil((double)totalCnt / (double)rowPerPage);
    	/* 첫번째 row번호*/
    	int firstRow = (pageNo - 1) * rowPerPage + 1;
    	/* 마지막 row번호*/
    	int lastRow = 	pageNo * rowPerPage;
    	 /* 한 화면의 시작 페이지 번호 */
    	int startPageNo = (pageNo / pageSize)  * pageSize + 1;
    	/* 한 화면의 끝 페이지 번호 */
    	int endPageNo = ((startPageNo + pageSize -1) > totalPage) ? totalPage :  (firstRow + pageSize - 1);
    	
    	// Page 정보 구성 (client return 할 값)
    	Map<String, Integer> pageInfo=new HashMap<String,Integer>();
    	pageInfo.put(EcbankConstants.FIRST_ROW_INDEX, firstRow);
    	pageInfo.put(EcbankConstants.LAST_ROW_INDEX, lastRow);
    	pageInfo.put(EcbankConstants.TOTAL_CNT, totalCnt);
    	pageInfo.put(EcbankConstants.TOTAL_PAGE, totalPage);
    	pageInfo.put(EcbankConstants.PAGE_NO, pageNo);
    	pageInfo.put(EcbankConstants.END_PAGE_NO, endPageNo);
    	pageInfo.put(EcbankConstants.ROW_PER_PAGE, rowPerPage);
    	
    	requestMap.put(EcbankConstants.FIRST_ROW_INDEX, firstRow);
    	requestMap.put(EcbankConstants.LAST_ROW_INDEX, lastRow);
    	requestMap.put(EcbankConstants.TOTAL_CNT, totalCnt);
    	requestMap.put(EcbankConstants.TOTAL_PAGE, totalPage);
    	requestMap.put(EcbankConstants.END_PAGE_NO, endPageNo);
    	requestMap.put(EcbankConstants.ROW_PER_PAGE, rowPerPage);
    	
    	return pageInfo;
    }
    
    public static String renderPagination(PaginationInfo paginationInfo, String jsFunction) {
        String firstPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\" class=\"first\">&nbsp;</a>";
        String previousPageLabel = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\" class=\"prev\">&nbsp;</a>";
        String currentPageLabel  = "<a class=\"selected\">{0}</a>&#160;";
        String otherPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
        String nextPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\" class=\"next\">&nbsp;</a>";
        String lastPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1}); return false;\" class=\"last\">&nbsp;</a>";
        
        StringBuffer strBuff = new StringBuffer();

        int firstPageNo = paginationInfo.getFirstPageNo();
        int firstPageNoOnPageList = paginationInfo.getFirstPageNoOnPageList();
        int totalPageCount = paginationInfo.getTotalPageCount();
        int pageSize = paginationInfo.getPageSize();
        int lastPageNoOnPageList = paginationInfo.getLastPageNoOnPageList();
        int currentPageNo = paginationInfo.getCurrentPageNo();
        int lastPageNo = paginationInfo.getLastPageNo();

        if (totalPageCount > pageSize) {
            if (firstPageNoOnPageList > pageSize) {
                strBuff.append(MessageFormat.format(firstPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
                strBuff.append(MessageFormat.format(previousPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList - 1) }));
            } else {
                strBuff.append(MessageFormat.format(firstPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
                strBuff.append(MessageFormat.format(previousPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
            }
        }

        for (int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
            if (i == currentPageNo) {
                strBuff.append(MessageFormat.format(currentPageLabel, new Object[] { Integer.toString(i) }));
            } else {
                strBuff.append(MessageFormat.format(otherPageLabel, new Object[] { jsFunction, Integer.toString(i), Integer.toString(i) }));
            }
        }

        if (totalPageCount > pageSize) {
            if (lastPageNoOnPageList < totalPageCount) {
                strBuff.append(MessageFormat.format(nextPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNoOnPageList + pageSize) }));
                strBuff.append(MessageFormat.format(lastPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
            } else {
                strBuff.append(MessageFormat.format(nextPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
                strBuff.append(MessageFormat.format(lastPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
            }
        }
        return strBuff.toString();
    }
    
    @Value("${paging.defaultRowPerPage:10}")
	public void setDefaultRowPerPage(int defaultRowPerPage) {
        PageUtil.defaultRowPerPage = defaultRowPerPage;
	}
    
}
