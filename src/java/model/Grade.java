package model;

public class Grade {
    private int gradeId;
    private int studentId;
    private int examId;
    private int marksObtained;

    // New fields for report
    private String subjectName;
    private java.sql.Date examDate;
    private int totalMarks;
    private double percentage;
    private String gradeLetter;

    public Grade() {}

    public Grade(int gradeId, int studentId, int examId, int marksObtained) {
        this.gradeId = gradeId;
        this.studentId = studentId;
        this.examId = examId;
        this.marksObtained = marksObtained;
    }
    
    
    public int getMarksObtained() { return marksObtained; }
    public void setMarksObtained(int marksObtained) { this.marksObtained = marksObtained; }

    // Add this for JSP compatibility:
    public int getMarks() { return marksObtained; }

    
    // Getters and Setters
    public int getGradeId() { return gradeId; }
    public void setGradeId(int gradeId) { this.gradeId = gradeId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getExamId() { return examId; }
    public void setExamId(int examId) { this.examId = examId; }

    // New getters/setters
    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }

    public java.sql.Date getExamDate() { return examDate; }
    public void setExamDate(java.sql.Date examDate) { this.examDate = examDate; }

    public int getTotalMarks() { return totalMarks; }
    public void setTotalMarks(int totalMarks) { this.totalMarks = totalMarks; }

    public double getPercentage() { return percentage; }
    public void setPercentage(double percentage) { this.percentage = percentage; }

    public String getGradeLetter() { return gradeLetter; }
    public void setGradeLetter(String gradeLetter) { this.gradeLetter = gradeLetter; }
}
