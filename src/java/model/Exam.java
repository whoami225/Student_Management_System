package model;

import java.util.Date;

public class Exam {
    private int examId;
    private int courseId;
    private String examType;
    private int subjectId;
    private Date examDate;
    private int totalMarks;

    public Exam() {}

    public Exam(int examId, String examType, int courseId, int subjectId, Date examDate, int totalMarks) {
        this.examId = examId;
        this.examType = examType;
        this.courseId = courseId;
        this.subjectId = subjectId;
        this.examDate = examDate;
        this.totalMarks = totalMarks;
    }

    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }

    public int getExamId() { return examId; }
    public void setExamId(int examId) { this.examId = examId; }

    public String getExamType() { return examType; }
    public void setExamType(String examType) { this.examType = examType; }

    public int getSubjectId() { return subjectId; }
    public void setSubjectId(int subjectId) { this.subjectId = subjectId; }

    public Date getExamDate() { return examDate; }
    public void setExamDate(Date examDate) { this.examDate = examDate; }

    public int getTotalMarks() { return totalMarks; }
    public void setTotalMarks(int totalMarks) { this.totalMarks = totalMarks; }



}
