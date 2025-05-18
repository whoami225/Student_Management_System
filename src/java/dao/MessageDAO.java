package dao;

import model.Message;
import controller.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {

    public boolean sendMessage(Message message) throws ClassNotFoundException {
        String sql = "INSERT INTO messages (sender_id, receiver_id, message_text) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, message.getSenderId());
            ps.setInt(2, message.getReceiverId());
            ps.setString(3, message.getMessageText());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Message> getMessagesForUser(int userId) throws ClassNotFoundException {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM messages WHERE receiver_id = ? ORDER BY sent_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Message msg = new Message(
                    rs.getInt("message_id"),
                    rs.getInt("sender_id"),
                    rs.getInt("receiver_id"),
                    rs.getString("message_text"),
                    rs.getTimestamp("sent_at"),
                    rs.getBoolean("is_read")
                );
                messages.add(msg);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }
    
    public List<Message> getMessagesBetweenRoles(int userId, int senderRole, int receiverRole) throws ClassNotFoundException {
    List<Message> messages = new ArrayList<>();
    String sql = "SELECT m.* FROM messages m " +
                 "JOIN users s ON m.sender_id = s.user_id " +
                 "JOIN users r ON m.receiver_id = r.user_id " +
                 "WHERE ((m.sender_id = ? AND r.role_id = ?) OR (m.receiver_id = ? AND s.role_id = ?)) " +
                 "ORDER BY m.sent_at DESC";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setInt(2, receiverRole);
        ps.setInt(3, userId);
        ps.setInt(4, senderRole);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            messages.add(new Message(
                rs.getInt("message_id"),
                rs.getInt("sender_id"),
                rs.getInt("receiver_id"),
                rs.getString("message_text"),
                rs.getTimestamp("sent_at"),
                rs.getBoolean("is_read")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return messages;
}
public List<Message> getReceivedMessagesBySenderRoles(int receiverId, List<Integer> senderRoles) throws ClassNotFoundException {
    List<Message> messages = new ArrayList<>();
    // Compose a SQL query with IN clause for senderRoles
    StringBuilder sql = new StringBuilder("SELECT m.* FROM messages m JOIN users u ON m.sender_id = u.user_id WHERE m.receiver_id = ? AND u.role_id IN (");
    for (int i = 0; i < senderRoles.size(); i++) {
        sql.append("?");
        if (i < senderRoles.size() - 1) sql.append(",");
    }
    sql.append(") ORDER BY m.sent_at DESC");

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        ps.setInt(1, receiverId);
        for (int i = 0; i < senderRoles.size(); i++) {
            ps.setInt(i + 2, senderRoles.get(i));
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            messages.add(new Message(
                rs.getInt("message_id"),
                rs.getInt("sender_id"),
                rs.getInt("receiver_id"),
                rs.getString("message_text"),
                rs.getTimestamp("sent_at"),
                rs.getBoolean("is_read")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return messages;
}
public List<Message> getReceivedMessagesForUser(int userId) throws ClassNotFoundException {
    List<Message> messages = new ArrayList<>();
    String sql = "SELECT * FROM messages WHERE receiver_id = ? ORDER BY sent_at DESC";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            messages.add(new Message(
                rs.getInt("message_id"),
                rs.getInt("sender_id"),
                rs.getInt("receiver_id"),
                rs.getString("message_text"),
                rs.getTimestamp("sent_at"),
                rs.getBoolean("is_read")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return messages;
}


    // Optional: add markAsRead, deleteMessage etc.
}
