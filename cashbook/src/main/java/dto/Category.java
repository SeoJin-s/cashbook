package dto;

import java.time.LocalDateTime;

public class Category {
	private int categoryNo;           // PK: 자동 증가
	private String kind;              // 수입 or 지출
	private String title;             // 카테고리 제목
	private LocalDateTime createdate; // 생성일

	// ======= Getter / Setter =======

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public LocalDateTime getCreatedate() {
		return createdate;
	}

	// ✅ createdate도 select 조회 시 필요하므로 setter 유지
	public void setCreatedate(LocalDateTime createdate) {
		this.createdate = createdate;
	}

	@Override
	public String toString() {
		return "Category [categoryNo=" + categoryNo + ", kind=" + kind + ", title=" + title + ", createdate="
				+ createdate + "]";
	}
}