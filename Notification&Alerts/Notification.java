package model;

import java.util.Date;

public class Notification {
    private int notificationId;
    private String title;
    private String message;
    private String targetRole; // "Student", "Teacher", or "All"
    private Date datePosted;

    public Notification() {
    }

    public Notification(int notificationId, String title, String message, String targetRole, Date datePosted) {
        this.notificationId = notificationId;
        this.title = title;
        this.message = message;
        this.targetRole = targetRole;
        this.datePosted = datePosted;
    }

    // Getters and Setters
    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getTargetRole() {
        return targetRole;
    }

    public void setTargetRole(String targetRole) {
        this.targetRole = targetRole;
    }

    public Date getDatePosted() {
        return datePosted;
    }

    public void setDatePosted(Date datePosted) {
        this.datePosted = datePosted;
    }
}