package dao;

import model.Grade;
import controller.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GradeDAO {

    public boolean addGrade(Grade grade) throws ClassNotFoundException {
        String sql = "INSERT INTO grades (student_id, exam_id, marks_obtained) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, grade.getStudentId());
            ps.setInt(2, grade.getExamId());
            ps.setInt(3, grade.getMarksObtained());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Grade> getGradesByStudent(int studentId) throws ClassNotFoundException {
    List<Grade> grades = new ArrayList<>();
    String sql = "SELECT g.*, e.exam_date, e.total_marks, s.subject_name " +
                 "FROM grades g " +
                 "JOIN exams e ON g.exam_id = e.exam_id " +
                 "JOIN subjects s ON e.subject_id = s.subject_id " +
                 "WHERE g.student_id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, studentId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Grade grade = new Grade(
                rs.getInt("grade_id"),
                rs.getInt("student_id"),
                rs.getInt("exam_id"),
                rs.getInt("marks_obtained")
            );
            grade.setSubjectName(rs.getString("subject_name"));
            grade.setExamDate(rs.getDate("exam_date"));
            grade.setTotalMarks(rs.getInt("total_marks"));

            // Calculate percentage and grade letter
            int marks = rs.getInt("marks_obtained");
            int total = rs.getInt("total_marks");
            double percentage = total > 0 ? (marks * 100.0) / total : 0.0;
            grade.setPercentage(percentage);
            grade.setGradeLetter(getGradeLetter(percentage));

            grades.add(grade);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return grades;
}

// Helper method for grade letter
private String getGradeLetter(double percentage) {
    if (percentage >= 90) return "A";
    if (percentage >= 80) return "B";
    if (percentage >= 70) return "C";
    if (percentage >= 60) return "D";
    return "F";
}

}
