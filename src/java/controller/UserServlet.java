import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NotificationDAO notificationDAO;

    @Override
    public void init() throws ServletException {
        notificationDAO = new NotificationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Notification> notifications = notificationDAO.getAllNotifications();
        request.setAttribute("notificationList", notifications);
        request.getRequestDispatcher("notification_list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String message = request.getParameter("message");
        String targetRole = request.getParameter("targetRole");

        Notification newNotification = new Notification(title, message, targetRole);
        notificationDAO.addNotification(newNotification);

        response.sendRedirect("notifications"); // Redirect back to the notification list
    }
}