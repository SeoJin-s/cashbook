package dto;

public class ReportData {
	private String kind;
	private int count;
	private int year;      // 연도별, 특정년도-월별 통계용
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	private int month;     // 월별, 특정년도-월별 통계용
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
	
	@Override
	public String toString() {
		return "ReportData [kind=" + kind + ", count=" + count + ", year=" + year + ", month=" + month + ", total="
				+ total + ", title=" + title + ", color=" + color + "]";
	}
}