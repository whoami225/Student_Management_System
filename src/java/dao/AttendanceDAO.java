package dao;

import model.Attendance;
import controller.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    // Inserts attendance record into DB
        public boolean markAttendance(Attendance attendance) throws ClassNotFoundException {
         String sql = "INSERT INTO attendance (student_id, date, status) VALUES (?, ?, ?)";
         try (Connection conn = DBConnection.getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attendance.getStudentId());
            ps.setDate(2, new java.sql.Date(attendance.getDate().getTime()));
            ps.setString(3, attendance.getStatus());

             return ps.executeUpdate() > 0;
         } catch (SQLException e) {
             e.printStackTrace();
         }
         return false;
     }

    // Retrieves list of attendance records by student ID
    public List<Attendance> getAttendanceByStudent(int studentId) throws ClassNotFoundException {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Attendance attendance = new Attendance(
                            rs.getInt("attendance_id"),
                            rs.getInt("student_id"),
                            rs.getDate("date"),
                            rs.getString("status")
                    );
                    list.add(attendance);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
