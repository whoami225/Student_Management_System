package servlet;

import dao.NotificationDAO;
import model.Notification;
import util.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {
    private NotificationDAO notificationDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            Connection connection = DatabaseConnection.getConnection();
            notificationDAO = new NotificationDAO(connection);
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize NotificationDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String role = request.getParameter("role"); // Optional parameter to filter by role
            
            List<Notification> notifications;
            if (role != null && !role.isEmpty()) {
                notifications = notificationDAO.getNotificationsByRole(role);
            } else {
                notifications = notificationDAO.getAllNotifications();
            }
            
            request.setAttribute("notifications", notifications);
            request.getRequestDispatcher("/notification_list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving notifications");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String message = request.getParameter("message");
            String targetRole = request.getParameter("targetRole");
            
            Notification notification = new Notification();
            notification.setTitle(title);
            notification.setMessage(message);
            notification.setTargetRole(targetRole);
            notification.setDatePosted(new Date());
            
            boolean success = notificationDAO.addNotification(notification);
            
            if (success) {
                request.setAttribute("successMessage", "Notification created successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to create notification");
            }
            
            // Redirect to the form or list page
            request.getRequestDispatcher("/notification_form.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error creating notification");
        }
    }
}