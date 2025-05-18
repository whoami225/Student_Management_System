package controller;

import dao.CourseDAO;
import dao.ExamDAO;
import dao.SubjectDAO;
import model.Course;
import model.Exam;
import model.Subject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/exam")
public class ExamServlet extends HttpServlet {

    private ExamDAO examDAO;
    private SubjectDAO subjectDAO;
    private CourseDAO courseDAO;

    @Override
    public void init() {
        examDAO = new ExamDAO();
        subjectDAO = new SubjectDAO();
        courseDAO = new CourseDAO();
    }
    //e

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action) || "edit".equals(action)) {
                List<Course> courseList = courseDAO.getAllCourses();
                List<Subject> subjectList = subjectDAO.getAllSubjects();

                request.setAttribute("courseList", courseList);
                request.setAttribute("subjectList", subjectList);

                if ("edit".equals(action)) {
                    int examId = Integer.parseInt(request.getParameter("id"));
                    Exam exam = examDAO.getExamById(examId);
                    request.setAttribute("exam", exam);
                }

                // Forward once after setting attributes
                request.getRequestDispatcher("exam_form.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int examId = Integer.parseInt(request.getParameter("id"));
                examDAO.deleteExam(examId);
                response.sendRedirect("exam"); // Redirect back to list

            } else {
                List<Exam> examList = examDAO.getAllExams();
                List<Course> courseList = courseDAO.getAllCourses();
                List<Subject> subjectList = subjectDAO.getAllSubjects();

                request.setAttribute("examList", examList);
                request.setAttribute("courseList", courseList);
                request.setAttribute("subjectList", subjectList);

                request.getRequestDispatcher("exam_list.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String type = request.getParameter("exam_type");
            int courseId = Integer.parseInt(request.getParameter("course_id")); // <-- Add this
            int subjectId = Integer.parseInt(request.getParameter("subject_id"));
            Date date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("exam_date"));
            int total = Integer.parseInt(request.getParameter("total_marks"));

            // Use the constructor that includes courseId
            Exam exam = new Exam(0, type, courseId, subjectId, date, total);

            examDAO.addExam(exam);

            response.sendRedirect("exam");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

}

