package dao;

import model.Role;
import controller.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO {

    public List<Role> getAllRoles() throws ClassNotFoundException {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT * FROM roles";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                roles.add(new Role(
                    rs.getInt("role_id"),
                    rs.getString("role_name")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }

    public String getRoleNameById(int roleId) throws ClassNotFoundException {
        String sql = "SELECT role_name FROM roles WHERE role_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("role_name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
