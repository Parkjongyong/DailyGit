package com.app.ildong.common.vo;

public class PageVO {
    
    /** 총 조회건수 */
    private int totalCnt;
    /** 페이지 NO 1 부터 시작  */
    private int pageNo=1;
    /** 한 페이지당 조회 건수 */
    private int rowPerPage;
    /** 화면에 보여질 페이지 개수*/
    private int pageSize;
    /** 총 페이지 수 , int totalPage=  (int)Math.ceil(totalCnt/vo.getPageSize())  ; */
    private int totalPage;
    /** 한 화면에 보여줄 첫번째 Row */
    private int firstRowIndex;
    /** 한 화면에 보여줄 마지막 Row */
    private int lastRowIndex;
    /** 한 화면의 시작 페이지 번호 */
    private int startPageNo;
    /** 한 화면의 끝 페이지 번호 */
    private int endPageNo;
    
    public int getTotalCnt () {
        return totalCnt;
    }
    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }
    public int getPageNo() {
        return pageNo;
    }
    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }
    public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    public int getFirstRowIndex() {
        return firstRowIndex;
    }
    public void setFirstRowIndex(int firstRowIndex) {
        this.firstRowIndex = firstRowIndex;
    }
    public int getLastRowIndex() {
        return lastRowIndex;
    }
    public void setLastRowIndex(int lastRowIndex) {
        this.lastRowIndex = lastRowIndex;
    }    
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStartPageNo() {
        return startPageNo;
    }
    public void setStartPageNo(int startPageNo) {
        this.startPageNo = startPageNo;
    }
    public int getEndPageNo() {
        return endPageNo;
    }
    public void setEndPageNo(int endPageNo) {
        this.endPageNo = endPageNo;
    }
	@Override
	public String toString() {
		return "PageVO [totalCnt=" + totalCnt + ", pageNo=" + pageNo
				+ ", rowPerPage=" + rowPerPage + ", pageSize=" + pageSize
				+ ", totalPage=" + totalPage + ", firstRowIndex="
				+ firstRowIndex + ", lastRowIndex=" + lastRowIndex
				+ ", startPageNo=" + startPageNo + ", endPageNo=" + endPageNo
				+ "]";
	}
}
