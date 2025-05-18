package dao;

import model.Assignment;
import controller.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO {

    public boolean addAssignment(Assignment assignment) {
        String sql = "INSERT INTO assignments (subject_id, title, description, upload_date, due_date, file_path) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, assignment.getSubjectId());
            ps.setString(2, assignment.getTitle());
            ps.setString(3, assignment.getDescription());
            ps.setDate(4, new java.sql.Date(assignment.getUploadDate().getTime()));
            ps.setDate(5, new java.sql.Date(assignment.getDueDate().getTime()));
            ps.setString(6, assignment.getFilePath());

            return ps.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Assignment> getAssignmentsBySubject(int subjectId) {
        List<Assignment> list = new ArrayList<>();
        String sql = "SELECT * FROM assignments WHERE subject_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, subjectId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Assignment(
                        rs.getInt("assignment_id"),
                        rs.getInt("subject_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getDate("upload_date"),
                        rs.getDate("due_date"),
                        rs.getString("file_path")
                    ));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Assignment> getAllAssignments() {
        List<Assignment> list = new ArrayList<>();
        String sql = "SELECT * FROM assignments";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Assignment(
                    rs.getInt("assignment_id"),
                    rs.getInt("subject_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getDate("upload_date"),
                    rs.getDate("due_date"),
                    rs.getString("file_path")
                ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }
}
