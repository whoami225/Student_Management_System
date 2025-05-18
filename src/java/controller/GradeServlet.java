package controller;

import dao.ExamDAO;
import dao.GradeDAO;
import dao.StudentDAO;
import model.Exam;
import model.Grade;
import model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/grade")
public class GradeServlet extends HttpServlet {

    private GradeDAO gradeDAO;
    private ExamDAO examDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() {
        gradeDAO = new GradeDAO();
        examDAO = new ExamDAO();
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Exam> examList = null;
        try {
            examList = examDAO.getExamsBySubject(1); // Replace with dynamic subject if needed
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GradeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        List<Student> studentList = null;
        try {
            studentList = studentDAO.getAllStudents();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GradeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("examList", examList);
        request.setAttribute("studentList", studentList);
        request.getRequestDispatcher("grade_entry.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int examId = Integer.parseInt(request.getParameter("exam_id"));
        String[] studentIds = request.getParameterValues("student_id");

        for (String sid : studentIds) {
            int studentId = Integer.parseInt(sid);
            int marks = Integer.parseInt(request.getParameter("marks_" + sid));
            try {
                gradeDAO.addGrade(new Grade(0, studentId, examId, marks));
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(GradeServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        response.sendRedirect("grade");
    }
}
