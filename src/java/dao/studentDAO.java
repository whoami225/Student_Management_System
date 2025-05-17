package dao;

import model.User;
import controller.DBConnection;

import java.sql.*;

public class UserDAO {

    public User getUserByEmail(String email) throws ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getInt("role_id"),
                    rs.getString("full_name"),
                    rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createUser(User user) throws ClassNotFoundException {
        String sql = "INSERT INTO users (username, email, password, role_id, full_name, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // hashed password
            ps.setInt(4, user.getRoleId());
            ps.setString(5, user.getFullName());
            ps.setString(6, user.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Additional methods: updateUser, deleteUser, validateUser etc. can be added as needed
}
