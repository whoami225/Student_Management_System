package model;

import java.util.Date;

public class Student {
    private int studentId;
    private int userId;
    private Date admissionDate;
    private int batchId;
    private String guardianName;
    private String address;

    // Default constructor
    public Student() {
    }

    // Constructor with all fields
    public Student(int studentId, int userId, Date admissionDate, int batchId, String guardianName, String address) {
        this.studentId = studentId;
        this.userId = userId;
        this.admissionDate = admissionDate;
        this.batchId = batchId;
        this.guardianName = guardianName;
        this.address = address;
    }

    // Getters and setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getAdmissionDate() {
        return admissionDate;
    }

    public void setAdmissionDate(Date admissionDate) {
        this.admissionDate = admissionDate;
    }

    public int getBatchId() {
        return batchId;
    }

    public void setBatchId(int batchId) {
        this.batchId = batchId;
    }

    public String getGuardianName() {
        return guardianName;
    }

    public void setGuardianName(String guardianName) {
        this.guardianName = guardianName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;


}