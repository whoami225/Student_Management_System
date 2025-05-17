package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Assignment;

public class AssignmentDAO {
    private Connection connection;
    
    public AssignmentDAO(Connection connection) {
        this.connection = connection;
    }
    
    // Add a new assignment
    public boolean addAssignment(Assignment assignment) {
        String sql = "INSERT INTO assignments (subject_id, title, description, upload_date, due_date, file_path) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, assignment.getSubjectId());
            statement.setString(2, assignment.getTitle());
            statement.setString(3, assignment.getDescription());
            statement.setTimestamp(4, new Timestamp(assignment.getUploadDate().getTime()));
            statement.setTimestamp(5, new Timestamp(assignment.getDueDate().getTime()));
            statement.setString(6, assignment.getFilePath());
            
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all assignments
    public List<Assignment> getAllAssignments() {
        List<Assignment> assignments = new ArrayList<>();
        String sql = "SELECT * FROM assignments ORDER BY due_date ASC";
        
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                Assignment assignment = new Assignment();
                assignment.setAssignmentId(resultSet.getInt("assignment_id"));
                assignment.setSubjectId(resultSet.getInt("subject_id"));
                assignment.setTitle(resultSet.getString("title"));
                assignment.setDescription(resultSet.getString("description"));
                assignment.setUploadDate(resultSet.getTimestamp("upload_date"));
                assignment.setDueDate(resultSet.getTimestamp("due_date"));
                assignment.setFilePath(resultSet.getString("file_path"));
                
                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return assignments;
    }
    
    // Get assignments by subject (optional)
    public List<Assignment> getAssignmentsBySubject(int subjectId) {
        List<Assignment> assignments = new ArrayList<>();
        String sql = "SELECT * FROM assignments WHERE subject_id = ? ORDER BY due_date ASC";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, subjectId);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Assignment assignment = new Assignment();
                assignment.setAssignmentId(resultSet.getInt("assignment_id"));
                assignment.setSubjectId(resultSet.getInt("subject_id"));
                assignment.setTitle(resultSet.getString("title"));
                assignment.setDescription(resultSet.getString("description"));
                assignment.setUploadDate(resultSet.getTimestamp("upload_date"));
                assignment.setDueDate(resultSet.getTimestamp("due_date"));
                assignment.setFilePath(resultSet.getString("file_path"));
                
                assignments.add(assignment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return assignments;
    }
}