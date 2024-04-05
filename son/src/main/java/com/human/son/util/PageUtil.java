package com.human.son.util;

public class PageUtil {
	private int nowPage;
	private int totalCount; // 총 게시글 갯수
	
	private int pageRow; // 한 페이지에 보여줄 게시글 갯수
	private int pageGroup; // 페이지당 이동 가능한 페이지 수
	
	private int startPage, endPage; // 화면에 표시될 시작페이지, 종료페이지
	private int totalPage; // 총 페이지 수
	
	private int startRno, endRno; // 페이지 시작 rownum, 마지막 rownum
	
	public PageUtil() {
	}
	public PageUtil(int nowPage, int totalCount) {
		this(nowPage, totalCount, 3, 3);
	}
	public PageUtil(int nowPage, int totalCount, int pageRow, int pageGroup) {
		this.nowPage = nowPage;
		this.totalCount = totalCount;
		this.pageRow = pageRow;
		this.pageGroup = pageGroup;
		calcTotalPage();
		calcPage();
		calcRno();
	}
	public void setPage() {
		setPage(nowPage, totalCount, 3, 3);
	}
	public void setPage(int nowPage, int totalCount) {
		setPage(nowPage, totalCount, 3, 3);
	}
	public void setPage(int nowPage, int totalCount, int pageRow, int pageGroup) {
		this.nowPage = nowPage;
		this.totalCount = totalCount;
		this.pageRow = pageRow;
		this.pageGroup = pageGroup;
		calcTotalPage();
		calcPage();
		calcRno();
	}
	public void calcTotalPage() {
		if(totalCount == 0) {
			totalPage = 1;
		}else {
			
		}
		totalPage = (totalCount % pageRow == 0) ? (totalCount / pageRow) : (totalCount / pageRow) + 1;
	}
	public void calcPage() {
		startPage = (nowPage - 1) / pageGroup * pageGroup + 1;
		endPage = (startPage - 1) + pageGroup;
		if(totalPage < endPage) {
			endPage = totalPage;
		}
	}
	public void calcRno() {
		startRno = (nowPage - 1) * pageRow + 1;
		endRno = (startRno + pageRow - 1);
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getPageRow() {
		return pageRow;
	}
	public void setPageRow(int pageRow) {
		this.pageRow = pageRow;
	}
	public int getPageGroup() {
		return pageGroup;
	}
	public void setPageGroup(int pageGroup) {
		this.pageGroup = pageGroup;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStartRno() {
		return startRno;
	}
	public void setStartRno(int startRno) {
		this.startRno = startRno;
	}
	public int getEndRno() {
		return endRno;
	}
	public void setEndRno(int endRno) {
		this.endRno = endRno;
	}

}
