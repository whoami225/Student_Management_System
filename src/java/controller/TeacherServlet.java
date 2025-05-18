package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/TeacherServlet")
public class TeacherServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        try {
            if ("add".equals(action)) {
                // Forward to add form
                request.getRequestDispatcher("teacher_form.jsp").forward(request, response);
            } else if ("edit".equals(action) && idParam != null) {
                int id = Integer.parseInt(idParam);
                User teacher = userDAO.getUserById(id);
                request.setAttribute("teacher", teacher);
                request.getRequestDispatcher("teacher_form.jsp").forward(request, response);
            } else if ("delete".equals(action) && idParam != null) {
                int id = Integer.parseInt(idParam);
                userDAO.deleteUser(id);
                response.sendRedirect("TeacherServlet");
            } else {
                // List all teachers
                List<User> teachers = userDAO.getAllTeachers();
                request.setAttribute("teacherList", teachers);
                request.getRequestDispatcher("teacher_list.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle add/edit submit
        String idStr = request.getParameter("id");
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String status = request.getParameter("status");

        User teacher = new User();
        teacher.setFullName(fullName);
        teacher.setEmail(email);
        teacher.setStatus(status);
        teacher.setRoleId(2); // Teacher

        try {
            if (idStr == null || idStr.isEmpty()) {
                // Add new teacher
                teacher.setPassword(password);
                userDAO.addUser(teacher);
            } else {
                // Edit teacher
                int id = Integer.parseInt(idStr);
                teacher.setUserId(id);

                if (password != null && !password.trim().isEmpty()) {
                    teacher.setPassword(password); // Update password if provided
                    userDAO.updateUserWithPassword(teacher);
                } else {
                    userDAO.updateUserWithoutPassword(teacher);
                }
            }
            response.sendRedirect("TeacherServlet");
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
}
