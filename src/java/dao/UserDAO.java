package dao;

import model.User;
import controller.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public boolean validateUser(String email, String password) throws ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // User exists
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmail(String email) throws ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setRoleId(rs.getInt("role_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setStatus(rs.getString("status"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

            // New: Returns the generated user_id
        public int createUser(User user) throws ClassNotFoundException {
            String sql = "INSERT INTO users (role_id, username, email, password, full_name, status) VALUES (?, ?, ?, ?, ?, ?)";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, user.getRoleId());
                ps.setString(2, user.getUsername());
                ps.setString(3, user.getEmail());
                ps.setString(4, user.getPassword());
                ps.setString(5, user.getFullName());
                ps.setString(6, user.getStatus());
                int affectedRows = ps.executeUpdate();
                if (affectedRows > 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            return rs.getInt(1); // Return the new user_id
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return 0; // 0 if failed
        }


    public List<User> getAllUsers() throws ClassNotFoundException {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setRoleId(rs.getInt("role_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setStatus(rs.getString("status"));
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public boolean updateUser(User user) throws ClassNotFoundException {
        String sql = "UPDATE users SET role_id=?, username=?, email=?, password=?, full_name=?, status=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getRoleId());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getFullName());
            ps.setString(6, user.getStatus());
            ps.setInt(7, user.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int userId) throws ClassNotFoundException {
        String sql = "DELETE FROM users WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<User> getAllTeachers() throws ClassNotFoundException {
    List<User> teacherList = new ArrayList<>();
    String sql = "SELECT * FROM users WHERE role_id = 2";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            User user = new User();
            user.setUserId(rs.getInt("user_id"));
            user.setRoleId(rs.getInt("role_id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setFullName(rs.getString("full_name"));
            user.setStatus(rs.getString("status"));
            teacherList.add(user);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return teacherList;
}
        public User getUserById(int userId) throws ClassNotFoundException {
         String sql = "SELECT * FROM users WHERE user_id = ?";
         try (Connection conn = DBConnection.getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setInt(1, userId);
             ResultSet rs = ps.executeQuery();
             if (rs.next()) {
                 User user = new User();
                 user.setUserId(rs.getInt("user_id"));
                 user.setRoleId(rs.getInt("role_id"));
                 user.setUsername(rs.getString("username"));
                 user.setEmail(rs.getString("email"));
                 user.setPassword(rs.getString("password"));
                 user.setFullName(rs.getString("full_name"));
                 user.setStatus(rs.getString("status"));
                 return user;
             }
         } catch (SQLException e) {
             e.printStackTrace();
         }
         return null;
     }
        
        public boolean updateUserWithoutPassword(User user) throws ClassNotFoundException {
    String sql = "UPDATE users SET role_id=?, username=?, email=?, full_name=?, status=? WHERE user_id=?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, user.getRoleId());
        ps.setString(2, user.getUsername());
        ps.setString(3, user.getEmail());
        ps.setString(4, user.getFullName());
        ps.setString(5, user.getStatus());
        ps.setInt(6, user.getUserId());
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    public void addUser(User user) throws ClassNotFoundException {
    this.createUser(user);
}


   public void updateUserWithPassword(User user) throws ClassNotFoundException {
    this.updateUser(user);
}

   public List<User> getUsersByRole(int roleId) throws ClassNotFoundException {
    List<User> users = new ArrayList<>();
    String sql = "SELECT * FROM users WHERE role_id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, roleId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            User u = new User();
            u.setUserId(rs.getInt("user_id"));
            u.setFullName(rs.getString("full_name"));
            u.setRoleId(rs.getInt("role_id"));
            // set other fields if needed
            users.add(u);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return users;
}

    
}
