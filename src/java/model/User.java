package model;

import java.io.Serializable;

public class User implements Serializable {
    private int userId;
    private int roleId;
    private String username;
    private String email;
    private String password;
    private String fullName;
    private String status;

    public User() {}

    public User(int userId, int roleId, String username, String email, String password, String fullName, String status) {
        this.userId = userId;
        this.roleId = roleId;
        this.username = username;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.status = status;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
