package dao;

import java.sql.*;
import java.util.*;
import model.Grade;
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

    public void updateGrade(Grade grade) throws SQLException {
        String sql = "UPDATE grades SET student_id = ?, subject_id = ?, marks = ?, grade = ? WHERE grade_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, grade.getStudentId());
            stmt.setInt(2, grade.getSubjectId());
            stmt.setDouble(3, grade.getMarks());
            stmt.setString(4, grade.getGrade());
            stmt.setInt(5, grade.getGradeId());
            stmt.executeUpdate();
        }
    }

    public void deleteGrade(int gradeId) throws SQLException {
        String sql = "DELETE FROM grades WHERE grade_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, gradeId);
            stmt.executeUpdate();
        }
    }

    public List<Grade> getGradesByStudentId(int studentId) throws SQLException {
        String sql = "SELECT * FROM grades WHERE student_id = ?";
        return getGradesByQuery(sql, studentId);
    }

    public List<Grade> getGradesBySubjectId(int subjectId) throws SQLException {
        String sql = "SELECT * FROM grades WHERE subject_id = ?";
        return getGradesByQuery(sql, subjectId);
    }

    public List<Grade> getAllGrades() throws SQLException {
        String sql = "SELECT * FROM grades";
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                grades.add(extractGradeFromResultSet(rs));
            }
        }
        return grades;
    }

    private List<Grade> getGradesByQuery(String sql, int param) throws SQLException {
        List<Grade> grades = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, param);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                grades.add(extractGradeFromResultSet(rs));
            }
        }
        return grades;
    }

    private Grade extractGradeFromResultSet(ResultSet rs) throws SQLException {
        Grade grade = new Grade();
        grade.setGradeId(rs.getInt("grade_id"));
        grade.setStudentId(rs.getInt("student_id"));
        grade.setSubjectId(rs.getInt("subject_id"));
        grade.setMarks(rs.getDouble("marks"));
        grade.setGrade(rs.getString("grade"));
        return grade;
    }
}
