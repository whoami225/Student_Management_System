package dao;

import java.sql.*;
import java.util.*;

public class GradeDAO {
    private Connection conn;

    public GradeDAO(Connection conn) {
        this.conn = conn;
    }

    public void addGrade(Grade grade) throws SQLException {
        String sql = "INSERT INTO grades (student_id, subject_id, marks, grade) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, grade.getStudentId());
            stmt.setInt(2, grade.getSubjectId());
            stmt.setDouble(3, grade.getMarks());
            stmt.setString(4, grade.getGrade());
            stmt.executeUpdate();
        }
    }

    public List<Grade> getGradesByStudentId(int studentId) throws SQLException {
        String sql = "SELECT * FROM grades WHERE student_id = ?";
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Grade grade = new Grade();
                grade.setGradeId(rs.getInt("grade_id"));
                grade.setStudentId(rs.getInt("student_id"));
                grade.setSubjectId(rs.getInt("subject_id"));
                grade.setMarks(rs.getDouble("marks"));
                grade.setGrade(rs.getString("grade"));
                grades.add(grade);
            }
        }
        return grades;
    }

    public List<Grade> getGradesBySubjectId(int subjectId) throws SQLException {
        String sql = "SELECT * FROM grades WHERE subject_id = ?";
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, subjectId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Grade grade = new Grade();
                grade.setGradeId(rs.getInt("grade_id"));
                grade.setStudentId(rs.getInt("student_id"));
                grade.setSubjectId(rs.getInt("subject_id"));
                grade.setMarks(rs.getDouble("marks"));
                grade.setGrade(rs.getString("grade"));
                grades.add(grade);
            }
        }
        return grades;
    }
}
