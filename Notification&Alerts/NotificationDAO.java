package dao;

import model.Notification;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {
    private Connection connection;

    public NotificationDAO(Connection connection) {
        this.connection = connection;
    }

    // Add a new notification to the database
    public boolean addNotification(Notification notification) {
        String sql = "INSERT INTO notifications (title, message, target_role, date_posted) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, notification.getTitle());
            statement.setString(2, notification.getMessage());
            statement.setString(3, notification.getTargetRole());
            statement.setTimestamp(4, new Timestamp(notification.getDatePosted().getTime()));
            
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all notifications from the database
    public List<Notification> getAllNotifications() {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM notifications ORDER BY date_posted DESC";
        
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                Notification notification = new Notification();
                notification.setNotificationId(resultSet.getInt("notification_id"));
                notification.setTitle(resultSet.getString("title"));
                notification.setMessage(resultSet.getString("message"));
                notification.setTargetRole(resultSet.getString("target_role"));
                notification.setDatePosted(resultSet.getTimestamp("date_posted"));
                
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return notifications;
    }

    // Get notifications for a specific role
    public List<Notification> getNotificationsByRole(String role) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE target_role = ? OR target_role = 'All' ORDER BY date_posted DESC";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, role);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Notification notification = new Notification();
                notification.setNotificationId(resultSet.getInt("notification_id"));
                notification.setTitle(resultSet.getString("title"));
                notification.setMessage(resultSet.getString("message"));
                notification.setTargetRole(resultSet.getString("target_role"));
                notification.setDatePosted(resultSet.getTimestamp("date_posted"));
                
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return notifications;
    }
}