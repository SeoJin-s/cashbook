package dto;

import java.time.LocalDateTime;

public class Cash {
	private int cashNo;
	private String cashDate;
	private String kind;
	private int price;
	private String memo;
	private int categoryNo;
	private String categoryTitle;
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public String getCashDate() {
		return cashDate;
	}
	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryTitle() {
		return categoryTitle;
	}
	public void setCategoryTitle(String categoryTitle) {
		this.categoryTitle = categoryTitle;
	}
	public LocalDateTime getCreatedate() {
		return createdate;
	}
	public void setCreatedate(LocalDateTime createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "Cash [cashNo=" + cashNo + ", cashDate=" + cashDate + ", kind=" + kind + ", price=" + price + ", memo="
				+ memo + ", categoryNo=" + categoryNo + ", categoryTitle=" + categoryTitle + ", createdate="
				+ createdate + "]";
	}
	private LocalDateTime createdate;
	// getter/setter
}