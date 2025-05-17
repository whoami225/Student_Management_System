package model;

public class User {
    private int userId;
    private String username;
    private String email;
    private String password; // store hashed password
    private int roleId; // 1=Admin, 2=Teacher, 3=Student
    private String fullName;
    private String status;

    public User() {}

    public User(int userId, String username, String email, String password, int roleId, String fullName, String status) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
        this.fullName = fullName;
        this.status = status;
    }

    // Getters and setters ...
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
