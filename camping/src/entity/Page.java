package entity;

public class Page {
	private int totalRecord = 0; 	// 전체 게시물 갯수
	private int numPerPage = 0; 	// 한페이지에 보여지는 게시물 갯수
	private int pagePerBlock = 0;	// 페이지의 한 블럭
	private int totalPage = 0; 		// 전체 페이지
	private int totalBlock = 0; 	// 전체 블럭
	private Integer nowPage = 0; 	// 현재 페이지
	private Integer nowBlock = 0; 	// 현재 블럭
	private int beginPerPage = 0; 	// 한페이지의 맨 위 게시물

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getNumPerPage() {
		return numPerPage;
	}

	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}

	public int getPagePerBlock() {
		return pagePerBlock;
	}

	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalBlock() {
		return totalBlock;
	}

	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}

	public Integer getNowPage() {
		return nowPage;
	}

	public void setNowPage(Integer nowPage) {
		this.nowPage = nowPage;
	}

	public Integer getNowBlock() {
		return nowBlock;
	}

	public void setNowBlock(Integer nowBlock) {
		this.nowBlock = nowBlock;
	}

	public int getBeginPerPage() {
		return beginPerPage;
	}

	public void setBeginPerPage(int beginPerPage) {
		this.beginPerPage = beginPerPage;
	}

}
