package dto;

public class ReportData {
	private String kind;
	private int count;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	private int total;
	private String title; // 카테고리명
	private String color; // 카테고리 색상

	public String getKind() { return kind; }
	public void setKind(String kind) { this.kind = kind; }
	public int getCount() { return count; }
	public void setCount(int count) { this.count = count; }
	public int getTotal() { return total; }
	public void setTotal(int total) { this.total = total; }
}