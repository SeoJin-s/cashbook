package dto;

public class Paging {
	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getRowPerPage() {
		return rowPerPage;
	}

	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}

	@Override
	public String toString() {
		return "Paging [currentPage=" + currentPage + ", rowPerPage=" + rowPerPage + ", totalRow=" + totalRow
				+ ", totalPage=" + totalPage + ", startPage=" + startPage + ", endPage=" + endPage + ", pageBlock="
				+ pageBlock + ", searchType=" + searchType + ", searchWord=" + searchWord + ", orderBy=" + orderBy
				+ ", orderDir=" + orderDir + "]";
	}

	public int getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
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

	public int getPageBlock() {
		return pageBlock;
	}

	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getOrderDir() {
		return orderDir;
	}

	public void setOrderDir(String orderDir) {
		this.orderDir = orderDir;
	}

	private int currentPage;
	private int rowPerPage;
	private int totalRow;
	private int totalPage;
	
	private int startPage;
	private int endPage;
	private int pageBlock = 10;
	
	private String searchType;	// subject, name...
	private String searchWord;
	private String orderBy;		// subject, regdate..
	private String orderDir;	// asc, desc

	// 계산 메소드
	public void calculatePaging() {
		// 1) 전체 페이지 수
		totalPage = (int) Math.ceil((double) totalRow / rowPerPage);
		
		// 2) 현재 블럭 시작 / 끝 페이지 계산
		startPage = ((currentPage -1 ) / pageBlock) * pageBlock +1;
		endPage = startPage + pageBlock -1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
	}
	
	// sql 쿼리 offSSet 으로 사용할 beginRow
	public int getBeginRow() {
		return (currentPage -1) * rowPerPage;
	}
}
