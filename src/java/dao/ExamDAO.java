package dao;

import model.Exam;
import controller.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExamDAO {

    public boolean addExam(Exam exam) throws ClassNotFoundException {
        String sql = "INSERT INTO exams (exam_type, course_id, subject_id, exam_date, total_marks) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, exam.getExamType());
            ps.setInt(2, exam.getCourseId());
            ps.setInt(3, exam.getSubjectId());
            ps.setDate(4, new java.sql.Date(exam.getExamDate().getTime()));
            ps.setInt(5, exam.getTotalMarks());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public List<Exam> getAllExams() throws ClassNotFoundException {
        List<Exam> exams = new ArrayList<>();
        String sql = "SELECT * FROM exams";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Exam exam = new Exam(
                        rs.getInt("exam_id"),
                        rs.getString("exam_type"),
                        rs.getInt("course_id"),
                        rs.getInt("subject_id"),
                        rs.getDate("exam_date"),
                        rs.getInt("total_marks")
                );
                exams.add(exam);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exams;
    }


    public List<Exam> getExamsBySubject(int subjectId) throws ClassNotFoundException {
        List<Exam> exams = new ArrayList<>();
        String sql = "SELECT * FROM exams WHERE subject_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subjectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Exam exam = new Exam(
                        rs.getInt("exam_id"),
                        rs.getString("exam_type"),
                        rs.getInt("course_id"),
                        rs.getInt("subject_id"),
                        rs.getDate("exam_date"),
                        rs.getInt("total_marks")
                );
                exams.add(exam);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exams;
    }

    public Exam getExamById(int examId) throws ClassNotFoundException {
        Exam exam = null;
        String sql = "SELECT * FROM exams WHERE exam_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, examId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exam = new Exam(
                        rs.getInt("exam_id"),
                        rs.getString("exam_type"),
                        rs.getInt("course_id"),
                        rs.getInt("subject_id"),
                        rs.getDate("exam_date"),
                        rs.getInt("total_marks")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exam;
    }

    public boolean deleteExam(int examId) throws ClassNotFoundException {
        String sql = "DELETE FROM exams WHERE exam_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, examId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }



}

