import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/student_management"; // Replace with your database URL
    private String jdbcUsername = "root"; // Replace with your database username
    private String jdbcPassword = "password"; // Replace with your database password

    private static final String INSERT_NOTIFICATION = "INSERT INTO notifications (title, message, target_role, date_posted) VALUES (?, ?, ?, ?)";
    private static final String SELECT_ALL_NOTIFICATIONS = "SELECT * FROM notifications ORDER BY date_posted DESC";
    private static final String SELECT_NOTIFICATIONS_BY_ROLE = "SELECT * FROM notifications WHERE target_role = ? ORDER BY date_posted DESC";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Replace with your database driver
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void addNotification(Notification notification) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_NOTIFICATION)) {
            preparedStatement.setString(1, notification.getTitle());
            preparedStatement.setString(2, notification.getMessage());
            preparedStatement.setString(3, notification.getTargetRole());
            preparedStatement.setTimestamp(4, notification.getDatePosted());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Notification> getAllNotifications() {
        List<Notification> notifications = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_NOTIFICATIONS);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                int id = resultSet.getInt("notification_id");
                String title = resultSet.getString("title");
                String message = resultSet.getString("message");
                String targetRole = resultSet.getString("target_role");
                java.sql.Timestamp datePosted = resultSet.getTimestamp("date_posted");
                notifications.add(new Notification(id, title, message, targetRole, datePosted));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public List<Notification> getNotificationsByRole(String role) {
        List<Notification> notifications = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_NOTIFICATIONS_BY_ROLE)) {
            preparedStatement.setString(1, role);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int id = resultSet.getInt("notification_id");
                    String title = resultSet.getString("title");
                    String message = resultSet.getString("message");
                    String targetRole = resultSet.getString("target_role");
                    java.sql.Timestamp datePosted = resultSet.getTimestamp("date_posted");
                    notifications.add(new Notification(id, title, message, targetRole, datePosted));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }
}