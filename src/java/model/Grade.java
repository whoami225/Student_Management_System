package model;

public class Grade {
    private int gradeId;
    private int studentId;
    private int subjectId;
    private double marks;
    private String grade;

    public Grade() {}

    public Grade(int gradeId, int studentId, int subjectId, double marks, String grade) {
        this.gradeId = gradeId;
        this.studentId = studentId;
        this.subjectId = subjectId;
        this.marks = marks;
        this.grade = grade;
    }

    public int getGradeId() { return gradeId; }
    public void setGradeId(int gradeId) { this.gradeId = gradeId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getSubjectId() { return subjectId; }
    public void setSubjectId(int subjectId) { this.subjectId = subjectId; }

    public double getMarks() { return marks; }
    public void setMarks(double marks) { this.marks = marks; }

    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }

    public void assignGradeFromMarks() {
        if (marks >= 90) grade = "A";
        else if (marks >= 75) grade = "B";
        else if (marks >= 60) grade = "C";
        else if (marks >= 40) grade = "D";
        else grade = "F";
    }

    @Override
    public String toString() {
        return "Grade{" +
                "gradeId=" + gradeId +
                ", studentId=" + studentId +
                ", subjectId=" + subjectId +
                ", marks=" + marks +
                ", grade='" + grade + '\'' +
                '}';
    }
}
