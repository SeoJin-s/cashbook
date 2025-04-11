package dto;

import java.time.LocalDateTime;

public class Receit {
    private int cashNo;
    private String filename;
    private LocalDateTime createdate;

    public int getCashNo() {
        return cashNo;
    }

    public void setCashNo(int cashNo) {
        this.cashNo = cashNo;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public LocalDateTime getCreatedate() {
        return createdate;
    }

    public void setCreatedate(LocalDateTime createdate) {
        this.createdate = createdate;
    }
}