package dto;

import java.time.LocalDateTime;

public class Category {
	private int categoryNo; // DB에서 자동 부여되므로 set은 제거 가능
	private String kind;
	private String title;
	private LocalDateTime createdate;

	// getter만 남겨둠 (insert에서는 필요 없음, 조회 시 필요)
	public int getCategoryNo() {
		return categoryNo;
	}
	
	// ✅ 삭제하고 싶으면 아래 setter는 주석처리하거나 제거 가능
	// public void setCategoryNo(int categoryNo) {
	//     this.categoryNo = categoryNo;
	// }

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
	public void setCreatedate(LocalDateTime createdate) {
		this.createdate = createdate;
	}

	public void setCategoryNo(int int1) {
		// TODO Auto-generated method stub
		
	}
}