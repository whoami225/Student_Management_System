/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import model.Attendance;

public class AttendanceDAO {
    private Connection conn;

    public AttendanceDAO(Connection conn) {
        this.conn = conn;
    }

    public void markAttendance(Attendance a) throws SQLException {
        String sql = "INSERT INTO attendance (student_id, subject_id, date, status) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, a.getStudentId());
        stmt.setInt(2, a.getSubjectId());
        stmt.setString(3, a.getDate());
        stmt.setBoolean(4, a.isStatus());
        stmt.executeUpdate();
    }

    public List<Attendance> getAttendanceByStudent(int studentId) throws SQLException {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE student_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, studentId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Attendance a = new Attendance();
            a.setAttendanceId(rs.getInt("attendance_id"));
            a.setStudentId(rs.getInt("student_id"));
            a.setSubjectId(rs.getInt("subject_id"));
            a.setDate(rs.getString("date"));
            a.setStatus(rs.getBoolean("status"));
            list.add(a);
        }

        return list;
    }
}
