/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Attendance {
    private int attendanceId;
    private int studentId;
    private int subjectId;
    private String date;
    private boolean status; // true = Present, false = Absent

    // Getters and Setters
    public int getAttendanceId() { return attendanceId; }
    public void setAttendanceId(int attendanceId) { this.attendanceId = attendanceId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getSubjectId() { return subjectId; }
    public void setSubjectId(int subjectId) { this.subjectId = subjectId; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }
}

