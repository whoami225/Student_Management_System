package com.schoolmanagement.dao;

import com.schoolmanagement.model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private Connection connection;
    
    public StudentDAO(Connection connection) {
        this.connection = connection;
    }
    
    // Get all students
    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String query = "SELECT * FROM students";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Student student = new Student();
                student.setStudentId(rs.getInt("student_id"));
                student.setUserId(rs.getInt("user_id"));
                student.setAdmissionDate(rs.getDate("admission_date"));
                student.setBatchId(rs.getInt("batch_id"));
                student.setGuardianName(rs.getString("guardian_name"));
                student.setAddress(rs.getString("address"));
                students.add(student);
            }
        }
        return students;
    }
    
    // Get student by ID
    public Student getStudentById(int id) throws SQLException {
        Student student = null;
        String query = "SELECT * FROM students WHERE student_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                student = new Student();
                student.setStudentId(rs.getInt("student_id"));
                student.setUserId(rs.getInt("user_id"));
                student.setAdmissionDate(rs.getDate("admission_date"));
                student.setBatchId(rs.getInt("batch_id"));
                student.setGuardianName(rs.getString("guardian_name"));
                student.setAddress(rs.getString("address"));
            }
        }
        return student;
    }
    
    // Add new student
    public boolean addStudent(Student student) throws SQLException {
        String query = "INSERT INTO students (user_id, admission_date, batch_id, guardian_name, address) VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, student.getUserId());
            pstmt.setDate(2, new java.sql.Date(student.getAdmissionDate().getTime()));
            pstmt.setInt(3, student.getBatchId());
            pstmt.setString(4, student.getGuardianName());
            pstmt.setString(5, student.getAddress());
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // Update student
    public boolean updateStudent(Student student) throws SQLException {
        String query = "UPDATE students SET user_id = ?, admission_date = ?, batch_id = ?, guardian_name = ?, address = ? WHERE student_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, student.getUserId());
            pstmt.setDate(2, new java.sql.Date(student.getAdmissionDate().getTime()));
            pstmt.setInt(3, student.getBatchId());
            pstmt.setString(4, student.getGuardianName());
            pstmt.setString(5, student.getAddress());
            pstmt.setInt(6, student.getStudentId());
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // Delete student
    public boolean deleteStudent(int id) throws SQLException {
        String query = "DELETE FROM students WHERE student_id = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        }
    }
}