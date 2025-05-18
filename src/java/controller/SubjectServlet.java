package controller;

import dao.CourseDAO;
import dao.SubjectDAO;
import model.Course;
import model.Subject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/subject")
public class SubjectServlet extends HttpServlet {

    private SubjectDAO subjectDAO;
    private CourseDAO courseDAO;

    @Override
    public void init() {
        subjectDAO = new SubjectDAO();
        courseDAO = new CourseDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    // Show the form for creating a new subject
                    request.setAttribute("courseList", courseDAO.getAllCourses());
                    request.getRequestDispatcher("subject_form.jsp").forward(request, response);
                    break;

                case "list":
                default:
                    // Always handle subject listing here
                    List<Course> courseList = courseDAO.getAllCourses();
                    int courseId = 1; // default course id
                    if (request.getParameter("course_id") != null) {
                        courseId = Integer.parseInt(request.getParameter("course_id"));
                    }
                    List<Subject> subjectList = subjectDAO.getSubjectsByCourse(courseId);

                    request.setAttribute("subjectList", subjectList);
                    request.setAttribute("courseList", courseList);
                    request.setAttribute("selectedCourseId", courseId);
                    request.getRequestDispatcher("subject_list.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String subjectName = request.getParameter("subject_name");
            int courseId = Integer.parseInt(request.getParameter("course_id"));

            Subject subject = new Subject(0, subjectName, courseId);
            boolean success = subjectDAO.createSubject(subject);

            if (success) {
                // Redirect to list subjects of the course after successful creation
                response.sendRedirect("subject?action=list&course_id=" + courseId);
            } else {
                request.setAttribute("error", "Failed to create subject.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to create subject: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
