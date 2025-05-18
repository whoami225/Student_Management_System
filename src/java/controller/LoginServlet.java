package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            if (userDAO.validateUser(email, password)) {
                User user = userDAO.getUserByEmail(email);
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                int roleId = user.getRoleId();
                
                switch (roleId) {
                    case 1:
                        request.getRequestDispatcher("dashboard_admin.jsp").forward(request, response);
                        break;
                    case 2:
                        request.getRequestDispatcher("dashboard_teacher.jsp").forward(request, response);
                        break;
                    case 3:
                        request.getRequestDispatcher("dashboard_student.jsp").forward(request, response);
                        break;
                    default:
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        break;
                }
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
