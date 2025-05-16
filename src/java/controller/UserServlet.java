package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            try {
                User user = userDAO.getUserByEmail(email);
                if (user != null && PasswordUtils.verifyPassword(password, user.getPassword())) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    // Redirect based on role
                    switch (user.getRoleId()) {
                        case 1 -> response.sendRedirect("dashboard_admin.jsp");
                        case 2 -> response.sendRedirect("dashboard_teacher.jsp");
                        case 3 -> response.sendRedirect("dashboard_student.jsp");
                        default -> response.sendRedirect("login.jsp");
                    }
                } else {
                    request.setAttribute("error", "Invalid email or password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else if ("register".equals(action)) {
            // Implement registration logic here if needed
        }
    }
}
