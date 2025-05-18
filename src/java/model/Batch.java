package model;

public class Batch {
    private int batchId;
    private String batchName;
    private String academicYear;

    public Batch() {}

    public Batch(int batchId, String batchName, String academicYear) {
        this.batchId = batchId;
        this.batchName = batchName;
        this.academicYear = academicYear;
    }

    public int getBatchId() { return batchId; }
    public void setBatchId(int batchId) { this.batchId = batchId; }

    public String getBatchName() { return batchName; }
    public void setBatchName(String batchName) { this.batchName = batchName; }

    public String getAcademicYear() { return academicYear; }
    public void setAcademicYear(String academicYear) { this.academicYear = academicYear; }
}
