package controller;

import dao.StudentDAO;
import dao.UserDAO;
import dao.CourseDAO;
import dao.AssignmentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private StudentDAO studentDAO;
    private UserDAO userDAO;
    private CourseDAO courseDAO;
    private AssignmentDAO assignmentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
        userDAO = new UserDAO();
        courseDAO = new CourseDAO();
        assignmentDAO = new AssignmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int studentCount = 0;
        try {
            studentCount = studentDAO.getAllStudents().size();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DashboardServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        int userCount = 0;
        try {
            userCount = userDAO.getAllUsers().size();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DashboardServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        int courseCount = 0;
        try {
            courseCount = courseDAO.getAllCourses().size();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DashboardServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        int assignmentCount = 0;
        assignmentCount = assignmentDAO.getAssignmentsBySubject(1).size(); // simplified

        request.setAttribute("studentCount", studentCount);
        request.setAttribute("userCount", userCount);
        request.setAttribute("courseCount", courseCount);
        request.setAttribute("assignmentCount", assignmentCount);

        request.getRequestDispatcher("dashboard_admin.jsp").forward(request, response);
    }
}
