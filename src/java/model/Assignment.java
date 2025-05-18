package model;

import java.util.Date;

public class Assignment {
    private int assignmentId;
    private int subjectId;
    private String title;
    private String description;
    private Date uploadDate;
    private Date dueDate;
    private String filePath;

    public Assignment() {}

    public Assignment(int assignmentId, int subjectId, String title, String description, Date uploadDate, Date dueDate, String filePath) {
        this.assignmentId = assignmentId;
        this.subjectId = subjectId;
        this.title = title;
        this.description = description;
        this.uploadDate = uploadDate;
        this.dueDate = dueDate;
        this.filePath = filePath;
    }

    public int getAssignmentId() { return assignmentId; }
    public void setAssignmentId(int assignmentId) { this.assignmentId = assignmentId; }

    public int getSubjectId() { return subjectId; }
    public void setSubjectId(int subjectId) { this.subjectId = subjectId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getUploadDate() { return uploadDate; }
    public void setUploadDate(Date uploadDate) { this.uploadDate = uploadDate; }

    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }
}