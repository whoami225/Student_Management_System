package dao;

import model.Subject;
import controller.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {

    public boolean createSubject(Subject subject) throws ClassNotFoundException {
        String sql = "INSERT INTO subjects (subject_name, course_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, subject.getSubjectName());
            ps.setInt(2, subject.getCourseId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public List<Subject> getAllSubjects() throws ClassNotFoundException {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT * FROM subjects";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Subject s = new Subject(
                        rs.getInt("subject_id"),
                        rs.getString("subject_name"),
                        rs.getInt("course_id") // Add if your Subject model has it
                );
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get all subjects assigned to a specific teacher (by teacher's user ID)
    public List<Subject> getSubjectsByTeacherId(int teacherUserId) throws ClassNotFoundException {
        List<Subject> subjects = new ArrayList<>();
        // Assumes you have a table `teacher_subjects` linking teacher_user_id and subject_id
        // Adjust table/column names to match your DB schema
        String sql = "SELECT s.* FROM subjects s " +
                "JOIN teacher_subjects ts ON s.subject_id = ts.subject_id " +
                "WHERE ts.teacher_user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, teacherUserId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Subject subject = new Subject();
                    subject.setSubjectId(rs.getInt("subject_id"));
                    subject.setSubjectName(rs.getString("subject_name"));
                    subject.setCourseId(rs.getInt("course_id"));
                    subjects.add(subject);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subjects;
    }


    public List<Subject> getSubjectsByCourse(int courseId) throws ClassNotFoundException {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT * FROM subjects WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setCourseId(rs.getInt("course_id"));
                list.add(subject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
