package com.example.dao;

import com.example.model.Student;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    private final String JDBC_URL = "jdbc:mysql://localhost:3306/your_database_name"; // Replace with your database URL
    private final String JDBC_USER = "your_username"; // Replace with your database username
    private final String JDBC_PASSWORD = "your_password"; // Replace with your database password

    public StudentDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL 8+ driver
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Handle the exception properly (e.g., log it, throw a custom exception)
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT student_id, user_id, admission_date, batch_id, guardian_name, address FROM students";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Student student = new Student();
                student.setStudentId(resultSet.getInt("student_id"));
                student.setUserId(resultSet.getInt("user_id"));
                student.setAdmissionDate(resultSet.getDate("admission_date"));
                student.setBatchId(resultSet.getInt("batch_id"));
                student.setGuardianName(resultSet.getString("guardian_name"));
                student.setAddress(resultSet.getString("address"));
                students.add(student);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception properly
        }
        return students;
    }

    public Student getStudentById(int id) {
        Student student = null;
        String sql = "SELECT student_id, user_id, admission_date, batch_id, guardian_name, address FROM students WHERE student_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                student = new Student();
                student.setStudentId(resultSet.getInt("student_id"));
                student.setUserId(resultSet.getInt("user_id"));
                student.setAdmissionDate(resultSet.getDate("admission_date"));
                student.setBatchId(resultSet.getInt("batch_id"));
                student.setGuardianName(resultSet.getString("guardian_name"));
                student.setAddress(resultSet.getString("address"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception properly
        }
        return student;
    }

    public void addStudent(Student student) {
        String sql = "INSERT INTO students (user_id, admission_date, batch_id, guardian_name, address) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, student.getUserId());
            preparedStatement.setDate(2, new java.sql.Date(student.getAdmissionDate().getTime()));
            preparedStatement.setInt(3, student.getBatchId());
            preparedStatement.setString(4, student.getGuardianName());
            preparedStatement.setString(5, student.getAddress());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception properly
        }
    }

    public void updateStudent(Student student) {
        String sql = "UPDATE students SET user_id = ?, admission_date = ?, batch_id = ?, guardian_name = ?, address = ? WHERE student_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, student.getUserId());
            preparedStatement.setDate(2, new java.sql.Date(student.getAdmissionDate().getTime()));
            preparedStatement.setInt(3, student.getBatchId());
            preparedStatement.setString(4, student.getGuardianName());
            preparedStatement.setString(5, student.getAddress());
            preparedStatement.setInt(6, student.getStudentId());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception properly
        }
    }

    public void deleteStudent(int id) {
        String sql = "DELETE FROM students WHERE student_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception properly
        }
    }
}