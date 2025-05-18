package controller;

import dao.GradeDAO;
import model.Grade;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

public class GradeServlet extends HttpServlet {
    private GradeDAO gradeDAO;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/yourdb", "user", "pass"
            );
            gradeDAO = new GradeDAO(conn);
        } catch (Exception e) {
            throw new RuntimeException("Database connection failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            double marks = Double.parseDouble(request.getParameter("marks"));

            Grade grade = new Grade();
            grade.setStudentId(studentId);
            grade.setSubjectId(subjectId);
            grade.setMarks(marks);
            grade.assignGradeFromMarks();

            gradeDAO.addGrade(grade);
            response.sendRedirect("GradeServlet");
        } catch (Exception e) {
            throw new ServletException("Error submitting grade", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String student = request.getParameter("studentId");
        String subject = request.getParameter("subjectId");
        List<Grade> grades;

        try {
            if (student != null && !student.trim().isEmpty()) {
                grades = gradeDAO.getGradesByStudentId(Integer.parseInt(student));
            } else if (subject != null && !subject.trim().isEmpty()) {
                grades = gradeDAO.getGradesBySubjectId(Integer.parseInt(subject));
            } else {
                grades = gradeDAO.getAllGrades();
            }

            request.setAttribute("grades", grades);
            RequestDispatcher dispatcher = request.getRequestDispatcher("grade_list.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error fetching grade list", e);
        }
    }
}
